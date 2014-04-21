package Gameplay 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.Components.StaticRenderer;
	import Engine.EntityComponent.GameObject;
	import Engine.EntityComponent.GameObjectNode;
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
				snakeList.Add(PooledSnake.Create() as GameObjectNode);
				snakeList.head.gameObject = new GameObject();
				snakeList.head.gameObject.CTransform.Position = GiveTilePosition(i, 0);
				Tiles.SetTileState(i, 0, TileEnum.snakePart);
				snakeList.head.gameObject.AddComponent(new SnakePart(i, 0));
				snakeList.head.gameObject.AddComponent(new CellRenderer(TextureBank.snakeUpFirstTexClass, main));
				snakeList.head.gameObject.AddComponent(new Animator(5));
				main.scene.Add(snakeList.head.gameObject);
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
					grow();
					trace("FOOOD");
				}
				else
				{
					moveWholeSnake(newPos.X, newPos.Y, snakeList);
				}
				snakeList.UpdateAll();			
			}
		}
		
		function grow()
		{
			var position:Vector2 = GetSnakePartCoord(snakeList.head.gameObject);
			snakeList.Add(PooledSnake.Create() as GameObjectNode);
			snakeList.head.gameObject = new GameObject();
			snakeList.head.gameObject.CTransform.Position = GiveTilePosition(position.X, position.Y);
			Tiles.SetTileState(position.X, position.Y, TileEnum.snakePart);
			snakeList.head.gameObject.AddComponent(new SnakePart(position.X, position.Y));
			snakeList.head.gameObject.AddComponent(new CellRenderer(TextureBank.testAnimatedTex, main));
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
			var GameOver:GameObject = new GameObject();
			GameOver.AddComponent(new StaticRenderer(TextureBank.testTex, main));
			GameOver.CTransform.Translate(new Vector2(64, 64));
			main.scene.Add(GameOver);
		}
		
		function GiveTilePosition(x:int, y:int):Vector2
		{
			return new Vector2(((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.X + Tile.WIDTH/2, ((Tiles.tiles[y][x] as GameObject).GetComponent(Tile) as Tile).coord.Y + Tile.HEIGHT/2);
		}
	}
}