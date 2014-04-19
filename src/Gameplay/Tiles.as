package Gameplay 
{
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
		
		public function setupTileGrid():void
		{
			for (var i:int = 0; i < ROWS; i++) 
			{
				tiles.push(new Array());
				for (var j:int = 0; j < COLUMNS; j++) 
				{
					var fillValue:GameObject = new GameObject();
					fillValue.AddComponent(new Tile(TileEnum.empty));
					fillValue.CTransform.Position = new Vector2(Tile.WIDTH * j, Tile.HEIGHT * i);
					tiles[i].push(fillValue);
				}
			}
			
		}
	}

}