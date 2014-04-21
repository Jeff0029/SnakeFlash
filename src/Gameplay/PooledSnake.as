package Gameplay 
{
	import Engine.EntityComponent.GameObject;
	import Engine.EntityComponent.GameObjectNode;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author ...
	 */
	public class PooledSnake extends GameObjectNode
	{
		
		//{ POOL VARIABLES
		private static var HeadPool:PooledSnake;
		private var NextPoolItem:PooledSnake;
		private var m_GameObject:GameObject;
		//}
		
		public function PooledSnake() 
		{

		}
		
		//factory function
		public static function Create():PooledSnake
		{
			var Vessel:PooledSnake;
			if (HeadPool != null)//is there something in the pool
			{
				Vessel = HeadPool;
				HeadPool = HeadPool.NextPoolItem;
			}
			else
			{
				Vessel = new PooledSnake();
			}

			return Vessel;
		}

		override public function Update():void 
		{

			//game object update
			super.Update();
		}
		
		public override function Recycle():void 
		{

			//return to the pool
			NextPoolItem = HeadPool;
			HeadPool = this;
			
		}
		
	}

}