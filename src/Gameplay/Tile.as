package Gameplay 
{
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.GameObject;
	import Gameplay.TileEnum;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	 
	public class Tile extends Component
	{
		public var tileEnum:TileEnum;
		public static const WIDTH:Number = 64;
		public static const HEIGHT:Number = 64;
		public var coord:Vector2;
		
		public function Tile(tileEnum:TileEnum, coord:Vector2) 
		{
			this.coord = coord;
			this.tileEnum = tileEnum;
		}
		
	}

}