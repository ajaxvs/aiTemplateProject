package app.view
{
	import app.CajApp;
	import ru.ajaxvs.android.core.CajNativeWindowBase;
	
	/**
	 * for android and desktop
	 */
	public class CajNativeWindow extends CajNativeWindowBase {
		//================================================================================
		public function CajNativeWindow() {			
			
		}
		//================================================================================
		override public function centerOnScreen():void {
			try {
				CajApp.stage.nativeWindow.x = (CajApp.stage.fullScreenWidth - CajApp.appWidth) / 2;
				CajApp.stage.nativeWindow.y = (CajApp.stage.fullScreenHeight - CajApp.appHeight) / 2;
			} catch (err:Error) {
				trace("CajNativeWindow.centerOnScreen() Err:", err);
			}
		}
		//================================================================================
	}
}