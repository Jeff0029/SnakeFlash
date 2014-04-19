package Engine.Graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * Contains loaded bitmaps.
	 * @author Erik
	 */
	public class TextureBank 
	{
		
		[Embed(source = "../../../Resources/Textures/Debug/TestTexture.png")]
		private static var TestTexClass : Class;
		public static var testTex : BitmapData = GetBitmapData(TestTexClass);
		
		[Embed(source = "../../../Resources/Textures/Debug/TestAnimatedTexture.png")]
		private static var TestAnimatedTexClass : Class;
		public static var testAnimatedTex : BitmapData = GetBitmapData(TestAnimatedTexClass);
		
		[Embed(source = "../../../Resources/Textures/Background.png")]
		private static var BackgroundTexClass : Class;
		public static var backgroundTex : BitmapData = GetBitmapData(BackgroundTexClass);
		
		[Embed(source = "../../../Resources/Textures/Snake/SnakeUpSheet_Alone.png")]
		private static var FoodTexClass : Class;
		public static var foodTexClass : BitmapData = GetBitmapData(FoodTexClass);
		
		private static function GetBitmapData(data : Class) : BitmapData
		{
			return (new data() as Bitmap).bitmapData;
		}
		
		public function TextureBank() 
		{
		}
		
	}

}