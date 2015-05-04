package chengse66.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class JujiItem extends MovieClip
	{
		public var n_txt:TextField;
		public var n:Number;
		public var press_btn:SimpleButton;

		public function JujiItem(n:int,name_str:String)
		{
			this.n = n;
			press_btn.addEventListener(MouseEvent.CLICK, mx_press);
			if (n==0)
			{
				n_txt.text = "播   放";
				return;
			}
			if (n == 987) {
				n_txt.text = "阅   读 ";
				return;
			}
			
			
			n_txt.text = name_str;
			
			
			
		}

		private function mx_press(e:Event):void
		{
			this.dispatchEvent(new Event("jj_click",true,true));
		}
	}

}