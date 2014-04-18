package Engine.EntityComponent.Components 
{
	import Engine.EntityComponent.GameObject;
	/**
	 * A generic component to inherit from.
	 * @author Erik
	 */
	public class Component implements IComponent
	{
		protected var gameObject : GameObject;
		public function get ParentGameObject() : GameObject { return gameObject; }
		public function set ParentGameObject(value : GameObject) : void { gameObject = value; }
		
		public function Component() 
		{
		}
		
		public function Start() : void
		{
		}
		
		public function Update() : void
		{
		}
		
	}

}