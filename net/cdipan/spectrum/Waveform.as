/*
类功能：波形。
*/
package net.cdipan.spectrum{
	import flash.display.*;
	import flash.filters.*;
	import flash.geom.*;

	public class Waveform extends Sprite {
		//线条颜色
		private const line_color:uint = 0x07f7ff;

		//创建用来绘制线条的精灵对象
		private var Line:Sprite;
		//用于逐渐消失的轨迹的位图对象
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		//滤镜的各项参数
		private var colorM:ColorMatrixFilter;
		private var blur:BlurFilter;
		private var r:Rectangle;
		private var p:Point;
		//通过数字使滤镜处理慢一步
		private var num:int;

		public function Waveform():void {
			Line = new Sprite();
			bmpData = new BitmapData(256,100,true,0);
			bmp = new Bitmap(bmpData);
			colorM = new ColorMatrixFilter([.98,0,0,0,0,0,.98,0,0,0,0,0,.98,0,0,0,0,0,.5,0]);
			blur = new BlurFilter(7,7,BitmapFilterQuality.LOW);
			r = new Rectangle(0,0,256,100);
			p = new Point(0,0);
			//添加显示对象
			this.blendMode=BlendMode.ADD;
			this.addChild(bmp);
			this.addChild(Line);
		}
		//接收频谱数据
		public function getSpectrum(array:Array):void {
			if (num%2 == 0) {
				var m:Number = 0;
				for (var j=0; j<256; j+=2) {
					m += array[j];
				}
				if (m != 0) {
					//停止播放时不绘制图像，就只会显示一条直线
					bmpData.draw(this);
				}
				bmpData.applyFilter(bmpData,r,p,colorM);
				bmpData.applyFilter(bmpData,r,p,blur);
			}
			num++;
			Line.graphics.clear();
			Line.graphics.lineStyle(1,line_color,100);
			for (var i=0; i<256; i+=2) {
				var n:Number = array[i]*50;
				if (i != 0) {
					Line.graphics.lineTo(i,50-n);
				} else {
					Line.graphics.moveTo(0,50-n);
				}
			}
		}
	}
}