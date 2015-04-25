package 
{
	import flash.geom.*;
    import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.system.*;
	import flash.desktop.*;
	import flash.ui.*;
	

    public class Main extends MovieClip 
    {
		
		public var HA:String = 'HOUSE';
		public var HB:String = 'HOUSEBORDER';
		
		public var intro:intro_mc = new intro_mc();
		public var LevelHolder:levelholder_mc = new levelholder_mc();
		public var UIHolder:uiholder_mc = new uiholder_mc();
		
		public var saveAchivementDataObject:SharedObject;

		public static var fieldcost:int = 10;
		
		//achivements
		public var achive1,achive2,achive3,achive4,achive5,achive6,achive7,achive8,achive9,achive10:Boolean;
		public var achive11,achive12,achive13,achive14,achive15,achive16,achive17,achive18,achive19,achive20:Boolean;
		public var achive21,achive22,achive23,achive24,achive25,achive26,achive27,achive28,achive29,achive30:Boolean;
		public var achive31,achive32,achive33,achive34,achive35,achive36,achive37,achive38,achive39,achive40:Boolean;
		public var achive41,achive42,achive43,achive44,achive45,achive46,achive47,achive48,achive49,achive50:Boolean;
		
		
		public var lvlArray = [
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,HB,HB,HB,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,HB,HA,HB,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,HB,HB,HB,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
		];
		


		//Debug
		var frames:int=0;
		var FPS:int=0;
		var prevTimer:Number=0;
		var curTimer:Number=0;
		
		//Cash
		public static var currentcash:int = 5000;//cash
		public static var globalcashearnt:int;
		public static var globalcashspent:int;
		
		public static var level:int = 0;//player level
		public static var experience:int = 0;
		public static var farmSize:int = 1;
		public static var houselevel:int = 1;
		
		
        public function Main()
        {
			addChild(intro);
			intro.addEventListener(MouseEvent.CLICK, beginPlay);
        }
				//START GAME
		public function beginPlay(event:MouseEvent):void {
			intro.removeEventListener(MouseEvent.CLICK, beginPlay);
			if (this.contains(intro)){
				removeChild(intro);
			}
			//TImer
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, timerTickHandler);
			
			//load achivement data
			loadachiveData();
			startGame();
			//Load scripts
			stage.addEventListener(Event.ENTER_FRAME,processScripts);
			UIHolder.nocashtext.visible = false;
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					SCRIPTS / MODULES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function processScripts(e:Event):void{
			//debug fps + mem
			debugstuff();
			updatetext();
			
		}
public function updatetext():void{
	UIHolder.cashtext.text = ("$"+currentcash.toString());
	UIHolder.leveltext.text = (level.toString());
}
function startGame():void{//we'll run this function every time a new level begins

	addChild(LevelHolder);//add it to the stage
	LevelHolder.x = -200;
	LevelHolder.y = -225;

	LevelHolder.addEventListener("mouseDown", md);
	Multitouch.inputMode = MultitouchInputMode.GESTURE;
    LevelHolder.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			
    LevelHolder.addEventListener(MouseEvent.MOUSE_WHEEL, zoomIn);
    LevelHolder.addEventListener(MouseEvent.MOUSE_WHEEL, zoomOut);
	
	makeLevel();
	
	addChild(UIHolder);//add it to the stage
	UIHolder.x = 0;
	UIHolder.y = 400;
}




function makeLevel():void{
	var row:int = 0;//the current row we're working on
	var block;//this will act as the block that we're placing down
	for(var i:int=0;i<lvlArray.length;i++){//creating a loop that'll go through the level array
		if(lvlArray[i] == 0){//if the current index is set to 0
			block = new EmptyBlock();//create a gray empty block
			block.graphics.beginFill(0x333333);
			block.graphics.drawRect(0,0,25,25);
			block.graphics.endFill();
			LevelHolder.addChild(block);
			//and set the coordinates to be relative to the place in the array
			block.x= (i-row*22)*25;
			block.y = row*25;
		} else if(lvlArray[i] == 1){//if there is supposed to be a row
			//just add a box that will be a darker color and won't have any actions
			block = new dirt();	
			block.x= (i-row*22)*25;
			block.y = row*25;	
			LevelHolder.addChild(block);//add it to the roadHolder
		} else if(lvlArray[i] is String){//if it's a string, meaning a special block
			//then create a special block
			block = new HouseBlock(lvlArray[i],(i-row*22)*25,row*25);
			LevelHolder.addChild(block);
		}
		for(var c:int = 1;c<=16;c++){
			if(i == c*22-1){
				//if 22 columns have gone by, then we move onto the next row
				row++;
			}
		}
	}
}
public static var canaddfield:Boolean = false;

function plowField(xValue:int,yValue:int):void{//this will need to be told the x and y values
	var field:Field = new Field();//creating a variable to hold the Turret

		field.x = xValue+12.5;
		field.y = yValue+12.5;
		LevelHolder.addChild(field);//add it to the stage

}
		//Rank up timer checker

function addHouse(xValue:int,yValue:int):void{//this will need to be told the x and y values
	var house1:House = new House();//creating a variable to hold the Turret
	//changing the coordinates
	house1.x = xValue+12.5;
	house1.y = yValue+12.5;
	LevelHolder.addChild(house1);//add it to the stage
}
function onZoom(e:TransformGestureEvent):void
{
    if ((((LevelHolder.scaleX <= 4)) && ((LevelHolder.scaleX >= 0.8)))){
        LevelHolder.scaleX = (LevelHolder.scaleX * e.scaleX);
        LevelHolder.scaleY = (LevelHolder.scaleY * e.scaleY);
    };
}
function zoomIn(event:MouseEvent):void
{
    if (event.delta > 0){
        if (LevelHolder.scaleX <= 2){
            LevelHolder.scaleX = (LevelHolder.scaleX + 0.2);
            LevelHolder.scaleY = (LevelHolder.scaleY + 0.2);
        };
    };
}
function zoomOut(event:MouseEvent):void
{
    if (event.delta < 0){
        if (LevelHolder.scaleX >= 1.2){
            LevelHolder.scaleX = (LevelHolder.scaleX - 0.2);
            LevelHolder.scaleY = (LevelHolder.scaleY - 0.2);
        };
    };
}
function md(evt:*):void
{
    LevelHolder.startDrag(false, new Rectangle(-2000, -1600, 5000, 3200));
    LevelHolder.addEventListener("mouseUp", mu);
}
function mu(evt:*):void
{
    LevelHolder.stopDrag();
    LevelHolder.removeEventListener("mouseUp", mu);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							SAVE LOAD
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		

		public var saveDataObject:SharedObject;

		public function saveData(){
				saveDataObject = SharedObject.getLocal("test"); 
				saveDataObject.data.savedcurrentcash = currentcash;
				trace("Game Saved!");//replace with conformation screen later
				
				saveDataObject.flush(); // immediately save to the local drive
				trace(saveDataObject.size); // this will show the size of the save file, in bytes
		}
		function loadData():void{
			saveDataObject = SharedObject.getLocal("test"); 
				currentcash = saveDataObject.data.savedcurrentcash;
			//DONT LOAD ACHIVEMENT DATA HERE IT WILL OVERWRITE ANY NEW DATA IN CURRENT SESSION!!
				//LOAD ACHIVEMENT DATA WHEN GAME FIRST STARTS
				
			trace("Game Loaded!");	
		}
		public function SaveGame(e:MouseEvent):void{
					saveData();
					processAchivements();
					saveachiveData();
					trace("GAME SAVED");
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							ACHIVEMENTS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		

		public function processAchivements():void{
			//CASH EARNT
			if( globalcashearnt >= 1000){
				achive1 = true;
			}
			if( globalcashearnt >= 5000){
				achive2 = true;
			}
			if( globalcashearnt >= 10000){
				achive3 = true;
			}
			if( globalcashearnt >= 100000){
				achive4 = true;
			}
			if( globalcashearnt >= 1000000){
				achive5 = true;
			}
			//CASH SPENT
			if( globalcashspent>= 1000){
				achive6 = true;
			}
			if( globalcashspent >= 5000){
				achive7 = true;
			}
			if( globalcashspent >= 10000){
				achive8 = true;
			}
			if( globalcashspent >= 100000){
				achive9 = true;
			}
			if( globalcashspent >= 1000000){
				achive10 = true;
			}
			//TIME PLAYED
			if( totalTimeplayed >= 1){
				achive11 = true;
			}
			if( totalTimeplayed >= 60){
				achive12 = true;
			}
			if( totalTimeplayed >= 120){
				achive13 = true;
			}
			if( totalTimeplayed >= 300){
				achive14 = true;
			}
			if( totalTimeplayed >= 600){
				achive15 = true;
			}
		}
		
		public function saveachiveData():void{
				saveAchivementDataObject = SharedObject.getLocal("achivements"); 
				saveAchivementDataObject.data.savedglobalcashearnt = globalcashearnt;
				saveAchivementDataObject.data.savedsglobalcashspent = globalcashspent;

				saveAchivementDataObject.data.savedglobalseconds = globalseconds;
				saveAchivementDataObject.data.savedglobalminutes = globalminutes;
				
				saveAchivementDataObject.flush(); // immediately save to the local drive
		}
		public function loadachiveData():void{
			saveAchivementDataObject = SharedObject.getLocal("achivements"); 
			
			globalcashearnt = saveAchivementDataObject.data.savedglobalcashearnt;
			globalcashspent = saveAchivementDataObject.data.savedsglobalcashspent;
			globalseconds = saveAchivementDataObject.data.savedglobalseconds;
			globalminutes = saveAchivementDataObject.data.savedglobalminutes;
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							DEBUG
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		

		public function debugstuff():void{
			frames+=1;
			curTimer=getTimer();
				if(curTimer-prevTimer>=1000){
					FPS = Math.round(frames*1000/(curTimer-prevTimer));
					
					prevTimer=curTimer;
					frames=0;
				}
			debugmemorytext.text = ((System.totalMemory / 1024 / 1024).toFixed(2)).toString() + "MB";
			debugfpstext.text = FPS.toString();
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							Time Played
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public var timer:Timer = new Timer(60);
		public var timerCount:int = 0;
		public var globaltimerCount:int = 0;
		
		public function timerTickHandler(Event:TimerEvent):void
		{
			timerCount += 60;
			globaltimerCount += 60;
			timePlayed(timerCount);
		}
		
		public var currentseconds:int;
		public var currentminutes:int;
		public var currenthours:int;
		public var globalseconds:int;
		public var globalminutes:int;
		public var globalhours:int;
		public var totalTimeplayed:int;
		
		public function timePlayed(milliseconds:int):void{
			var time:Date = new Date(milliseconds);
			var minutes:int = time.minutes;
			var seconds:int = time.seconds;
			var hours:int = time.hours;
			var displayhours:String = hours.toString();
			var displayminutes:String = minutes.toString();
			var displayseconds:String = seconds.toString();
			
			var displayglobalhours:String = globalhours.toString();
			var displayglobalminutes:String = globalminutes.toString();
			var displayglobalseconds:String = globalseconds.toString();
			
			displayglobalseconds = ((globaltimerCount /1000).toFixed(0)).toString();
			displayglobalminutes = (globalminutes).toString();
			displayglobalhours = (globalhours).toString();
			
			displayhours = (displayhours.length != 2) ? '0'+displayhours : displayhours;
			displayminutes = (displayminutes.length != 2) ? '0'+displayminutes : displayminutes;
			displayseconds = (displayseconds.length != 2) ? '0'+displayseconds : displayseconds;
			
			displayglobalhours = (displayglobalhours.length != 2) ? '0'+displayglobalhours : displayglobalhours;
			displayglobalminutes = (displayglobalminutes.length != 2) ? '0'+displayglobalminutes : displayglobalminutes;
			displayglobalseconds = (displayglobalseconds.length != 2) ? '0'+displayglobalseconds : displayglobalseconds;
			
			totalTimeplayed = minutes;
		}
    }//Class
}//package 