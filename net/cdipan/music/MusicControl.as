/*
类功能：载入外部音乐、控制音乐播放和显示音乐播放进度。
*/
package net.cdipan.music{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;
	 import flash.media.SoundTransform 

	public class MusicControl extends Sprite {
		//声音对象
		private var _music:Sound;
		public function get _getMusic():Sound {
			return _music;
		}
		//缓冲时间
		private var _bufferTime:SoundLoaderContext;
		//声音管理对象
		public var _channel:SoundChannel=new SoundChannel()
		//记录频谱的数组，共 512 个元素(type 为 true 时返回频谱，为 false 时返回波形)
		private var _spectrumArray:ByteArray;
		public function _spectrum(type:Boolean):ByteArray {
			SoundMixer.computeSpectrum(_spectrumArray,type);
			return _spectrumArray;
		}
		//记录目前是否在播放中
		private var _playing:Boolean;
		public function get _getPlaying():Boolean {
			return _playing;
		}
		//记录当前播放的时间，用于暂停后从暂停处开始播放
		private var _playPosition:int;

		//要输出的事件
		public static const PLAYOVRE:String = "playOver";
		public static const PLAYERROR:String = "playError";

		public function MusicControl():void {
			_music = new Sound();
			//缓冲 5 秒
			_bufferTime = new SoundLoaderContext();
			_bufferTime.bufferTime = 5000;
			//音乐频谱数组
			_spectrumArray = new ByteArray();
			_playing = false;
			_playPosition = 0;
		}
		
		public function changeVolue(nn:Number):void {
			var trans:SoundTransform=new SoundTransform() 
            //获取声音的值，并加入转换对象 
            trans.volume=nn 
            //cuplayer.com实现转换 
			
            _channel.soundTransform=trans 
		}
		
		   
		//载入外部文件
		public function loadMusic(url:String):void {
			_music.load(new URLRequest(url), _bufferTime);
			_music.addEventListener(IOErrorEvent.IO_ERROR, playError);
		}
		//加载出错
		private function playError(e:IOErrorEvent):void {
			dispatchEvent(new Event(MusicControl.PLAYERROR));
		}
		//播放暂停
		public function playPauseMusic(ppp:Number):void {
			
			if (ppp==0){
				if (_playing) {
				_playPosition = _channel.position;
				_channel.stop();
			} else {
				_channel = _music.play(_playPosition);
				changeVolue(0.55);
				//播放结束事件
				_channel.addEventListener(Event.SOUND_COMPLETE, playOver);
			}
			_playing = !_playing;
			}else {
				_playPosition=ppp
				if (_playing) {
				_playPosition = _channel.position;
				_channel.stop();
			} else {
				_channel = _music.play(_playPosition);
				changeVolue(0.55);
				//播放结束事件
				_channel.addEventListener(Event.SOUND_COMPLETE, playOver);
			}
			_playing = !_playing;
				
			}
			
		}
		//播放结束
		private function playOver(e:Event):void {
			dispatchEvent(new Event(MusicControl.PLAYOVRE));
		}
		//停止
		public function stopMusic():void {
			_playPosition = 0;
			_channel.stop();
			_playing = false;
		}
		//返回播放的百分比
		public function get percentage():Number {
			var _length:int = _music.length;
			_length /= _music.bytesLoaded / _music.bytesTotal;
			return _channel.position / _length;
		}
		//返回播放进度的文本(00:00/00:00格式)
		public function get playTime():String {
			var _length:int = _music.length;
			//因为 lenght 返回的是已加载到的音乐的长度，如果一首 4 分钟的歌，
			//只加载了一半，就只会输出 120000 毫秒，所以要特别的处理一下。
			_length /= _music.bytesLoaded / _music.bytesTotal;
			//目前播放到的时间
			var _position:int = _channel.position;
			//转换成秒
			_length = int(_length/1000);
			_position = int(_position/1000);
			//分秒分离
			var play_minute:uint = int(_position/60);
			var total_minute:uint = int(_length/60);
			var play_second:uint = _position%60;
			var total_second:uint = _length%60;
			//转换为文本
			var play_minute_str:String = play_minute.toString();
			var total_minute_str:String = total_minute.toString();
			var play_second_str:String = play_second.toString();
			var total_second_str:String = total_second.toString();
			//为个位数之前添加一个 0
			if (play_minute_str.length == 1) {
				play_minute_str = "0"+play_minute_str;
			}
			if (total_minute_str.length == 1) {
				total_minute_str = "0"+total_minute_str;
			}
			if (play_second_str.length == 1) {
				play_second_str = "0"+play_second_str;
			}
			if (total_second_str.length == 1) {
				total_second_str = "0"+total_second_str;
			}//按格式返回
			return play_minute_str + ":" + play_second_str + "/" + total_minute_str + ":" + total_second_str;
		}
	}
}