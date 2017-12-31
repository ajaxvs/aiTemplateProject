package app.view.windows
{
	import flash.display.Sprite;
	
	import ru.ajaxvs.android.CajWindowObject;
	
	/**
	 * template
	 */
	public class TWindow extends CajWindowObject {
		//================================================================================
		
		//================================================================================
		public function TWindow(parentSprite:Sprite) {
			super(parentSprite);
		}
		//================================================================================
		public function init():void {
			
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
			
			correctCoords();
		}
		//================================================================================
		override protected function OnHide():void {
			
		}
		//================================================================================
		public function frameActions(ft:Number):void {
			
		}
		//================================================================================
	}

}