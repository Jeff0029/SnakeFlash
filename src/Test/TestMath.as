package Test 
{
	import Math;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class TestMath 
	{
		
		public function TestMath() 
		{
		}
		
		public static function TestMaths() : void
		{
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(MagnitudeTest());
			tests.push(EqualityTest());
			tests.push(AdditionTest());
			tests.push(ScaleTest());
			
			var pass : Boolean = TestingUtils.CheckTests(tests, "A test failed!");
			
			if (pass)
				trace("All Math tests passed.");
		}
		
		public static function MagnitudeTest() : Boolean
		{
			var a : Vector2 = new Vector2(1, 1);
			var b : Vector2 = new Vector2(-1, 1);
			var c : Vector2 = new Vector2(123, 987);
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(TestingUtils.Approx(a.Magnitude, 1.4142135623));
			tests.push(TestingUtils.Approx(b.Magnitude, 1.4142135623));
			tests.push(TestingUtils.Approx(c.Magnitude, 994.6346062750));
			
			return TestingUtils.CheckTests(tests, "Magnitude testing failed!");
		}
		
		public static function NormalizeTest() : Boolean
		{
			var a : Vector2 = new Vector2(12345, 98765);
			var b : Vector2 = a.Normalized;
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(a.Normalized.Magnitude == 1);
			tests.push(TestingUtils.Approx(b.X, 0.1236635033));
			tests.push(TestingUtils.Approx(b.Y, 0.9923242100));
			
			return TestingUtils.CheckTests(tests, "Normalization testing failed!");
		}
		
		public static function EqualityTest() : Boolean
		{
			var a : Vector2 = new Vector2(123456789.987654321, 987654321.123456789);
			var b : Vector2 = new Vector2(123456789.987654321, 987654321.123456789);
			var zero : Vector2 = Vector2.Zero;
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(Vector2.Equals(a, b));
			tests.push(!Vector2.Equals(a, zero));
			
			return TestingUtils.CheckTests(tests, "Equality testing failed!");
		}
		
		public static function AdditionTest() : Boolean
		{
			var a : Vector2 = new Vector2(1, 1);
			var b : Vector2 = new Vector2(2, 2.1);
			
			var c : Vector2 = new Vector2(123456789, 987654321);
			var d : Vector2 = new Vector2(555555555, 555555555);
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(Vector2.Equals(Vector2.Add(a, b), new Vector2(3, 3.1)));
			tests.push(Vector2.Equals(Vector2.Add(c, d), new Vector2(679012344, 1543209876)));
			
			return TestingUtils.CheckTests(tests, "Addition testing failed!");
		}
		
		public static function ScaleTest() : Boolean
		{
			var a : Vector2 = new Vector2(1, 3);
			var b : Vector2 = new Vector2(2, 2.1);
			
			var c : Vector2 = new Vector2(12345, 98765);
			var d : Vector2 = new Vector2(555, 555);
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(Vector2.Equals(Vector2.Scale(a, b), new Vector2(2, 6.3)));
			tests.push(Vector2.Equals(Vector2.Scale(c, d), new Vector2(6851475, 54814575)));
			
			return TestingUtils.CheckTests(tests, "Scale testing failed!");
		}
		
	}

}