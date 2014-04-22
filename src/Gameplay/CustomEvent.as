package Gameplay 
{
	import flash.events.Event;
	/**
	 * Custom event for local calls
	 * @author Jean-Francois Vienneau
	 */
	public class CustomEvent extends Event
	{
		public static const RESET:String = "Reset";
		public static const START:String = "Start";
		public static const SCORE:String = "Score";
		public function CustomEvent(type:String) 
		{
			super(type);
		}
		
	}

}