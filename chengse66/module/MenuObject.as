package chengse66.module 
{
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class MenuObject 
	{
		public var id:String;
		public var mname:String;
		public var mid:String;
		
		public function MenuObject() 
		{
			
		}
		
		public static function create(item:XML):MenuObject {
			var ii:MenuObject = new MenuObject();
			ii.id = String(item.id);
			ii.mid = String(item.mid);
			ii.mname = String(item.mname);
			return ii;
		}
	}

}