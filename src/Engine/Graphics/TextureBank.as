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
		
		private static function GetBitmapData(data : Class) : BitmapData
		{
			return (new data() as Bitmap).bitmapData;
		}
		
		public function TextureBank() 
		{
		}
		
	}

}