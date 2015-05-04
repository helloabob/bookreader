package chengse66.module 
{
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class ClassObject 
	{
		public var id:String;
		public var name:String;
		
		public function ClassObject() 
		{
			
		}
		
		public static function Create(item:XML):ClassObject {
			var co:ClassObject = new ClassObject();
			co.name = String(item.@name);
			co.id = String(item.@id);
			return co;
		}
		
	}

}