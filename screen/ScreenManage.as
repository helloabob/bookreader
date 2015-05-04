package screen
{
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import flash.ui.Mouse;
	import flash.ui.ContextMenu;
	import chengse66.Common;

	public class ScreenManage extends MovieClip
	{
		private static var _instance:ScreenManage;
		public var timeOut:Number = 60;
		public var showLogo:int = 1;
		public var showMouse:int = 1;
		public var rightClick:int = 1;
		public var ip_add:String=""

		private var timer:Timer;
		private var content:Stage;

		private var logo:MovieClip;

		private var _locked:Boolean = false;
		public function ScreenManage()
		{

		}

		public function initalize(_stage:Stage,logo:MovieClip=null,path:String="TimeLate.xml"):void
		{
			content = _stage;
			this.logo = logo;
			var loader:URLLoader = new URLLoader(new URLRequest(path));
			loader.addEventListener(IOErrorEvent.IO_ERROR,systemLoad);
			loader.addEventListener(Event.COMPLETE,onLoadCompleted);
		}

		private function onLoadCompleted(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			loader.removeEventListener(IOErrorEvent.IO_ERROR,trace);
			loader.removeEventListener(Event.COMPLETE,onLoadCompleted);
			var xml:XML = new XML(loader.data);
			timeOut = int(xml.timeOut);
			showLogo = int(xml.showLogo);
			showMouse = int(xml.showMouse);
			rightClick = int(xml.rightClick);
			ip_add=String(xml.ip_address)
			Common.URL=ip_add;
			trace (Common.URL)
			Common.getMenuURL=ip_add+ "ServerTest/AllClassFirstFlash";
			Common.getDocMenuURL=ip_add+ "ServerTest/ClassSecondInfoFlash";
			Common.getTypeListURL=ip_add+ "ServerTest/ClassTypeFlash";
			Common.getInfoListURL=ip_add+ "ServerTest/FileDetailListFlash";
			Common.getInfoURL=ip_add+ "ServerTest/FileDetailInfoFlash";
			Common.updatePostiveCount=ip_add+ "ServerTest/PositiveCountServlet";
			
			

			var mydate = new Date();
			var mounth = mydate.getMonth() + 1;
			
			if (showMouse==0)
			{
				Mouse.hide();
			}
			if (rightClick==0)
			{
				content.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,function(e:MouseEvent):void{});
			}
			systemLoad();
			this.dispatchEvent(new Event("gogo"));
		}

		private function systemLoad(e:Event=null):void
		{
			timer=new Timer(timeOut*1000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.reset();
			timer.start();

			content.addEventListener(MouseEvent.MOUSE_DOWN,onUnlock);
			content.addEventListener(MouseEvent.MOUSE_MOVE,onUnlock);
		}

		public function onUnlock(e:Event=null):void
		{
			//trace ("update")
			timer.reset();
			timer.start();
		}

		private function onTimer(e:TimerEvent):void
		{
			if (! _locked)
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function lock():void
		{
			_locked = true;
		}

		public function unlock():void
		{
			_locked = false;
		}

		public function update():void
		{
			//trace ("update")
			timer.stop();
			timer.start();
		}

		public static function manage():ScreenManage
		{
			if (_instance==null)
			{
				_instance=new ScreenManage();
			}
			return _instance;
		}
	}

}