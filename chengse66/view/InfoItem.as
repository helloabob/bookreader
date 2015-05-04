package chengse66.view
{

	import chengse66.module.InfoObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import chengse66.Common;


	public class InfoItem extends MovieClip
	{

		public var item:InfoObject;
		public var press_btn:SimpleButton;
		public var lbl_txt:TextField;
		public var cover_mc:MovieClip;
		public var cover_mask:MovieClip;
		public var loader:Loader;
		public var zan_sum:int;
		public function InfoItem(item:InfoObject)
		{
			// constructor code
			this.item = item;
			lbl_txt.text = item.file_name;
			p_txt.text = item.file_positivecount;
			var arr_leixing:Array = ["视 频","音 频","图 书","图 片"];

			var leixingid:int = int(item.file_class_third) - 101;

			leixing_txt.text = arr_leixing[leixingid];
			//var path:String =Common.URL+ "resources/" + item.file_path.replace(/\\/g, "/") + item.file_name+".jpg";
			var path:String = "resources/" + item.file_path.replace(/\\/g,"/") + "/cover.jpg";
			//备注文件路径
			press_btn.addEventListener(MouseEvent.CLICK, mx_press);
			//loader = new Loader();
			//loader.cacheAsBitmap = true;
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, mx_complete);
			//cover_mc.addChild(loader);
			//init image
			//encodeURI();
			//this.load(encodeURI(Common.URL + path));
		    pic.setPic((Common.URL1 + path));
		    //pic.setPic("复兴之路.png");
			zan_sum = int(item.file_positivecount);
		}

		public function load(path:String):void
		{
			var req:URLRequest = new URLRequest(path);
			req.url = path;
			loader.load(req);
		}

		private function mx_complete(e:Event):void
		{
			loader.scaleX = loader.scaleY = 1;
			var scale:Number = Math.max(cover_mask.width / loader.width,cover_mask.height / loader.height);
			loader.scaleX = loader.scaleY = scale;
			loader.x = (cover_mc.width - loader.width) / 2;
			loader.y = (cover_mc.height - loader.height) / 2;
		}

		private function mx_press(e:MouseEvent):void
		{
			this.dispatchEvent(new Event("info_click",true,true));
		}
		public function jizan():void
		{
			trace("数量"+zan_sum);
			zan_sum +=  1;
			p_txt.text = zan_sum;
			
		}
	}

}