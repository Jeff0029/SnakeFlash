package Gameplay 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.GameObject;
	import Engine.EntityComponent.GameObjectNode;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import Gameplay.DirectionEnum;
	import Engine.EntityComponent.GameObjectList;
	import Input.InputKeyManager;
	import Gameplay.PooledSnake;
	import Engine.Graphics.TextureBank;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
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
					moveWholeSnake(newPos.X, newPos.Y, snakeList);
					trace("FOOOD");
				}
				else
				{
					moveWholeSnake(newPos.X, newPos.Y, snakeList);
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
		
		function GetSnakePartCoord(snakePart:GameObject):Vector2
		{
			return new Vector2((snakePart.GetComponent(SnakePart) as SnakePart).tilePosX, (snakePart.GetComponent(SnakePart) as SnakePart).tilePosY);
		}
		
		function SetSnakePartCoord(snakePart:GameObject, coord:Vector2)
		{
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosX = coord.X;
			(snakePart.GetComponent(SnakePart) as SnakePart).tilePosY = coord.Y;
		}
		
		function moveHead(x:int, y:int, head:GameObjectNode)
		{
			SetSnakePartCoord(head.gameObject, new Vector2(x, y));
			head.gameObject.CTransform.Position = GiveTilePosition(x, y);
		}
		
		function moveWholeSnake(x:int, y:int, objsToMove:GameObjectList)
		{
			var currentObj: GameObjectNode = objsToMove.head;
			var lastPos:Vector2 = currentObj.gameObject.CTransform.Position;
			var lastCoord:Vector2 = GetSnakePartCoord(currentObj.gameObject);
			
			// Move first
			moveHead(x, y, objsToMove.head);
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
			var GameOverTextGO:GameObject = new GameObject();
			GameOverTextGO.AddComponent(new Renderer(TextureBank.gameOverTitleTex, main));
			GameOverTextGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/3));
			main.scene.Add(GameOverTextGO);
			
			var GameOverRetryGO:GameObject = new GameObject();
			GameOverRetryGO.AddComponent(new Renderer(TextureBank.gameOverRetryTex, main));
			GameOverRetryGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/3 + TextureBank.gameOverTitleTex.height));
			main.scene.Add(GameOverRetryGO);
			
			var GameOverExitGO:GameObject = new GameObject();
			GameOverExitGO.AddComponent(new Renderer(TextureBank.gameOverExitTex, main));
			GameOverExitGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/3 + TextureBank.gameOverTitleTex.height + TextureBank.gameOverRetryTex.height));
			main.scene.Add(GameOverExitGO);
			
			(GameOverRetryGO.CRenderer.sprite.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver(GameOverRetryGO, TextureBank.gameOverRetrySelectedTex)));
			(GameOverRetryGO.CRenderer.sprite.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOver(GameOverRetryGO, TextureBank.gameOverRetryTex)));
			
			(GameOverExitGO.CRenderer.sprite.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver(GameOverExitGO, TextureBank.gameOverExitSelectedTex)));
			(GameOverExitGO.CRenderer.sprite.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOver(GameOverExitGO, TextureBank.gameOverExitTex)));
			
			
		}
		
		function OnMouseOver(gameObjectHover:GameObject, texture:BitmapData):Function
		{
			return function(e:MouseEvent):void 
			{
				gameObjectHover.CRenderer.imageData = texture;
				gameObjectHover.CRenderer.Start();
			}
			
		}
		
		function GiveTilePosition(x:int, y:int):Vector2
		{
			return new Vector2(((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.X + Tile.WIDTH/2, ((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.Y + Tile.HEIGHT/2);
		}
	}
}