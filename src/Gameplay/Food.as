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
		
		function SetFood()
		{
			do
			{	
				var collumSelection:int;
				var rowSelection:int;
				rowSelection = Math.random() * (Tiles.ROWS-1);
				collumSelection = Math.random() * (Tiles.COLUMNS-1);
				if (((Tiles.tiles[rowSelection][collumSelection] as GameObject).GetComponent(Tile) as Tile).tileEnum == TileEnum.empty)
				{
					CTransform.Position = new Vector2(collumSelection * Tile.WIDTH + Tile.WIDTH/2 , rowSelection * Tile.HEIGHT + Tile.HEIGHT/2);
					isVisible = true;
				}
			}while(!isVisible)
		}
	}

}