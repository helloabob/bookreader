package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class MediaPlayer extends Sprite
	{
		public var ns:NetStream;
		public var nc:NetConnection;
		public var duration:Number;
		
		public function MediaPlayer()
		{
			nc=new NetConnection();
			nc.connect(null);
			ns=new NetStream(nc);
			var _clientOb:Object = new Object(); 
			_clientOb.onMetaData = onMetaData;
			ns.client=_clientOb;
			var video:Video=new Video(600,400);
			video.attachNetStream(ns);
			this.addChild(video);
			ns.play("test.flv");
			ns.addEventListener(NetStatusEvent.NET_STATUS,mx_status);
			
		}
		
		private function onMetaData(data:Object):void{
			duration=data.duration;
		}
		
		private function mx_status(e:NetStatusEvent):void{
			switch(e.info.code) 
			{ 
				case "NetStream.Play.Start"://CuPlayer.com提示开始播放 
					this.addEventListener(Event.ENTER_FRAME,mx_loop);
					break; 
				case "NetStream.Play.Stop"://Cuplayer.com全部播放完 
					this.removeEventListener(Event.ENTER_FRAME,mx_loop);
					break; 
				case "NetStream.Buffer.Empty"://Cuplayer.com缓冲 
					break; 
			} 
		}
		
		private function mx_loop(e:Event):void{
			trace(Math.floor(ns.time/60) +":"+ Math.round(ns.time%60)+"/" +Math.floor(duration/60) +":"+ Math.round(duration%60));
		}
	}
}