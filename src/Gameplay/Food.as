package Gameplay 
{
	import Engine.EntityComponent.GameObject;
	import MathLib.Vector2;
	/**
	 * Entity that make the snake grow
	 * @author Jean-Francois Vienneau
	 */
	public class Food extends GameObject
	{
		private var isVisible:Boolean = false;
		public function Food() 
		{
			SetFood();
		}
		
		public function SetFood() : void
		{
			var isSet: Boolean = false;
			do
			{	
				var collumSelection:int;
				var rowSelection:int;
				rowSelection = Math.random() * (Tiles.ROWS-1);
				collumSelection = Math.random() * (Tiles.COLUMNS-1);
				if (Tiles.GetTileState(collumSelection, rowSelection) == TileEnum.empty)
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