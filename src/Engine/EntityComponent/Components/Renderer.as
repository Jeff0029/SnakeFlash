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
			var childSprite : Sprite = new Sprite();
			childSprite.addChild(new Bitmap(imageData));
			childSprite.x = -imageData.width / 2;
			childSprite.y = -imageData.height / 2;
			
			sprite.addChild(childSprite);
			parent.addChild(sprite);
		}
		
		public override function Update() : void
		{
			sprite.x = gameObject.CTransform.Position.X;
			sprite.y = gameObject.CTransform.Position.Y;
			sprite.rotation = gameObject.CTransform.Rotation;
		}
		
	}

}