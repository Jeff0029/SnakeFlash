package Test 
{
	import flash.utils.getQualifiedClassName;
	import Math;
	/**
	 * Utilities for testing.
	 * @author Erik
	 */
	public class TestingUtils 
	{
		public static function Approx(a : Number, b : Number) : Boolean
		{
			return Math.abs(a - b) < 0.000001;
		}
		
		public static function CheckTests(tests : Vector.<Boolean>, errorMessage : String) : Boolean
		{
			var allPass : Boolean = true;
			
			for each (var test : Boolean in tests)
				allPass = allPass && test;
			
			if (!allPass)
				trace(errorMessage);
			
			return allPass;	
		}
		
		public static function CheckForError(func : Function, errorType : Class) : Boolean
		{
			try
			{
				func();
			}
			catch (exception : Error)
			{
				if (getQualifiedClassName(exception) == getQualifiedClassName(errorType))
					return true;
			}
			
			return false;
		}
		
	}

}