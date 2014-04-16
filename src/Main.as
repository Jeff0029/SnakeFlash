package 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.GameObject;
	import Engine.Graphics.TextureBank;
	import Engine.SceneGraph.SceneGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	import Test.TestEntityComponent;
	import Test.TestMath;
	import Gameplay.Tiles;
	
	/**
	 * ...
	 * @author Erik Uggeldahl, Jean-Francois Vienneau, Nicholas Belanger Theil
	 */
	[SWF(width=960, height=640, frameRate=8, backgroundColor=0xE2E2E2)]
	public class Main extends Sprite 
	{
		private var scene : SceneGraph;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			var tileSet:Tiles = new Tiles();
			TestMath.TestMaths();
			TestEntityComponent.TestEntityComponents();
			
			scene = new SceneGraph();
			
			var goAnimTest : GameObject = new GameObject();
			goAnimTest.AddComponent(new CellRenderer(TextureBank.testAnimatedTex, this));
			goAnimTest.AddComponent(new Animator(4));
			scene.Add(goAnimTest);
			
			scene.Start();
			
			addEventListener(Event.ENTER_FRAME, UpdateLoop);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
		private function UpdateLoop(e:Event) : void
		{
			scene.Update();
		}
		
	}
	
}