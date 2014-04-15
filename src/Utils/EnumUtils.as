package Utils 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ...
	 */
	public class EnumUtils 
	{
		public static function InitEnumConstants(inType :*) :void
		{
			var type :XML = flash.utils.describeType(inType);
			for each (var constant :XML in type.constant)
				inType[constant.@name].Text = constant.@name;
		}	
			
		public function EnumUtils() 
		{
			
		}
		
	}

}