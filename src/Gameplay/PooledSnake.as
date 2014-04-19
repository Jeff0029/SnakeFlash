package Gameplay 
{
	import basefolder.GameObject;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author ...
	 */
	public class PooledSnake extends GameObject
	{
		
		//{ POOL VARIABLES
		private static var HeadPool:PooledSnake;
		var NextPoolItem:PooledSnake;
		//}
		
		//fields
		var VelocityX:Number;
		var VelocityY:Number;
		var AliveTime:Number;
		var Opacity:Number;
		var Image:Bitmap;
		
		public static const MOUSE_X_OFFSET:Number = -5;
		public static const MOUSE_Y_OFFSET:Number = -5;
		
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

			
			//subscribe
			Game.DisplayList.addChild(Vessel.graphics);
			Game.updateList.Add(Vessel);
			return Vessel;
		}

		override public function Update():void 
		{

			//game object update
			super.Update();
		}
		
		override public function Recycle():void 
		{
			if (Game.DisplayList.contains(graphics))
				Game.DisplayList.removeChild(graphics);

			RemoveFromList();
			graphics.removeChild(Image);
			
			//return to the pool
			NextPoolItem = HeadPool;
			HeadPool = this;
			
		}
		
	}

}