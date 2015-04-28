package{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.events.*;
	    import flash.utils.Timer;
	public class Field extends MovieClip{
		private var _root:MovieClip;
		private var m_timer:Timer;
		private var timer:Timer;
		var xval:int;
		var yval:int;
		var Grass:grass = new grass();
				
		public function Field(){
			//adding the required listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.doubleClickEnabled = true;
            mouseChildren = false;
            addEventListener( MouseEvent.CLICK, OnClick );
            addEventListener( MouseEvent.DOUBLE_CLICK, OnDoubleClick );
			trace("Field Plowed");
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);
			Main.currentcash -= Main.fieldcost;
			
			this.addChild(Grass);

		}
		private function eFrameEvents(e:Event):void{
			
		}
		private function OnClick( e:MouseEvent ):void
        {
            m_timer = new Timer( 250, 1 );
            m_timer.addEventListener( TimerEvent.TIMER_COMPLETE, OnTimerComplete );
            m_timer.start();
			//text timer
			timer= new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, TimerComplete);
			timer.start();
        }

        private function OnDoubleClick( e:MouseEvent ):void
        {
            if ( m_timer != null )
            {
                m_timer.stop();
                m_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, OnTimerComplete );
                m_timer = null;
				//crop pos offset for centering crop on field
				xval = this.x+12.5;
				yval = this.y+12.5;
				//check which crop selected
				_root.plantCorn(xval,yval);
				
			}
        }
 		private function TimerComplete( e:TimerEvent ):void
        {
            _root.UIHolder.nocashtext.visible = false;
        }
		 private function OnTimerComplete( e:TimerEvent ):void
        {
            // dispatch a click event for this button or call the click handler function
        }
	}
}