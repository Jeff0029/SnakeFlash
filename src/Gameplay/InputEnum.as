package Gameplay 
{
	import Utils.EnumUtils;
	/**
	 * ...
	 * @author ...
	 */
	public class InputEnum
	{
		public var Text :String;
		{EnumUtils.InitEnumConstants(TileEnum);} // static ctor
		
		public static const none		:InputEnum = new InputEnum();
		public static const start		:InputEnum = new InputEnum();
		public static const retry		:InputEnum = new InputEnum();
		public static const exit		:InputEnum = new InputEnum();

	}
}