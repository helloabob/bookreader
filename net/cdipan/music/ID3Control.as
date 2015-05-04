/*
类功能：循环显示歌曲信息。
*/
package net.cdipan.music{
	import flash.media.Sound;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;

	public class ID3Control {
		private var _sound:Sound;
		private var _songName:String;
		private var _artist:String;
		private var _album:String;
		private var _genre:String;
		private var _year:String;
		private var num:uint;
		private var nowOutput:String;

		public function ID3Control(sound:Sound):void {
			num = 0;
			nowOutput = "";
			_sound = sound;
			_sound.addEventListener(Event.ID3, onID3);
			var myTimer:Timer = new Timer(5000, 0);
			myTimer.addEventListener("timer", outputID3);
			myTimer.start();
		}
		private function onID3(e:Event):void {
			_songName = "正在播放:"+EncodeUtf8(_sound.id3.songName);
			_artist = "歌手:"+EncodeUtf8(_sound.id3.artist);
			_album = "专辑:"+EncodeUtf8(_sound.id3.album);
			_genre = "流派:"+EncodeUtf8(_sound.id3.genre);
			_year = "发行年代:"+EncodeUtf8(_sound.id3.year);
			nowOutput = _songName;
		}
		//循环输出 ID3 信息
		private function outputID3(event:TimerEvent):void {
			num>3 ? num=0 : num++;
			switch (num) {
				case 0 :
					nowOutput = _songName;
					break;
				case 1 :
					nowOutput = _artist;
					break;
				case 2 :
					nowOutput = _album;
					break;
				case 3 :
					nowOutput = _genre;
					break;
				case 4 :
					nowOutput = _year;
					break;
			}
		}
		public function get getID3():String {
			return nowOutput;
		}
		//消除 ID3 内容的乱码
		function EncodeUtf8(str:String):String {
			var oriByteArr:ByteArray = new ByteArray();
			oriByteArr.writeUTFBytes(str);
			var tempByteArr:ByteArray = new ByteArray();
			for (var i = 0; i<oriByteArr.length; i++) {
				if (oriByteArr[i] == 194) {
					tempByteArr.writeByte(oriByteArr[i+1]);
					i++;
				} else if (oriByteArr[i] == 195) {
					tempByteArr.writeByte(oriByteArr[i+1] + 64);
					i++;
				} else {
					tempByteArr.writeByte(oriByteArr[i]);
				}
			}
			tempByteArr.position = 0;
			return tempByteArr.readMultiByte(tempByteArr.bytesAvailable,"chinese");
		}
	}
}