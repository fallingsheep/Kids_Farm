package{
	//importing required classes for this to work
	import flash.display.MovieClip;
	import flash.events.*;
    import flash.utils.Timer;
	
	public class EmptyBlock extends MovieClip{//defining the class as EmptyBlock
		private var _root:MovieClip;//creating a _root variable to access root easily
		private var m_timer:Timer;
		private var timer:Timer;
		
		public function EmptyBlock(){//this function will always run once EmptyBlock is called
			this.addEventListener(Event.ADDED, beginClass);//create a function that will run once
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);//create a enterFrame function
			this.doubleClickEnabled = true;
            mouseChildren = false;
            addEventListener( MouseEvent.CLICK, OnClick );
            addEventListener( MouseEvent.DOUBLE_CLICK, OnDoubleClick );
			
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);//setting the _root as the root level

			this.buttonMode = true;//make this act like a button
			this.addEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);//adding function for mouseOver
			this.addEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);//adding function for mouseOut
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
				
				if (Main.currentcash >= Main.fieldcost){
					
					//check if plow field selected
					
					_root.plowField(this.x,this.y);
					Main.experience += 1; // give XP
					
					
					this.buttonMode = false;
					
					this.removeEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);
					this.removeEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);
					this.removeEventListener( MouseEvent.CLICK, OnClick );
					this.removeEventListener( MouseEvent.DOUBLE_CLICK, OnDoubleClick );
				}else{
					_root.UIHolder.nocashtext.visible = true;
				}
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
		
		private function eFrameEvents(e:Event):void{
			
		}
		private function thisMouseOver(e:MouseEvent):void{
			//changing the background so the user know's it's clickable
			this.graphics.beginFill(0x006600);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();
		}
		private function thisMouseOut(e:MouseEvent):void{
			//changing the background back
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();
		}

	}
}