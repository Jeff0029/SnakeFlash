package Engine.EntityComponent.Components 
{
	import Engine.EntityComponent.GameObject;
	
	/**
	 * Component interface.
	 * @author Erik
	 */
	public interface IComponent 
	{
		function get ParentGameObject() : GameObject;
		function Start() : void;
		function Update() : void;
	}
	
}