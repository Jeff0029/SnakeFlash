package 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.Renderer;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import Gameplay.Food;
	import Input.InputKeyManager;
	import Engine.EntityComponent.GameObject;
	import Engine.Graphics.TextureBank;
	import Engine.SceneGraph.SceneGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	import Gameplay.Snake;
	import MathLib.Vector2;
	import Test.TestEntityComponent;
	import Test.TestMath;
	import Gameplay.Tiles;
	
	/**
	 * ...
	 * @author Erik Uggeldahl, Jean-Francois Vienneau, Nicholas Belanger Theil
	 */
	[SWF(width=960, height=640, frameRate=24, backgroundColor=0xE2E2E2)]
	public class Main extends Sprite 
	{
		public var scene : SceneGraph;
		private var updateLimiter : int = 0;
		public var FoodGO:Food;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//Set the window position and scale type
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var tileSet:Tiles = new Tiles();
			InputKeyManager.Init(this);
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
			//CreateTestGameObjects();
			scene.Start();
			
			addEventListener(Event.ENTER_FRAME, UpdateLoop);
		}
		
		private function CreateGameObjects() : void
		{
			// ADD BACKGROUND
			var BackgroundGO:GameObject = new GameObject();
			BackgroundGO.AddComponent(new Renderer(TextureBank.backgroundTex, this));
			BackgroundGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/2));
			scene.Add(BackgroundGO);
			
			// ADD FOOD
			FoodGO = new Food();
			FoodGO.AddComponent(new CellRenderer(TextureBank.foodTexClass, this));
			FoodGO.AddComponent(new Animator(5));
			scene.Add(FoodGO);
			
			var SnakeGO:GameObject = new GameObject();
			SnakeGO.AddComponent(new Snake(this));
			scene.Add(SnakeGO);
		}
		private function CreateTestGameObjects() : void
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
			// Update every third frame, i.e. 8 frames per second.
			updateLimiter++;
			updateLimiter %= 3;
			if (updateLimiter == 0)
				scene.Update();
		}
	}
	
}