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
		
		[Embed(source = "../../../Resources/Textures/Debug/TestTexture2.png")]
		private static var TestTex2Class : Class;
		public static var testTex2 : BitmapData = GetBitmapData(TestTex2Class);
		
		[Embed(source = "../../../Resources/Textures/Debug/TestAnimatedTexture.png")]
		private static var TestAnimatedTexClass : Class;
		public static var testAnimatedTex : BitmapData = GetBitmapData(TestAnimatedTexClass);
		
		[Embed(source = "../../../Resources/Textures/Background.png")]
		private static var BackgroundTexClass : Class;
		public static var backgroundTex : BitmapData = GetBitmapData(BackgroundTexClass);
		
		[Embed(source = "../../../Resources/Textures/Snake/SnakeUpSheet_Alone.png")]
		private static var FoodTexClass : Class;
		public static var foodTexClass : BitmapData = GetBitmapData(FoodTexClass);
		
		[Embed(source = "../../../Resources/Textures/Snake/SnakeSUpSheet_First.png")]
		private static var SnakeUpFirstTexClass : Class;
		public static var snakeUpFirstTexClass : BitmapData = GetBitmapData(SnakeUpFirstTexClass);
		
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Title.png")]
		private static var GameOverTitleTexClass : Class;
		public static var gameOverTitleTexClass : BitmapData = GetBitmapData(GameOverTitleTexClass);
		
		private static function GetBitmapData(data : Class) : BitmapData
		{
			return (new data() as Bitmap).bitmapData;
		}
		
		public function TextureBank() 
		{
		}
		
	}

}