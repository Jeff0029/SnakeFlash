package Gameplay 
{
	import Engine.EntityComponent.Components.Transform;
	import Gameplay.Tile;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class Tiles
	{
		private const COLUMN:uint = 15;
		private const ROWS:uint = 10;
		private var fillValue:Tile = new Tile();
		private var tiles:Array = new Array();
		
		public function Tiles() 
		{
			setupTileGrid();
		}
		
		public function setupTileGrid():void
		{
			for (var i:int = 0; i < ROWS; i++) 
			{
				tiles.push(new Array());
				for (var j:int = 0; j < COLUMN; j++) 
				{
					//fillValue.position = new Vector2(fillValue.width * j, fillValue.height * i);
					fillValue.tileEnum = TileEnum.empty;
					tiles[i].push(fillValue);
				}
			}
			
		}
	}

}