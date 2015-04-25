package{
	//imports
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	   
		
	public class HouseBlock extends MovieClip{//we'll call it a DirectBlock
		private var _root:MovieClip;//again, defining a _root
		private var houseType:String;//what kind of special block is this

		//this time, we have to accept some values to make it easier to place, like the type and coordinates
		public function HouseBlock(type:String,xVal:int,yVal:int){
			houseType = type;//set the directType so that all other functions can use it
			//add the required event listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrame);

			
			//setting the coordinates
			this.x = xVal;
			this.y = yVal;
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);//setting the _root again
			
			if (houseType == "HOUSE"){
			//making this into a 25x25 square
			_root.addHouse(this.x,this.y);
			}
			if (houseType == "HOUSEBORDER"){

			}
			
		}
		private function eFrame(e:Event):void{

			//we'll add more code to this later
		}

	}
}
