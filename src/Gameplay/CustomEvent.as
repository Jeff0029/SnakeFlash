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
		public function CustomEvent(type:String) 
		{
			super(type);
		}
		
	}

}