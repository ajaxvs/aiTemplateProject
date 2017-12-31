package app.view.windows
{
	import app.CajApp;
	
	import ru.ajaxvs.android.CajWindowObject;
	
	/**
	 * game window on each level.
	 */
	public class CajActionWindow extends CajWindowObject {
		//================================================================================
		
		//================================================================================
		public function CajActionWindow(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		public function init():void {
			//add game UI for all levels. ads as well.
			
			correctCoords();
		}
		//================================================================================
		public function correctCoords():void {
			
		}
		//================================================================================
		override public function OnStageResize():void {
			correctCoords();
		}
		//================================================================================
		override protected function OnShow():void {
			trace("action window");
		}
		//================================================================================
		override protected function OnHide():void {
			
		}
		//================================================================================
		override public function OnBackKeyAttempt():Boolean {
			//back to main menu:
			//CajApp.showMainWindow(true);
			//return false;
			
			//return to lobby:
			return true;  
		}
		//================================================================================
		public function frameActions(ft:Number):void {
			
		}
		//================================================================================
	}

}