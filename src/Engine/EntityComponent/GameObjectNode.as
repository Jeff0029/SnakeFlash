package Engine.EntityComponent 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class GameObjectNode
	{
		public var Previous:GameObjectNode;
		public var Next:GameObjectNode;
		public var ListOwner:GameObjectList;
		public var gameObject:GameObject;
		
		public function GameObjectNode() 
		{

		}
		
		public function Update():void
		{

		}
		
		public function RemoveFromList():void
		{
			ListOwner.count--;
			if (ListOwner == null) { return; }
			if (Previous == null)
			{
				ListOwner.head = Next;
				if (Next != null)
				{
					Next.Previous = null; //set the next as the new head;
					Next = null;
				}
			}
			else// you are not the head
			{
				if (Next == null) // You are the tail
				{
					Previous.Next = null;
					Previous = null;
				}
				else // You are in between
				{
					Previous.Next = Next;
					Next.Previous = Previous;
					Previous = null;
				}
				ListOwner = null;
			}
		}
		
		public function Recycle():void
		{
	
		}	
	}
}