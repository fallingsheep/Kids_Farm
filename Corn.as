﻿package{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Corn extends MovieClip{
		private var _root:MovieClip;
		var CornA:corna = new corna();

		var GrowStage:int = 1;

		private var timer:Timer;
		private var timer2:Timer;
				
		public function Corn(){
			//adding the required listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.addEventListener( MouseEvent.CLICK, OnClick );
			
			Main.cornAmount -= 1;//remove 1 corn
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);
			if (GrowStage == 1){
			this.addChild(CornA);
			CornA.gotoAndStop(1);
			}
			this.buttonMode = false;
			//start growtimer
			timer= new Timer(1000, 1); //1000 = 1 second
			timer.addEventListener(TimerEvent.TIMER, TimerComplete);
			timer.start();

		}
		 private function OnClick( e:MouseEvent ):void
        {
			if (GrowStage == 3){
				GrowStage = 0;
				Main.cornAmount += 2;
				Main.experience += 2;
				this.parent.removeChild(this);
				this.buttonMode = true;
			}
        }
		private function eFrameEvents(e:Event):void{

			
		}
		private function TimerComplete( e:TimerEvent ):void
        {
			timer.removeEventListener(TimerEvent.TIMER, TimerComplete);
            GrowStage += 1;
			CornA.gotoAndStop(2);
			timer.stop();
			timer2= new Timer(2000, 1); //1000 = 1 second
			timer2.addEventListener(TimerEvent.TIMER, TimerComplete2);
			timer2.start();

        }
		private function TimerComplete2( e:TimerEvent ):void
        {
			timer2.removeEventListener(TimerEvent.TIMER, TimerComplete2);
            GrowStage += 1;
			CornA.gotoAndStop(3);
			timer2.stop();
			

        }
	}
}