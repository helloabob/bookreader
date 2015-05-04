package chengse66.utils 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.IOErrorEvent;

	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class HttpUtil 
	{
		/**
		 * 加载远程URL信息
		 * @param	url
		 * @param	data
		 * @param	success
		 */
		public static function getURL(url:String, data:Object, success:Function) {
			var req:URLRequest = new URLRequest(url);
			req.method = "GET";
			var uv:URLVariables = new URLVariables();
			uv.rnd = new Date().time;
			for (var i:String in data) {
				uv[i] = data[i];
			}
			req.data = uv;
			trace(req.url+"?"+uv.toString());
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE, mx_complete);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR,mx_error)
			function mx_complete(e:Event):void {
				success.apply(null,[e.target.data]);
			}
			function mx_error(e:Event):void {
				success.apply(null,["1"]);
			}
			
		}
		
	}

}