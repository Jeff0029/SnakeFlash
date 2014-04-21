package Engine.SceneGraph 
{
	import Engine.EntityComponent.GameObject;
	/**
	 * A scene graph to contain all gameobjects.
	 * @author Erik
	 */
	public class SceneGraph 
	{
		private var gameObjects : Vector.<GameObject>
		
		public function SceneGraph() 
		{
			gameObjects = new Vector.<GameObject>();
		}
		
		public function Update() : void
		{
			for each (var gameObject : GameObject in gameObjects)
			{
				gameObject.Update();
			}
		}
		
		public function Add(go : GameObject) : void
		{
			gameObjects.push(go);
		}
	}

}