package Engine.EntityComponent 
{
	/**
	 * ...
	 * @author ...
	 */
	public class GameObjectList 
	{
		public var head:GameObjectNode;
		public var count:int = 0;
		public function GameObjectList() 
		{
			count = 0;
		}
		
		public function Add(Element:GameObjectNode):void
		{
			count++;
			if (head == null)
			{
				head = Element;
			}
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
			var current:GameObjectNode = head;
			
			while (current != null)
			{
				var Next = current.Next;
				current.Update();
				current = Next;
			}
		}
	}

}