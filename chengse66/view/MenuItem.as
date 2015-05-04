package chengse66.view 
{
	import chengse66.module.MenuObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class MenuItem extends MovieClip 
	{
		public var lbl_txt:TextField;
		public var press_btn:SimpleButton;
		public var item:MenuObject;
		public function MenuItem(item:MenuObject) 
		{
			this.item = item;
			lbl_txt.text = item.mname;
			press_btn.addEventListener(MouseEvent.CLICK, onPressed);
		}
		
		private function onPressed(e:Event):void {
			if (parent) {
				parent["item_click"](this);
			}
		}
		
	}

}