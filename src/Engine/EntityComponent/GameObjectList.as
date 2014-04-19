package Engine.EntityComponent 
{
	/**
	 * ...
	 * @author ...
	 */
	public class GameObjectList 
	{
		public var head:GameObject;
		public function GameObjectList() 
		{
			
		}
		
		public function Add(Element:GameObject):void
		{
			if (head == null)
				head = Element;
			else
			{
				Element.Next = head;
				head.Previous = Element;
				head = Element;
			}
			Element.ListOwner = this;
		}
		
		public function UpdateAll():void
		{
			var current:GameObject = head;
			
			while (current != null)
			{
				var Next = current.Next;
				current.Update();
				current = Next;
			}
		}
	}

}