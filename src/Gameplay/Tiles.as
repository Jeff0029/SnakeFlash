package Gameplay 
{
	import adobe.utils.ProductManager;
	import Engine.EntityComponent.Components.Transform;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.GameObject;
	import Engine.Graphics.TextureBank;
	import Gameplay.Tile;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class Tiles
	{
		public static const COLUMNS:uint = 15;
		public static const ROWS:uint = 10;
		public static var tiles:Array = new Array();
		
		public function Tiles() 
		{
			setupTileGrid();
		}
		
		private function setupTileGrid():void
		{
			for (var i:int = 0; i < ROWS; i++) 
			{
				tiles.push(new Array());
				for (var j:int = 0; j < COLUMNS; j++) 
				{
					var fillValue:GameObject = new GameObject();
					
					fillValue.CTransform.Position = new Vector2(Tile.WIDTH * j, Tile.HEIGHT * i);
					fillValue.AddComponent(new Tile(TileEnum.empty, fillValue.CTransform.Position));
					tiles[i].push(fillValue);
				}
			}
		}
		
		public static function SetTileState(x:int, y:int, state:TileEnum)
		{
			((tiles[y][x] as GameObject).GetComponent(Tile) as Tile).tileEnum = state;
		}
		
		public static function GetTileState(x:int, y:int): TileEnum
		{
			return((tiles[y][x] as GameObject).GetComponent(Tile) as Tile).tileEnum;
		}
	}

}