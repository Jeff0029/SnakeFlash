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
		protected var imageData : BitmapData;
		protected var parent : Sprite;
		protected var sprite : Sprite;
		
		public function Renderer(bitmap : BitmapData, parent : Sprite) 
		{
			imageData = bitmap;
			this.parent = parent;
			sprite = new Sprite();
		}
		
		public override function Start() : void
		{
			sprite.addChild(new Bitmap(imageData));
			parent.addChild(sprite);
		}
		
	}

}