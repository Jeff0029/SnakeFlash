package Engine.EntityComponent.Components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * A rendering component for displaying sprites.
	 * @author Erik
	 */
	public class Renderer extends Component 
	{
		private var sprite : Sprite;
		
		public function Renderer(bitmap : BitmapData, parent : Sprite) 
		{
			sprite = new Sprite();
			sprite.addChild(new Bitmap(bitmap));
			
			parent.addChild(sprite);
		}
		
	}

}