package 
{
	import Engine.Graphics.TextureBank;
	import flash.display.Sprite;
	import flash.events.Event;
	import Test.TestEntityComponent;
	import Test.TestMath;
	import Gameplay.Tiles;
	
	/**
	 * ...
	 * @author Erik Uggeldahl, Jean-Francois Vienneau, Nicholas Belanger Theil
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			var tileSet:Tiles = new Tiles();
			TestMath.TestMaths();
			TestEntityComponent.TestEntityComponents();
			TextureBank.Initialize();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}