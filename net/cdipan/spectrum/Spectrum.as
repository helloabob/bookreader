/*
类功能：显示频谱。
*/
package net.cdipan.spectrum{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	public class Spectrum extends Sprite {
		//记录频谱的数组
		private var _spectrum:Array;
		//记录显示的类型
		private var _type:int;
		//用于显示频谱的精灵对象
		private var _showSpectrum:Sprite;
		//用于显示柱状频谱的精灵对象
		private var _show1:Sprite;
		//用于显示波浪频谱的精灵对象
		private var _show2:Sprite;
		//用于显示波形频谱的精灵对象
		private var _show3:Sprite;
		//柱形对象
		private var _column:Column;
		//波形对象
		private var _waveform:Waveform;

		public function Spectrum():void {
			this.addChild(createLogo());

			_spectrum = new Array(512);
			_showSpectrum = new Sprite();
			_showSpectrum.x = 22;
			_showSpectrum.y = 18;

			_show1 = new Sprite();
			_show2 = new Sprite();
			_show3 = new Sprite();

			this.addChild(_showSpectrum);
			//创建柱状频谱
			createColumn(64,3,1,_show1);
			createColumn(256,1,0,_show2);
			//创建波形频谱
			_waveform = new Waveform();
			_show3.addChild(_waveform);

			_showSpectrum.addChild(_show1);
		}
		private function createLogo():Sprite {
			var logo:Sprite = new Sprite();
			var myText:TextField = new TextField();
			myText.text = "cdipan.net - WizardC";
			myText.width = 120;
			myText.textColor = 0xffffff;
			myText.selectable = false;
//			myText.mouseEnabled = false;
			myText.height = 18;
			logo.addChild(myText);
			logo.x = 190;
			logo.graphics.lineStyle();
			logo.graphics.beginFill(0,0);
			logo.graphics.drawRect(0,0,110,18);
			logo.graphics.endFill();
//			logo.buttonMode = true;
//			logo.useHandCursor = true;
//			logo.addEventListener(MouseEvent.CLICK, onClick);
			return logo;
		}
//		private function onClick(e:MouseEvent):void {
//			navigateToURL(new URLRequest("http://www.cdipan.net/"),"_blank");
//		}
		//获取频谱数组
		public function getSpectrum(byteArray:ByteArray):void {
			for (var i:int=0; i<512; i++) {
				_spectrum[i] = byteArray.readFloat();
			}
			//将频谱数据传送给柱状和波浪的精灵实例
			for (var j:int=0; j<64; j++) {
				var temp1:Column = _show1.getChildByName("column_"+j.toString()) as Column;
				temp1.getSpectrum((_spectrum[j*4]+_spectrum[j*4+1]+_spectrum[j*4+2]+_spectrum[j*4+3]+_spectrum[j*4+256]+_spectrum[j*4+257]+_spectrum[j*4+258]+_spectrum[j*4+259])*12.5);
			}
			for (var m:int=0; m<256; m++) {
				var temp2:Column = _show2.getChildByName("column_"+m.toString()) as Column;
				temp2.getSpectrum((_spectrum[m]+_spectrum[m+256])*50);
			}
			//将频谱数据传送给波形的精灵实例
			_waveform.getSpectrum(_spectrum);
		}
		//创建柱状的精灵对象
		private function createColumn(f_num:int,f_width:int,f_space:int,target:Sprite):void {
			for (var i:int=0; i<f_num; i++) {
				_column = new Column();
				_column.name = "column_"+i.toString();
				_column.width = f_width;
				_column.x = i*(f_width+f_space);
				target.addChild(_column);
			}
		}
		//更改样式(type 为 0 时显示柱形，为 1 时显示波浪，为 2 时显示波形)
		public function changeType(type:int):void {
			switch (type) {
				case 0 :
					if (_showSpectrum.contains(_show1)) {
						_showSpectrum.removeChild(_show1);
					}
					if (_showSpectrum.contains(_show2)) {
						_showSpectrum.removeChild(_show2);
					}
					if (_showSpectrum.contains(_show3)) {
						_showSpectrum.removeChild(_show3);
					}
					_showSpectrum.addChild(_show1);
					break;
				case 1 :
					if (_showSpectrum.contains(_show1)) {
						_showSpectrum.removeChild(_show1);
					}
					if (_showSpectrum.contains(_show2)) {
						_showSpectrum.removeChild(_show2);
					}
					if (_showSpectrum.contains(_show3)) {
						_showSpectrum.removeChild(_show3);
					}
					_showSpectrum.addChild(_show2);
					break;
				case 2 :
					if (_showSpectrum.contains(_show1)) {
						_showSpectrum.removeChild(_show1);
					}
					if (_showSpectrum.contains(_show2)) {
						_showSpectrum.removeChild(_show2);
					}
					if (_showSpectrum.contains(_show3)) {
						_showSpectrum.removeChild(_show3);
					}
					_showSpectrum.addChild(_show3);
					break;
			}
		}
	}
}