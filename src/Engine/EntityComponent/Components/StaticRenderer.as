package Engine.EntityComponent.Components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * A renderer for images that will never change.
	 * @author Erik
	 */
	public class StaticRenderer extends Renderer
	{
		private var imageData : BitmapData;
		
		public function StaticRenderer(bitmap : BitmapData, parent : Sprite) 
		{
			super(parent);
			
			imageData = bitmap;
			
			AddChildToParent(CreateChildSprite(imageData));
		}
		
	}

}