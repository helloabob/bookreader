package chengse66.view 
{
	import chengse66.module.ClassObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class ClassItem extends MovieClip 
	{
		public var item:ClassObject;
		public function ClassItem(item:ClassObject) 
		{
			this.item = item;
			this.gotoAndStop("f"+item.id);
		}
		
	}

}