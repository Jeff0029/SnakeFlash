package 
{
	import Engine.EntityComponent.Components.Renderer;
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
			
			TestMath.TestMaths();
			TestEntityComponent.TestEntityComponents();
			var tileSet:Tiles = new Tiles();
			var tiles:Renderer = new Renderer(TextureBank.backgroundTex, this);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}