package Gameplay 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class CustomEvent extends Event
	{
		public static const RESET:String = "Reset";
		public static const START:String = "Start";
		public function CustomEvent(type:String) 
		{
			super(type);
		}
		
	}

}