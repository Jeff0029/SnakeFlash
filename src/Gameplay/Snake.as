package Gameplay 
{
	import Engine.EntityComponent.Components.Component;
	import Gameplay.DirectionEnum;
	import Input.InputKeyManager;
	/**
	 * ...
	 * @author ...
	 */
	public class Snake extends Component
	{
		var size:Number;
		const STARTING_SIZE:Number = 3;
		var direction:DirectionEnum = new DirectionEnum();
		
		public function Snake() 
		{
			
		}
		
		public override function Update() : void
		{
			if (InputKeyManager.CheckKeyPress(InputKeyManager.UP_ARROW) && direction != DirectionEnum.down)
			{
				direction = DirectionEnum.up;
			}
			else if (InputKeyManager.CheckKeyPress(InputKeyManager.DOWN_ARROW) && direction != DirectionEnum.up)
			{
				direction = DirectionEnum.down;
			}
			else if (InputKeyManager.CheckKeyPress(InputKeyManager.LEFT_ARROW) && direction != DirectionEnum.right)
			{
				direction = DirectionEnum.left;
			}
			else if (InputKeyManager.CheckKeyPress(InputKeyManager.RIGHT_ARROW) && direction != DirectionEnum.left)
			{
				direction = DirectionEnum.right;
			}
			trace(direction.Text);
		}
	}
}