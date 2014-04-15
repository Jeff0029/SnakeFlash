package Gameplay 
{
	import EntityComponent.Components.Transform;
	import Gameplay.TileEnum;
	/**
	 * ...
	 * @author ...
	 */
	 
	public class Tile extends Transform
	{
		public var tileEnum:TileEnum;
		public var width:Number = 64;
		public var height:Number = 64;
		
		public function Tile() 
		{

		}
		
	}

}