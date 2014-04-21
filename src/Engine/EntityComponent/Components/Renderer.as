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
		private var parent : Sprite;
		
		public function Renderer(parent : Sprite) 
		{
			this.parent = parent;
		}
		
		protected function CreateChildSprite(imageData : BitmapData) : Sprite
		{
			var childSprite : Sprite = new Sprite();
			childSprite.addChild(new Bitmap(imageData));
			childSprite.x = -imageData.width / 2;
			childSprite.y = -imageData.height / 2;
			return childSprite;
		}
		
		protected function AddChildToParent(child : Sprite) : void
		{
			parent.addChild(child);
		}
		
	}

}