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
		private var sprite : Sprite;
		
		public function StaticRenderer(bitmap : BitmapData, parent : Sprite) 
		{
			super(parent);
			
			imageData = bitmap;
			sprite = new Sprite();
			
			sprite.addChild(CreateChildSprite(imageData));
			AddChildToParent(sprite);
		}
		
		public override function Update() : void
		{
			sprite.x = gameObject.CTransform.Position.X;
			sprite.y = gameObject.CTransform.Position.Y;
			sprite.rotation = gameObject.CTransform.Rotation;
		}
		
	}

}