package 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.GameObject;
	import Engine.Graphics.TextureBank;
	import Engine.SceneGraph.SceneGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	import MathLib.Vector2;
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
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var tileSet:Tiles = new Tiles();
			
			RunTests();
			
			CreateSceneGraph();
		}
		
		private function RunTests() : void
		{
			TestMath.TestMaths();
			TestEntityComponent.TestEntityComponents();
		}
		
		private function CreateSceneGraph() : void
		{
			scene = new SceneGraph();
			
			CreateGameObjects();
			
			scene.Start();
			
			addEventListener(Event.ENTER_FRAME, UpdateLoop);
		}
		
		private function CreateGameObjects() : void
		{
			var goAnimTest : GameObject = new GameObject();
			goAnimTest.AddComponent(new CellRenderer(TextureBank.testAnimatedTex, this));
			goAnimTest.AddComponent(new Animator(4));
			scene.Add(goAnimTest);
			goAnimTest.CTransform.Translate(new Vector2(100, 100));
			goAnimTest.CTransform.Rotate(-45);
			
			var goAnimTest2 : GameObject = new GameObject();
			goAnimTest2.AddComponent(new CellRenderer(TextureBank.testAnimatedTex, this));
			goAnimTest2.AddComponent(new Animator(4));
			scene.Add(goAnimTest2);
			goAnimTest2.CTransform.Translate(new Vector2(80, 80));
		}
		
		private function UpdateLoop(e:Event) : void
		{
			scene.Update();
		}
		
	}
	
}