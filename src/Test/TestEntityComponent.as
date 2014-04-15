package Test 
{
	import EntityComponent.Components.IComponent;
	import EntityComponent.Components.Transform;
	import EntityComponent.GameObject;
	import MathLib.Vector2;
	
	/**
	 * Tests the EntityComponent package.
	 * @author Erik
	 */
	public class TestEntityComponent 
	{
		public static function TestEntityComponents() : void
		{
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(TransformTest());
			tests.push(AddRemoveGetTest());
			
			var pass : Boolean = TestingUtils.CheckTests(tests, "A test failed!");
			
			if (pass)
				trace("All Entity Component tests passed.");
		}
		
		public static function AddRemoveGetTest() : Boolean
		{
			var go : GameObject = new GameObject();
			
			var sameComponentTest : Boolean = TestingUtils.CheckForError(function() : void
			{
				go.AddComponent(new Transform());
			}, ArgumentError);
			
			go.RemoveComponent(Transform);
			
			var removeNonExistantComponentTest : Boolean = TestingUtils.CheckForError(function() : void
			{
				go.RemoveComponent(Transform);
			}, ArgumentError);
			
			var getNonExistantComponentTest : Boolean = TestingUtils.CheckForError(function () : void
			{
				go.GetComponent(Transform);
			}, ArgumentError);
			
			go.AddComponent(new Transform());
			
			var transform : Transform = Transform(go.GetComponent(Transform));
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(sameComponentTest);
			tests.push(removeNonExistantComponentTest);
			tests.push(getNonExistantComponentTest);
			
			return TestingUtils.CheckTests(tests, "Add / remove testing failed!");
		}
		
		public static function TransformTest() : Boolean
		{
			var go : GameObject = new GameObject();
			go.CTransform.Position = new Vector2(1, 1);
			go.CTransform.Translate(new Vector2(2, 3));
			go.CTransform.Rotation = -30.5;
			go.CTransform.Rotate(20.5);
			
			var tests : Vector.<Boolean> = new Vector.<Boolean>();
			tests.push(Vector2.Equals(go.CTransform.Position, new Vector2(3, 4)));
			tests.push(go.CTransform.Rotation == -10);
			
			return TestingUtils.CheckTests(tests, "Transform testing failed!");
		}
		
	}

}