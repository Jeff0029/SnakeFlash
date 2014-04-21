package Engine.EntityComponent 
{
	import Engine.EntityComponent.Components.CellRenderer;
	import Engine.EntityComponent.Components.Component;
	import Engine.EntityComponent.Components.IComponent;
	import Engine.EntityComponent.Components.Renderer;
	import Engine.EntityComponent.Components.Transform;
	import flash.utils.getQualifiedClassName;
	/**
	 * An entity for containing components.
	 * @author Erik
	 */
	public class GameObject 
	{
		private const TRANSFORM_TYPE : String = getQualifiedClassName(Transform);
		private var transform : Transform;
		
		private const RENDERER_TYPE : String = getQualifiedClassName(Renderer);
		private const CELL_RENDERER_TYPE : String = getQualifiedClassName(CellRenderer);
		private var renderer : Renderer;
		
		private var components : Vector.<IComponent> = new Vector.<IComponent>();
		
		public function get CTransform() : Transform { return transform; }
		public function get CRenderer() : Renderer { return renderer; }
		
		public function GameObject() 
		{
			AddComponent(new Transform());
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
			Component(toAdd).ParentGameObject = this;
			toAdd.Start();
			
			switch (toAddType)
			{
				case TRANSFORM_TYPE: transform = Transform(toAdd); break;
				case RENDERER_TYPE:	// Fall through
				case CELL_RENDERER_TYPE: renderer = Renderer(toAdd); break;
			}
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