package{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class House extends MovieClip{
		private var _root:MovieClip;
		var House1:house1 = new house1();
		var House2:house2 = new house2();
		var House3:house3 = new house3();
		var House4:house4 = new house4();
		var House5:house5 = new house5();
		private var m_timer:Timer;
		private var timer:Timer;
		private var upgrade:Boolean = true;
		private var upgradehouse1:int = 1000;
		private var upgradehouse2:int = 1000;
		private var upgradehouse3:int = 1000;
		private var upgradehouse4:int = 1000;
		private var upgradehouse5:int = 1000;
		
				
		public function House(){
			//adding the required listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.doubleClickEnabled = true;
            mouseChildren = false;
            this.addEventListener( MouseEvent.CLICK, OnClick );
           	this.addEventListener( MouseEvent.DOUBLE_CLICK, OnDoubleClick );
			this.buttonMode = true;//make this act like a button
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);


		}
		private function eFrameEvents(e:Event):void{
			if (Main.houselevel == 1){
				this.addChild(House1);
			}
			if (Main.houselevel == 2){
				this.addChild(House2);
				if (this.contains(House1)){
					removeChild(House1);
				}
			}
			if (Main.houselevel == 3){
				this.addChild(House3);
				if (this.contains(House2)){
					removeChild(House2);
				}
			}
			if (Main.houselevel == 4){
				this.addChild(House4);
				if (this.contains(House3)){
					removeChild(House3);
				}
			}
			if (Main.houselevel == 5){
				this.addChild(House5);
				if (this.contains(House4)){
					removeChild(House4);
				}
			}

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
		private function TimerComplete( e:TimerEvent ):void
        {
            _root.UIHolder.nocashtext.visible = false;
			upgrade = true;
        }
		 private function OnDoubleClick( e:MouseEvent ):void
        {
            if ( m_timer != null )
            {
                m_timer.stop();
                m_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, OnTimerComplete );
                m_timer = null;

				if((Main.houselevel == 1)&&( upgrade == true )){
					if (Main.currentcash >= upgradehouse2){
						Main.houselevel += 1;
						Main.currentcash -= upgradehouse2;
						upgrade = false;
						this.addChild(House2);
						if (this.contains(House1)){
							removeChild(House1);
						}
					}else{
						_root.UIHolder.nocashtext.visible = true;
					}
				}
				if((Main.houselevel == 2)&&( upgrade == true )){
					if (Main.currentcash >= upgradehouse3){
						Main.houselevel += 1;
						Main.currentcash -= upgradehouse3;
						upgrade = false;
						this.addChild(House3);
						if (this.contains(House2)){
							removeChild(House2);
						}
					}else{
						_root.UIHolder.nocashtext.visible = true;
					}
				}
				if((Main.houselevel == 3)&&( upgrade == true )){
					if (Main.currentcash >= upgradehouse4){
						Main.houselevel += 1;
						Main.currentcash -= upgradehouse4;
						upgrade = false;
						this.addChild(House4);
						if (this.contains(House3)){
							removeChild(House3);
						}
					}else{
						_root.UIHolder.nocashtext.visible = true;
					}
				}
				if((Main.houselevel == 4)&&( upgrade == true )){
					if (Main.currentcash >= upgradehouse5){
						Main.houselevel += 1;
						Main.currentcash -= upgradehouse5;
						upgrade = false;
						this.addChild(House5);
						if (this.contains(House4)){
							removeChild(House4);
						}
					}else{
						_root.UIHolder.nocashtext.visible = true;
					}
				}
			}
		}
		 private function OnTimerComplete( e:TimerEvent ):void
        {
            // dispatch a click event for this button or call the click handler function
        }
	}
}