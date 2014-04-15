package Engine.EntityComponent.Components 
{
	import MathLib.Vector2;
	/**
	 * Transform component.
	 * @author Erik
	 */
	public class Transform extends Component
	{
		private var position : Vector2;
		private var rotation : Number;
		
		public function get Position() : Vector2 { return position; }
		public function set Position(value : Vector2) : void { position = value; }
		
		public function get Rotation() : Number { return rotation; }
		public function set Rotation(value : Number) : void { rotation = value; }
		
		public function Transform() 
		{
			position = Vector2.Zero;
			rotation = 0;
		}
		
		public function Translate(translation : Vector2) : void
		{
			position = Vector2.Add(position, translation);
		}
		
		public function Rotate(rotation : Number) : void
		{
			this.rotation += rotation;
		}
		
	}

}