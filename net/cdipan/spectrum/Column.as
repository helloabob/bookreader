/*
类功能：柱状的频谱。
*/
package net.cdipan.spectrum{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Column extends Sprite {
		//顶部小方块颜色
		private const square_color:uint = 0xffffff;
		//顶部颜色
		private const top_color:uint = 0xffffff;
		//中间颜色
		private const middle_color:uint = 0x8cdcff;
		//底部颜色
		private const bottom_color:uint = 0x07f7ff;

		//背景精灵对象
		private var BG_Sp:Sprite;
		//遮罩精灵对象
		private var mask_Sp:Sprite;
		//小方块精灵对象
		private var square_Sp:Sprite;

		//记录上次的频谱的值，如果比这次的高就减一，否则将这次的设为此值
		private var oldNum:Number;

		//计时器对象
		private var myTimer:Timer;
		//记录小方块是否可以下落
		private var canDrop:Boolean;

		public function Column():void {
			BG_Sp = new Sprite();
			drawGradualRect();
			addChild(BG_Sp);
			mask_Sp = new Sprite();
			drawMaskRect();
			addChild(mask_Sp);
			square_Sp = new Sprite();
			drawSquareRect();
			square_Sp.y = 99;
			square_Sp.addEventListener(Event.ENTER_FRAME, _enterframe);
			addChild(square_Sp);
			//设置遮罩
			BG_Sp.mask = mask_Sp;
			oldNum = 0;
			myTimer = new Timer(200, 1);
			myTimer.addEventListener("timer", onTimer);
			canDrop = false;
		}
		//使小方块下落
		private function _enterframe(e:Event):void {
			if (canDrop) {
				square_Sp.y += 4;
			}
			if (square_Sp.y > 99) {
				square_Sp.y = 99;
			}
			if (square_Sp.y < -1) {
				square_Sp.y = -1;
			}
		}
		//绘制渐变图形
		private function drawGradualRect():void {
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [top_color, middle_color, bottom_color];
			var alphas:Array = [1, 1, 1];
			var ratios:Array = [0x00, 0x7f, 0xff];
			BG_Sp.graphics.beginGradientFill(fillType, colors, alphas, ratios);
			BG_Sp.graphics.drawRect(0,-1,100,1);
			BG_Sp.rotation = 90;
		}
		//绘制遮罩图形
		private function drawMaskRect():void {
			mask_Sp.graphics.lineStyle();
			mask_Sp.graphics.beginFill(0);
			mask_Sp.graphics.drawRect(0,-100,1,100);
			mask_Sp.graphics.endFill();
			mask_Sp.y = 100;
		}
		//绘制小方块
		private function drawSquareRect():void {
			square_Sp.graphics.lineStyle();
			square_Sp.graphics.beginFill(square_color);
			square_Sp.graphics.drawRect(0,0,1,1);
			square_Sp.graphics.endFill();
		}
		//接收频谱数据
		public function getSpectrum(num:Number):void {
			if (oldNum > num) {
				oldNum -= 7;
			} else {
				oldNum = num;
				if (oldNum != 0) {
					//调用小方块运动的函数
					squareMove(oldNum);
				}
			}
			if (oldNum<0) {
				oldNum = 0;
			}
			mask_Sp.height = oldNum;
		}
		//控制小方块运动的函数
		private function squareMove(num:Number):void {
			if (square_Sp.y > 99 - oldNum) {
				square_Sp.y = 99 - num;
				canDrop = false;
				myTimer.reset();
				myTimer.start();
			}
		}
		public function onTimer(e:TimerEvent):void {
			canDrop = true;
		}
	}
}