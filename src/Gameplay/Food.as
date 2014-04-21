package Gameplay 
{
	import Engine.EntityComponent.GameObject;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class Food extends GameObject
	{
		var isVisible:Boolean = false;
		public function Food() 
		{
			SetFood();
		}
		
		public function SetFood()
		{
			var isSet: Boolean = false;
			do
			{	
				var collumSelection:int;
				var rowSelection:int;
				rowSelection = Math.random() * (Tiles.ROWS-1);
				collumSelection = Math.random() * (Tiles.COLUMNS-1);
				if (((Tiles.tiles[rowSelection][collumSelection] as GameObject).GetComponent(Tile) as Tile).tileEnum == TileEnum.empty)
				{
					CTransform.Position = new Vector2(collumSelection * Tile.WIDTH + Tile.WIDTH / 2 , rowSelection * Tile.HEIGHT + Tile.HEIGHT / 2);
					Tiles.SetTileState(collumSelection, rowSelection, TileEnum.snakeFood);
					isSet = true;
					isVisible = true;
				}
			}while(!isSet)
		}
	}

}