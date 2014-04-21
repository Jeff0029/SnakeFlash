package Gameplay 
{
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.GameObject;
	/**
	 * ...
	 * @author ...
	 */
	public class SnakePart extends Component
	{
		public var tilePosX:int;
		public var tilePosY:int;
		public function SnakePart(x:int, y:int) 
		{
			tilePosX = x;
			tilePosY = y;
		}
		
	}

}