package Gameplay 
{
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.GameObject;
	import Gameplay.TileEnum;
	/**
	 * ...
	 * @author ...
	 */
	 
	public class Tile extends Component
	{
		public var tileEnum:TileEnum;
		public static const WIDTH:Number = 64;
		public static const HEIGHT:Number = 64;
		
		public function Tile(tileEnum:TileEnum) 
		{
			this.tileEnum = tileEnum;
		}
		
	}

}