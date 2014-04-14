package Gameplay 
{
	import Utils.EnumUtils;
	/**
	 * ...
	 * @author ...
	 */
	public class TileEnum
	{
		public var Text :String;
		{EnumUtils.InitEnumConstants(TileEnum);} // static ctor
		
		public static const empty			:TileEnum = new TileEnum();
		public static const snakePart		:TileEnum = new TileEnum();
		public static const snakeFood		:TileEnum = new TileEnum();

	}
}