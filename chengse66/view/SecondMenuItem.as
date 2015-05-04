package chengse66.view 
{
	import chengse66.module.SecondMenuObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class SecondMenuItem extends MovieClip 
	{
		public var item:SecondMenuObject;
		public var lbl_txt:TextField;
		public var press_btn:MovieClip;
		public var n_id:String;
		
		public function SecondMenuItem(item:SecondMenuObject) 
		{
			this.item = item;
			lbl_txt.wordWrap = false;
			lbl_txt.autoSize = TextFieldAutoSize.CENTER;
			lbl_txt.text = item.class_second_name;
			press_btn.width = this.width;
			press_btn.height = this.height;
			press_btn.buttonMode = true;
			press_btn.addEventListener(MouseEvent.CLICK, mx_press);
			
		}
		public function go():void {
			this.gotoAndPlay("in")
		}
		
		
		private function mx_press(e:MouseEvent):void {
			this.dispatchEvent(new Event("sec_click",true,true));
		}
		
	}

}