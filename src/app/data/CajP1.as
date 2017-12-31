package app.data
{
	import flash.display.Sprite;
	
	import ru.ajaxvs.android.CajWindowObject;

	public class CajP1 extends CajWindowObject {
		//================================================================================
		//================================================================================
		public function CajP1(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		private function setStartValues():void {
			//life = max life or so:
		}
		//================================================================================
		public function startNewGame():void {
			setStartValues();
		}
		//================================================================================
		public function restartLevel():void {
			setStartValues();
		}
		//================================================================================
	}
}