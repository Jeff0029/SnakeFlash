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
	 * Player's character
	 * @author Jean-Francois Vienneau
	 */
	public class Snake extends Component
	{
		private var size:Number;
		private const STARTING_SIZE:Number = 5;
		private var direction:DirectionEnum = new DirectionEnum();
		private var snakeList:GameObjectList = new GameObjectList();
		private var newPos:Vector2 = Vector2.Zero;

		private var main:Main;
		private var isDead:Boolean = false;
		private var GameOverTextGO:GameObject;
		private var GameOverRetryGO:GameObject;
		private var GameOverExitGO:GameObject;
		public function Snake(main:Main) 
		{
			isDead = false;
			this.main = main;
			direction = DirectionEnum.right;
			for (var i:int = 0; i < STARTING_SIZE; i++) 
			{
				Grow(new Vector2(i, 0), TextureBank.snakeStraightUpTex);
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
					Main.dispatch.dispatchEvent(new CustomEvent("GameOver"));
					YouLost();
					isDead = true;
					return;
				}
				if (Tiles.GetTileState(newPos.X, newPos.Y) == TileEnum.snakeFood)
				{
					// custom event to call the increment of the score
					Main.dispatch.dispatchEvent(new CustomEvent("Score"));
					// Remove the food state on the tile
					Tiles.SetTileState(newPos.X, newPos.Y, TileEnum.empty);
					Grow(newPos, TextureBank.snakeStraightUpTex);
					// Set the food elsewhere
					main.FoodGO.SetFood();
				}
				MoveWholeSnake(newPos.X, newPos.Y, snakeList);
			}
		}
		
		private function Grow(position:Vector2, bitmapdata:BitmapData) : void
		{
			snakeList.Add(PooledSnake.Create() as GameObjectNode);
			snakeList.head.gameObject = new GameObject();
			
			Tiles.SetTileState(position.X, position.Y, TileEnum.snakePart);
			snakeList.head.gameObject.AddComponent(new SnakePart(position.X, position.Y));
			MoveSnakePart(position.X, position.Y, snakeList.head);
			snakeList.head.gameObject.AddComponent(new CellRenderer(bitmapdata, main));
			snakeList.head.gameObject.AddComponent(new Animator(5));
			main.scene.Add(snakeList.head.gameObject);
			snakeList.UpdateAll();
		}
		
		private function Shrink(amount:int) : void
		{
			for (var i:int = 0; i < amount; i++)
			{
				snakeList.head.gameObject.CRenderer.SetVisible(false);
				Tiles.SetTileState(GetSnakePartCoord(snakeList.head.gameObject).X, GetSnakePartCoord(snakeList.head.gameObject).Y, TileEnum.empty);
				(snakeList.head as PooledSnake).Recycle();
				(snakeList.head as PooledSnake).RemoveFromList();
			}
		}
		
		private function Reset(event:CustomEvent) : void 
		{
			GameOverTextGO.CRenderer.SetVisible(false);
			GameOverRetryGO.CRenderer.SetVisible(false);
			GameOverExitGO.CRenderer.SetVisible(false);
			isDead = false;
			direction = DirectionEnum.right;
			Shrink(snakeList.count - STARTING_SIZE);
			MoveWholeSnake(0, 0, snakeList);
		}
		
		private function GetSnakePartCoord(snakePart:GameObject):Vector2
		{
			return new Vector2((snakePart.GetComponent(SnakePart) as SnakePart).tilePosX, (snakePart.GetComponent(SnakePart) as SnakePart).tilePosY);
		}
		
		private function SetSnakePartCoord(snakePart:GameObject, coord:Vector2) : void
		{
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosX = coord.X;
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosY = coord.Y;
		}
		
		private function MoveSnakePart(x:int, y:int, head:GameObjectNode) : void
		{
			var direction:Vector2;
			direction = Vector2.Sub(GetSnakePartCoord(head.gameObject), new Vector2(x, y));
			if (direction.X == -1)
			head.gameObject.CTransform.Rotation = 90;
			else if (direction.X == 1)
			head.gameObject.CTransform.Rotation = 270;
			else if (direction.Y == -1)
			head.gameObject.CTransform.Rotation = 180;
			else if (direction.Y == 1)
			head.gameObject.CTransform.Rotation = 0;
			
			SetSnakePartCoord(head.gameObject, new Vector2(x, y));
			head.gameObject.CTransform.Position = GiveTilePosition(x, y);
		}
		
		private function MoveWholeSnake(x:int, y:int, objsToMove:GameObjectList) : void
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
				MoveSnakePart(lastCoord.X, lastCoord.Y, currentObj);
				lastCoord = tempCoord;
				lastPos = tempPos;
			}
			Tiles.SetTileState(tempCoord.X, tempCoord.Y, TileEnum.empty);
		}
		
		private function YouLost() : void
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

		private function GiveTilePosition(x:int, y:int):Vector2
		{
			return new Vector2(((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.X + Tile.WIDTH/2, ((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.Y + Tile.HEIGHT/2);
		}
	}
}