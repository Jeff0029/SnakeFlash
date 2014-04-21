package Gameplay 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.MultiRenderer;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.Components.StaticRenderer;
	import Engine.EntityComponent.GameObject;
	import Engine.EntityComponent.GameObjectNode;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import Gameplay.DirectionEnum;
	import Engine.EntityComponent.GameObjectList;
	import Input.InputKeyManager;
	import Gameplay.PooledSnake;
	import Engine.Graphics.TextureBank;
	import flash.events.Event;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author Jean-Francois Vienneau
	 */
	public class Snake extends Component
	{
		var size:Number;
		const STARTING_SIZE:Number = 5;
		var direction:DirectionEnum = new DirectionEnum();
		var snakeList:GameObjectList = new GameObjectList();
		var newPos:Vector2 = Vector2.Zero;
		private var main:Main;
		var isDead:Boolean = false;
		var GameOverTextGO:GameObject;
		var GameOverRetryGO:GameObject;
		var GameOverExitGO:GameObject;
		public function Snake(main:Main) 
		{
			isDead = false;
			this.main = main;
			direction = DirectionEnum.right;
			for (var i:int = 0; i < STARTING_SIZE; i++) 
			{
				Grow(new Vector2(i, 0));
			}	
		}
		
		public override function Update() : void
		{
			if (!isDead)
			{
				if (InputKeyManager.CheckKeyPress(InputKeyManager.UP_ARROW) && direction != DirectionEnum.down)
					direction = DirectionEnum.up;
				else if (InputKeyManager.CheckKeyPress(InputKeyManager.DOWN_ARROW) && direction != DirectionEnum.up)
					direction = DirectionEnum.down;
				else if (InputKeyManager.CheckKeyPress(InputKeyManager.LEFT_ARROW) && direction != DirectionEnum.right)
					direction = DirectionEnum.left;
				else if (InputKeyManager.CheckKeyPress(InputKeyManager.RIGHT_ARROW) && direction != DirectionEnum.left)
					direction = DirectionEnum.right;
				
				switch(direction)
				{
					case DirectionEnum.up:
						newPos = new Vector2(GetSnakePartCoord(snakeList.head.gameObject).X, 
						GetSnakePartCoord(snakeList.head.gameObject).Y - 1);
						break;
					case DirectionEnum.down:
						newPos = new Vector2(GetSnakePartCoord(snakeList.head.gameObject).X, 
						GetSnakePartCoord(snakeList.head.gameObject).Y + 1);
						break;
					case DirectionEnum.left:
						newPos = new Vector2(GetSnakePartCoord(snakeList.head.gameObject).X - 1, 
						GetSnakePartCoord(snakeList.head.gameObject).Y);
						break;
					case DirectionEnum.right:
						newPos = new Vector2(GetSnakePartCoord(snakeList.head.gameObject).X + 1, 
						GetSnakePartCoord(snakeList.head.gameObject).Y);
						break;
				}
				
				// check if the movement is out of bound or collided with ourself
				if (newPos.X < 0 || newPos.X >= Tiles.COLUMNS || newPos.Y < 0 || newPos.Y >= Tiles.ROWS || Tiles.GetTileState(newPos.X, newPos.Y) == TileEnum.snakePart)
				{
					trace("YOU LOOSE");
					YouLost();
					isDead = true;
					return;
				}
				if (Tiles.GetTileState(newPos.X, newPos.Y) == TileEnum.snakeFood)
				{
					Tiles.SetTileState(newPos.X, newPos.Y, TileEnum.empty);
					main.FoodGO.SetFood();
					Grow(GetSnakePartCoord(snakeList.head.gameObject));
					MoveWholeSnake(newPos.X, newPos.Y, snakeList);
					trace("FOOOD");
				}
				else
				{
					MoveWholeSnake(newPos.X, newPos.Y, snakeList);
				}	
			}
		}
		
		function Grow(position:Vector2)
		{
			snakeList.Add(PooledSnake.Create() as GameObjectNode);
			snakeList.head.gameObject = new GameObject();
			snakeList.head.gameObject.CTransform.Position = GiveTilePosition(position.X, position.Y);
			Tiles.SetTileState(position.X, position.Y, TileEnum.snakePart);
			snakeList.head.gameObject.AddComponent(new SnakePart(position.X, position.Y));
			snakeList.head.gameObject.AddComponent(new CellRenderer(TextureBank.snakeStraightUpTex, main));
			snakeList.head.gameObject.AddComponent(new Animator(5));
			main.scene.Add(snakeList.head.gameObject);
		}
		
		function Shrink(amount:int)
		{
			for (var i:int = 0; i < amount; i++)
			{
				snakeList.head.gameObject.CRenderer.SetVisible(false);
				Tiles.SetTileState(GetSnakePartCoord(snakeList.head.gameObject).X, GetSnakePartCoord(snakeList.head.gameObject).Y, TileEnum.empty);
				(snakeList.head as PooledSnake).Recycle();
				(snakeList.head as PooledSnake).RemoveFromList();
			}
		}
		
		function Reset(event:CustomEvent):void 
		{
			trace("Reset");
			GameOverTextGO.CRenderer.SetVisible(false);
			GameOverRetryGO.CRenderer.SetVisible(false);
			GameOverExitGO.CRenderer.SetVisible(false);
			isDead = false;
			direction = DirectionEnum.right;
			Shrink(snakeList.count - STARTING_SIZE);
			MoveWholeSnake(0, 0, snakeList);
		}
		
		function GetSnakePartCoord(snakePart:GameObject):Vector2
		{
			return new Vector2((snakePart.GetComponent(SnakePart) as SnakePart).tilePosX, (snakePart.GetComponent(SnakePart) as SnakePart).tilePosY);
		}
		
		function SetSnakePartCoord(snakePart:GameObject, coord:Vector2)
		{
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosX = coord.X;
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosY = coord.Y;
		}
		
		function MoveSnakePart(x:int, y:int, head:GameObjectNode)
		{
			SetSnakePartCoord(head.gameObject, new Vector2(x, y));
			head.gameObject.CTransform.Position = GiveTilePosition(x, y);
		}
		
		function MoveWholeSnake(x:int, y:int, objsToMove:GameObjectList)
		{
			var currentObj: GameObjectNode = objsToMove.head;
			var lastPos:Vector2 = currentObj.gameObject.CTransform.Position;
			var lastCoord:Vector2 = GetSnakePartCoord(currentObj.gameObject);
			
			// Move first
			MoveSnakePart(x, y, objsToMove.head);
			var tempCoord:Vector2;
			// Move all but first
			for (var i:int = 0; i < objsToMove.count-1; i++)
			{
				currentObj = currentObj.Next;
				var tempPos:Vector2 = currentObj.gameObject.CTransform.Position;
				tempCoord = GetSnakePartCoord(currentObj.gameObject);
				Tiles.SetTileState(tempCoord.X, tempCoord.Y, TileEnum.snakePart);
				SetSnakePartCoord(currentObj.gameObject, lastCoord);
				currentObj.gameObject.CTransform.Position = lastPos;
				lastCoord = tempCoord;
				lastPos = tempPos;
			}
			Tiles.SetTileState(tempCoord.X, tempCoord.Y, TileEnum.empty);
		}
		
		function YouLost()
		{		
			GameOverTextGO = new GameObject();
			GameOverTextGO.AddComponent(new StaticRenderer(TextureBank.gameOverTitleTex, main));
			GameOverTextGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/3));
			main.scene.Add(GameOverTextGO);
			
			var mutliBitmapsRetry : Vector.<BitmapData> = new Vector.<BitmapData>();
			mutliBitmapsRetry.push(TextureBank.gameOverRetryTex, TextureBank.gameOverRetrySelectedTex);
			
			GameOverRetryGO = new GameObject();
			GameOverRetryGO.AddComponent(new MultiRenderer(mutliBitmapsRetry, main));
			GameOverRetryGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width / 2, TextureBank.backgroundTex.height / 3 + TextureBank.gameOverTitleTex.height));
			(GameOverRetryGO.CRenderer as MultiRenderer).DisplaySprite(0);
			main.scene.Add(GameOverRetryGO);
			
			var mutliBitmapsExit : Vector.<BitmapData> = new Vector.<BitmapData>();
			mutliBitmapsExit.push(TextureBank.gameOverExitTex, TextureBank.gameOverExitSelectedTex);
			
			GameOverExitGO = new GameObject();
			GameOverExitGO.AddComponent(new MultiRenderer(mutliBitmapsExit, main));
			GameOverExitGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width / 2, TextureBank.backgroundTex.height / 3 + TextureBank.gameOverTitleTex.height + TextureBank.gameOverRetryTex.height));
			(GameOverExitGO.CRenderer as MultiRenderer).DisplaySprite(0);
			main.scene.Add(GameOverExitGO);
			
			Main.dispatch.addEventListener(CustomEvent.RESET, Reset);
			
			GameOverRetryGO.CRenderer.AddEventListener(MouseEvent.ROLL_OVER, Main.ChangeButtonState(GameOverRetryGO, InputEnum.retry));
			GameOverRetryGO.CRenderer.AddEventListener(MouseEvent.ROLL_OUT, Main.ChangeButtonState(GameOverRetryGO, InputEnum.none));
			
			GameOverExitGO.CRenderer.AddEventListener(MouseEvent.ROLL_OVER, Main.ChangeButtonState(GameOverExitGO, InputEnum.exit));
			GameOverExitGO.CRenderer.AddEventListener(MouseEvent.ROLL_OUT, Main.ChangeButtonState(GameOverExitGO, InputEnum.none));
		}

		function GiveTilePosition(x:int, y:int):Vector2
		{
			return new Vector2(((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.X + Tile.WIDTH/2, ((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.Y + Tile.HEIGHT/2);
		}
	}
}