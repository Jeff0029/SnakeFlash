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
		private static var testTex : BitmapData;
		
		public static function Initialize() : void
		{
			testTex = GetBitmapData(new TestTexClass() as Bitmap);
		}
		
		private static function GetBitmapData(data : Bitmap) : BitmapData
		{
			return data.bitmapData;
		}
		
		public function TextureBank() 
		{
		}
		
	}

}