package Gameplay 
{
	import Utils.EnumUtils;
	import Gameplay.SnakePart;
	/**
	 * ...
	 * @author ...
	 */
	public class DirectionEnum
	{
		public var Text :String;
		{EnumUtils.InitEnumConstants(DirectionEnum);} // static ctor
		
		public static const up			:DirectionEnum = new DirectionEnum();
		public static const down		:DirectionEnum = new DirectionEnum();
		public static const left		:DirectionEnum = new DirectionEnum();
		public static const right		:DirectionEnum = new DirectionEnum();

	}
}