package Gameplay 
{
	import EntityComponent.Components.Transform;
	import Gameplay.Tile;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class Tiles
	{
		const COLLUM:uint = 15;
		const ROWS:uint = 10;
		var fillValue:Tile = new Tile();
		var tiles:Array = new Array();
		
		public function Tiles() 
		{
			setupTileGrid();
		}
		
		public function setupTileGrid():void
		{
			for (var i:int = 0; i < ROWS; i++) 
			{
				tiles.push(new Array());
				for (var j:int = 0; j < COLLUM; j++) 
				{
					fillValue.position = new Vector2(fillValue.width * j, fillValue.height * i);
					fillValue.tileEnum = TileEnum.empty;
					tiles[i].push(fillValue);
				}
			}
			
		}
	}

}