package chengse66.module 
{
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class SecondMenuObject 
	{
		public var id:String;
		public var class_second_name:String;
		public var class_second_id:String;
		public var parent:String;
		
		public function SecondMenuObject() 
		{
			
		}
		
		public static function create(item:XML):SecondMenuObject {
			var m:SecondMenuObject = new SecondMenuObject();
			m.id = String(item.id);
			m.class_second_name = String(item.class_second_name);
			m.class_second_id = String(item.class_second_id);
			m.parent = String(item.parent);
			return m;
		}
	}

}