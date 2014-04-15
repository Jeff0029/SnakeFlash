package EntityComponent 
{
	import EntityComponent.Components.Component;
	import EntityComponent.Components.IComponent;
	import EntityComponent.Components.Transform;
	import flash.utils.getQualifiedClassName;
	/**
	 * An entity for containing components.
	 * @author Erik
	 */
	public class GameObject 
	{	
		private var transform : Transform;
		
		private var components : Vector.<IComponent> = new Vector.<IComponent>();
		
		public function get CTransform() : Transform { return transform; }
		
		public function GameObject() 
		{
			transform = new Transform();
			components.push(transform);
		}
		
		public function Start() : void
		{
			for each (var component : IComponent in components)
				component.Start();
		}
		
		public function Update() : void
		{
			for each (var component : IComponent in components)
				component.Update();
		}
		
		public function AddComponent(toAdd : IComponent) : void
		{
			var toAddType : String = getQualifiedClassName(toAdd);
			
			for each (var component : Component in components)
			{
				if (toAddType == getQualifiedClassName(component))
					throw new ArgumentError("Component of type already on GameObject");
			}
			
			components.push(toAdd);
		}
		
		public function RemoveComponent(toRemoveType : Class) : void
		{
			var toRemoveTypeString : String = getQualifiedClassName(toRemoveType);
			var toRemoveIndex : int = -1;
			
			for (var i : int = 0; i < components.length; i++)
			{
				var component : IComponent = components[i];
				
				if (toRemoveTypeString == getQualifiedClassName(component))
				{
					toRemoveIndex = i;
					break;
				}
			}
			
			if (toRemoveIndex < 0)
				throw new ArgumentError("Component of type not found on GameObject");
			
			components.splice(toRemoveIndex, 1);
		}
		
		public function GetComponent(toGetType : Class) : IComponent
		{
			var toGetTypeString : String = getQualifiedClassName(toGetType);
			
			for each (var component : Component in components)
			{
				if (toGetTypeString == getQualifiedClassName(component))
					return component;
			}
			
			throw new ArgumentError("Component of type not found on GameObject " + components.length);
		}
		
	}

}