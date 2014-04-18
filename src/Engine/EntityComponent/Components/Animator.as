package Engine.EntityComponent.Components 
{
	import Engine.EntityComponent.GameObject;
	import flash.geom.Rectangle;
	/**
	 * Animates an image based on a horizontal sprite sheet.
	 * @author Erik
	 */
	public class Animator extends Component 
	{
		private const CELL_SIZE : int = 64;
		
		private var frameCount : int;
		private var currentFrame : int = 0;
		
		private var cells : Vector.<Rectangle> = new Vector.<Rectangle>();
		private var renderer : CellRenderer;
		
		public override function set ParentGameObject(value : GameObject) : void
		{
			gameObject = value;
			renderer = gameObject.GetComponent(CellRenderer) as CellRenderer;
		}
		
		public function Animator(frameCount : int) 
		{
			this.frameCount = frameCount;
			
			for (var i : int = 0; i < frameCount; i++)
			{
				cells.push(new Rectangle(i * CELL_SIZE, 0, CELL_SIZE, CELL_SIZE));
			}
		}
		
		public override function Update() : void
		{
			currentFrame = (currentFrame + 1) % frameCount;
			
			renderer.DisplaySubsection(cells[currentFrame]);
		}
		
	}

}