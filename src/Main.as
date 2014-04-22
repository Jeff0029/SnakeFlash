package 
{
	import Engine.EntityComponent.Components.Animator;
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.MultiRenderer;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.Components.StaticRenderer;
	import flash.display.BitmapData;
	import Engine.Graphics.FontBank;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.*;
	import flash.text.Font;
	import Gameplay.Food;
	import Input.InputKeyManager;
	import Engine.EntityComponent.GameObject;
	import Engine.Graphics.TextureBank;
	import Engine.SceneGraph.SceneGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Gameplay.Snake;
	import MathLib.Vector2;
	import Test.TestEntityComponent;
	import Test.TestMath;
	import Gameplay.Tiles;
	import Gameplay.Tile;
	import Gameplay.TileEnum;
	import Test.TestMultiRendererComponent;
	import Gameplay.InputEnum;
	import flash.events.MouseEvent;
	import flash.system.System;
	import Gameplay.CustomEvent;
	
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
		public static var dispatch:EventDispatcher = new EventDispatcher();
		private var scoreText:TextField = new TextField();
		private var scoreTextFormat:TextFormat = new TextFormat();
		private var scoreFont:Font = new Font();
		private var score:int = 0;
		
		private var menuTitleGO:GameObject;
		private var menuPlayGO:GameObject;
		private var menuExitGO:GameObject;
		private var menuInstructionsGO:GameObject;
		
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
			SetupScoreFont();
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
			
			CreateBackground();
			DisplayMainMenu();
			
			addEventListener(Event.ENTER_FRAME, UpdateLoop);
			//CreateTestGameObjects();
			dispatch.addEventListener(CustomEvent.START, StartGame);
			dispatch.addEventListener(CustomEvent.SCORE, IncrementScore);
			dispatch.addEventListener(CustomEvent.RESET, ResetScore);
			dispatch.addEventListener(CustomEvent.RESET, ResetFood);
		}
		
		private function ResetFood(event:CustomEvent) : void
		{
			Tiles.SetTileState(FoodGO.CTransform.Position.X/Tile.WIDTH, FoodGO.CTransform.Position.Y/Tile.HEIGHT, TileEnum.empty)
			FoodGO.SetFood();
		}
		
		private function ResetScore(event:CustomEvent) : void
		{
			score = 0;
			RefreshScore();
		}
		
		private function IncrementScore(event:CustomEvent) : void
		{
			score++;
			RefreshScore();
		}
		
		private function RefreshScore() : void
		{
			scoreText.text = "Total Score: " + score.toString();
		}
		
		private function SetupScoreFont(): void
		{
			// Add our font to the list
			Font.registerFont(FontBank.ScoreFontClass);
			var format:TextFormat = new TextFormat();
			// Set our new font
			format.font = "SAMSB";
			format.size = 25;
			
			scoreText.defaultTextFormat = format;
			scoreText.embedFonts = true;
			
			scoreText.height = 30;
			scoreText.width = 250;
		}
		
		private function StartGame(event:CustomEvent) : void
		{
			menuTitleGO.CRenderer.SetVisible(false)
			menuPlayGO.CRenderer.SetVisible(false);
			menuExitGO.CRenderer.SetVisible(false);
			menuInstructionsGO.CRenderer.SetVisible(false);
			CreateGameObjects();
		}
		
		private function CreateBackground(): void
		{
			// ADD BACKGROUND
			var BackgroundGO:GameObject = new GameObject();
			BackgroundGO.AddComponent(new StaticRenderer(TextureBank.backgroundTex, this));
			BackgroundGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/2));
			scene.Add(BackgroundGO);
		}
		
		private function CreateGameObjects() : void
		{			
			// ADD FOOD
			FoodGO = new Food();
			FoodGO.AddComponent(new CellRenderer(TextureBank.foodTexClass, this));
			FoodGO.AddComponent(new Animator(5));
			scene.Add(FoodGO);
			
			//ADD SCORE
			scoreText.y = TextureBank.backgroundTex.height - scoreText.height;
			RefreshScore();
			addChild(scoreText);
			
			// ADD SNAKE
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
			
			var goMultiTest : GameObject = new GameObject();
			
			var mutliTestBitmaps : Vector.<BitmapData> = new Vector.<BitmapData>();
			mutliTestBitmaps.push(TextureBank.testTex, TextureBank.testTex2);
			
			goMultiTest.AddComponent(new MultiRenderer(mutliTestBitmaps, this));
			goMultiTest.AddComponent(new TestMultiRendererComponent());
			scene.Add(goMultiTest);
			goMultiTest.CTransform.Translate(new Vector2(150, 150));
			(goMultiTest.CRenderer as MultiRenderer).DisplaySprite(1);
		}
		
		private function DisplayMainMenu() : void
		{
			menuTitleGO = new GameObject();
			menuTitleGO.AddComponent(new StaticRenderer(TextureBank.mainMenuTitleTex, this));
			menuTitleGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/2, TextureBank.backgroundTex.height/3));
			scene.Add(menuTitleGO);
			
			var mutliBitmapsPlay : Vector.<BitmapData> = new Vector.<BitmapData>();
			mutliBitmapsPlay.push(TextureBank.mainMenuPlayTex, TextureBank.mainMenuPlaySelectedTex);
			
			menuPlayGO = new GameObject();
			menuPlayGO.AddComponent(new MultiRenderer(mutliBitmapsPlay, this));
			menuPlayGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width / 2, TextureBank.backgroundTex.height / 3 + TextureBank.mainMenuTitleTex.height));
			(menuPlayGO.CRenderer as MultiRenderer).DisplaySprite(0);
			scene.Add(menuPlayGO);
			
			var mutliBitmapsExit : Vector.<BitmapData> = new Vector.<BitmapData>();
			mutliBitmapsExit.push(TextureBank.mainMenuExitTex, TextureBank.mainMenuExitSelectedTex);
			
			menuExitGO = new GameObject();
			menuExitGO.AddComponent(new MultiRenderer(mutliBitmapsExit, this));
			menuExitGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width / 2, TextureBank.backgroundTex.height / 3 + TextureBank.mainMenuTitleTex.height + TextureBank.mainMenuPlayTex.height));
			(menuExitGO.CRenderer as MultiRenderer).DisplaySprite(0);
			scene.Add(menuExitGO);
			
			menuInstructionsGO = new GameObject();
			menuInstructionsGO.AddComponent(new StaticRenderer(TextureBank.mainMenuControlsTex, this));
			menuInstructionsGO.CTransform.Translate(new Vector2(TextureBank.backgroundTex.width/4, TextureBank.backgroundTex.height/1.25));
			scene.Add(menuInstructionsGO);
			
			menuPlayGO.CRenderer.AddEventListener(MouseEvent.ROLL_OVER, ChangeButtonState(menuPlayGO, InputEnum.start));
			menuPlayGO.CRenderer.AddEventListener(MouseEvent.ROLL_OUT, ChangeButtonState(menuPlayGO, InputEnum.none));
			
			menuExitGO.CRenderer.AddEventListener(MouseEvent.ROLL_OVER, ChangeButtonState(menuExitGO, InputEnum.exit));
			menuExitGO.CRenderer.AddEventListener(MouseEvent.ROLL_OUT, ChangeButtonState(menuExitGO, InputEnum.none));
		}
		
		public static function ChangeButtonState(gameObjectHover:GameObject, inputType:InputEnum):Function
		{
			return function(e:MouseEvent):void 
			{
				if (inputType != InputEnum.none)
				{
					(gameObjectHover.CRenderer as MultiRenderer).DisplaySprite(1);
					gameObjectHover.CRenderer.AddEventListener(MouseEvent.CLICK, ListenForInput(inputType));
				}
				else
				{
					(gameObjectHover.CRenderer as MultiRenderer).DisplaySprite(0);
					gameObjectHover.CRenderer.RemoveEventListener(MouseEvent.CLICK, ListenForInput(inputType));
				}
			}
		}
		
		public static function ListenForInput(InputType:InputEnum):Function
		{
			return function(e:MouseEvent):void
			{
				switch(InputType)
				{
					case InputEnum.start:
						dispatch.dispatchEvent(new CustomEvent("Start"))
						break;
					case InputEnum.exit:
						System.exit(0);
						break;
					case InputEnum.retry:
						dispatch.dispatchEvent(new CustomEvent("Reset"))
						break;
				}
			}
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