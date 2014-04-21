package Engine.EntityComponent.Components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * A renderer that can swap images at runtime.
	 * @author Erik
	 */
	public class MultiRenderer extends Renderer
	{
		private var imageData : Vector.<BitmapData>;
		private var sprites : Vector.<Sprite>
		
		private var activeSprite : Sprite;
		
		public function MultiRenderer(bitmaps : Vector.<BitmapData>, parent : Sprite) 
		{
			super(parent);
			
			imageData = bitmaps;
			sprites = new Vector.<Sprite>();
			
			for each (var image : BitmapData in imageData)
			{
				var newSprite : Sprite = new Sprite();
				newSprite.addChild(CreateChildSprite(image));
				newSprite.visible = false;
				
				sprites.push(newSprite);
				
				AddChildToParent(newSprite);
			}
			
			activeSprite = sprites[0];
			DisplaySprite(0);
		}
		
		public override function Update() : void
		{
			activeSprite.x = gameObject.CTransform.Position.X;
			activeSprite.y = gameObject.CTransform.Position.Y;
			activeSprite.rotation = gameObject.CTransform.Rotation;
		}
		
		public function DisplaySprite(index : int) : void
		{
			activeSprite.visible = false;
			activeSprite = sprites[index];
			activeSprite.visible = true;
		}
		
	}

}