package Test 
{
	import Math;
	/**
	 * ...
	 * @author ...
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
	}
}