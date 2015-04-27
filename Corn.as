package{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Corn extends MovieClip{
		private var _root:MovieClip;
		var CornA:corna = new corna();
		var CornB:cornb = new cornb();
		var CornC:cornc = new cornc();
		var GrowStage:int = 1;
		public static var CornDone:Boolean = false;
		private var timer:Timer;
				
		public function Corn(){
			//adding the required listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
			trace("corn planted");
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);
			Main.cornAmount -= 1;
			addEventListener( MouseEvent.CLICK, OnClick );
			
			this.addChild(CornA);
			//start growtimer
			timer= new Timer(10000, 1); //1000 = 1 second
			timer.addEventListener(TimerEvent.TIMER, TimerComplete);
			timer.start();

		}
		 private function OnClick( e:MouseEvent ):void
        {
			if (GrowStage == 3){
				if (this.contains(CornC)){
						removeChild(CornC);
				}
				GrowStage = 0;
				Main.cornAmount +=2;
				CornDone = true;
				
			}
        }
		private function eFrameEvents(e:Event):void{
			if (GrowStage == 2){
				if (this.contains(CornA)){
					removeChild(CornA);
				}
				this.addChild(CornB);
			}else if (GrowStage == 3){
				if (this.contains(CornB)){
					removeChild(CornB);
				}
				this.addChild(CornC);
			}
			
		}
		private function TimerComplete( e:TimerEvent ):void
        {
            GrowStage += 1;

        }
	}
}