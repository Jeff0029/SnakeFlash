package Engine.EntityComponent.Components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * A rendering component for displaying sprites.
	 * @author Erik
	 */
	public class Renderer extends Component
	{
		private var parent : Sprite;
		private var sprite : Sprite;
		
		public function Renderer(parent : Sprite) 
		{
			this.parent = parent;
			sprite = new Sprite();
			parent.addChild(sprite);
		}
		
		public override function Update() : void
		{
			sprite.x = gameObject.CTransform.Position.X;
			sprite.y = gameObject.CTransform.Position.Y;
			sprite.rotation = gameObject.CTransform.Rotation;
		}
		
		public function AddEventListener(event : String, listener : Function) : void
		{
			sprite.addEventListener(event, listener);
		}
		
		public function RemoveEventListener(event : String, listener : Function)
		{
			sprite.removeEventListener(event, listener);
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
			sprite.addChild(child);
		}
		
	}

}