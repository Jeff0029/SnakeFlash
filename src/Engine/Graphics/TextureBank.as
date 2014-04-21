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
		// DEBUG TEXTURES
		[Embed(source = "../../../Resources/Textures/Debug/TestTexture.png")]
		private static var TestTexClass : Class;
		public static var testTex : BitmapData = GetBitmapData(TestTexClass);
		
		[Embed(source = "../../../Resources/Textures/Debug/TestAnimatedTexture.png")]
		private static var TestAnimatedTexClass : Class;
		public static var testAnimatedTex : BitmapData = GetBitmapData(TestAnimatedTexClass);
		
		// BACKGROUND TEXTURE
		[Embed(source = "../../../Resources/Textures/Background.png")]
		private static var BackgroundTexClass : Class;
		public static var backgroundTex : BitmapData = GetBitmapData(BackgroundTexClass);
		
		// SNAKE TEXTURES
		[Embed(source = "../../../Resources/Textures/Snake/SnakeUpSheet_Alone.png")]
		private static var FoodTexClass : Class;
		public static var foodTexClass : BitmapData = GetBitmapData(FoodTexClass);
		
		[Embed(source = "../../../Resources/Textures/Snake/SnakeSUpSheet_First.png")]
		private static var SnakeUpFirstTexClass : Class;
		public static var snakeUpFirstTex : BitmapData = GetBitmapData(SnakeUpFirstTexClass);
		
		[Embed(source = "../../../Resources/Textures/Snake/SnakeStraightUpSheet.png")]
		private static var SnakeStraightUpTexClass : Class;
		public static var snakeStraightUpTex : BitmapData = GetBitmapData(SnakeStraightUpTexClass);
		
		// MENU TEXTURES
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Title.png")]
		private static var GameOverTitleTexClass : Class;
		public static var gameOverTitleTex : BitmapData = GetBitmapData(GameOverTitleTexClass);
		
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Retry.png")]
		private static var GameOverRetryTexClass : Class;
		public static var gameOverRetryTex : BitmapData = GetBitmapData(GameOverRetryTexClass);
		
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Retry_Selected.png")]
		private static var GameOverRetrySelectedTexClass : Class;
		public static var gameOverRetrySelectedTex : BitmapData = GetBitmapData(GameOverRetrySelectedTexClass);
		
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Exit.png")]
		private static var GameOverExitTexClass : Class;
		public static var gameOverExitTex : BitmapData = GetBitmapData(GameOverExitTexClass);
		
		[Embed(source = "../../../Resources/Textures/Menu/GameOver_Exit_Selected.png")]
		private static var GameOverExitSelectedTexClass : Class;
		public static var gameOverExitSelectedTex : BitmapData = GetBitmapData(GameOverExitSelectedTexClass);
		
		private static function GetBitmapData(data : Class) : BitmapData
		{
			return (new data() as Bitmap).bitmapData;
		}
		
		public function TextureBank() 
		{
		}
		
	}

}