package Engine.EntityComponent.Components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * A rendering component for displaying animated sprites.
	 * @author Erik
	 */
	public class CellRenderer extends Renderer 
	{
		private const CELL_SIZE : int = 64;
		private const CLEAR_RECT : Rectangle = new Rectangle(0, 0, CELL_SIZE, CELL_SIZE);
		private const ZERO_POINT : Point = new Point(0, 0);
		
		private var imageData : BitmapData;
		private var canvasData : BitmapData;
		
		public function CellRenderer(bitmap : BitmapData, parent : Sprite) 
		{
			super(parent);
			
			imageData = bitmap;
			
			canvasData = new BitmapData(CELL_SIZE, CELL_SIZE);
			
			DisplaySubsection(CLEAR_RECT);
			
			AddChildToParent(CreateChildSprite(canvasData));
		}
		
		internal function DisplaySubsection(rect : Rectangle) : void
		{
			canvasData.fillRect(CLEAR_RECT, 0x00FFFFFF);
			canvasData.copyPixels(imageData, rect, ZERO_POINT, null, null, true);
		}
		
	}

}