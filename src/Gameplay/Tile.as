package Gameplay 
{
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.GameObject;
	import Gameplay.TileEnum;
	/**
	 * ...
	 * @author ...
	 */
	 
	public class Tile extends GameObject
	{
		public var tileEnum:TileEnum;
		public var width:Number = 64;
		public var height:Number = 64;
		
		public function Tile() 
		{
			
		}
		
	}

}