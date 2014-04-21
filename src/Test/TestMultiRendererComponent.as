package Test 
{
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.Components.MultiRenderer;
	import MathLib.Vector2;
	/**
	 * ...
	 * @author ...
	 */
	public class TestMultiRendererComponent extends Component
	{
		private var index : int = 0;
		
		public function TestMultiRendererComponent() 
		{
		}
		
		public override function Update() : void
		{
			index++;
			index %= 2;
			
			(gameObject.CRenderer as MultiRenderer).DisplaySprite(index);
			gameObject.CTransform.Translate(new Vector2(1, 0));
		}
		
	}

}