package{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.events.*;
	public class Field extends MovieClip{
		private var _root:MovieClip;
		var Grass:grass = new grass();
				
		public function Field(){
			//adding the required listeners
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		private function beginClass(e:Event):void{
			_root = MovieClip(root);
			Main.currentcash -= Main.fieldcost;
			
			this.addChild(Grass);

		}
		private function eFrameEvents(e:Event):void{
			
		}
	}
}