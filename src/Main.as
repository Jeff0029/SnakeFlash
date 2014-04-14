package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Test.TestMath;
	
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
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}