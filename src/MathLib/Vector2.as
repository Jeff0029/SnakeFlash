package MathLib 
{
	import Math;
	/**
	 * ...
	 * @author ...
	 */
	public class Vector2 
	{
		
		private var x : Number;
		private var y : Number;
		
		public function get X() : Number { return x; }
		public function get Y() : Number { return y; }
		
		public function Vector2(x : int, y : int)
		{
			this.x = x;
			this.y = y;
		}
		
		public static const Zero : Vector2 = new Vector2(0, 0);
		public static const One : Vector2 = new Vector2(1, 1);
		public static const Right : Vector2 = new Vector2(1, 0);
		public static const Up : Vector2 = new Vector2(0, 1);
		
		public function get Magnitude() : Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		public function get Normalized() : Vector2
		{
			var magnitude : Number = Magnitude;
			return new Vector2(x / magnitude, y / magnitude);
		}
		
		public static function Equals(a : Vector2, b : Vector2) : Boolean
		{
			return a.x == b.x && a.y == b.y;
		}
		
		public static function Add(a : Vector2, b : Vector2) : Vector2
		{
			return new Vector2(a.x + b.x, a.y + b.y);
		}
		
		public static function Sub(a : Vector2, b : Vector2) : Vector2
		{
			return new Vector2(a.x - b.x, a.y - b.y);
		}
		
		public static function Neg(a : Vector2) : Vector2
		{
			return new Vector2( -a.x, -a.y);
		}
		
		public static function Scale(a : Vector2, b : Vector2) : Vector2
		{
			return new Vector2(a.x * b.x, a.y * b.y);
		}
		
		public function Print() : String
		{
			return "x: " + x + ", y: " + y;
		}
	}

}