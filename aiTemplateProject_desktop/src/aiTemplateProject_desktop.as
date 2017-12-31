package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import app.CajApp;
	import app.assets.CajAssetsAir;
	import app.logic.CajConfig;
	import app.view.CajNativeWindow;
	
	import ru.ajaxvs.android.CajLogAir;
	import ru.ajaxvs.android.CajSoundAir;
	import ru.ajaxvs.android.flashdisplay.CajLoadingAppLabel;
	import ru.ajaxvs.android.core.CajDisplayFlashEngine;
	import ru.ajaxvs.android.core.CajDisplayStarlingEngine;
	
	//========================================
	
	//set CajApp.appWidth, CajApp.appHeight below as well
	[SWF(width="1280", height="800", backgroundColor="0x000000", frameRate=60)]
	
	//========================================
	
	public class aiTemplateProject_desktop extends Sprite {
		//========================================
		public function aiTemplateProject_desktop() {
			super();
			
			if (stage) {
				onStage();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, onStage);
			}				
		}
		//========================================
		private function onStage(e:Event = null):void {
			if (e && hasEventListener(Event.ADDED_TO_STAGE)) {
				removeEventListener(Event.ADDED_TO_STAGE, onStage);
			}
			
			stage.color = 0x000000;
			CajLoadingAppLabel.show(stage, appStart, 0xBEBEBE);
		}		
		//========================================
		private function appStart():void {
			//desktop:
			
			CajApp.appName = "aiTemplateProject_desktop";
			CajApp.appWidth = 1280;
			CajApp.appHeight = 800;
			CajApp.appBgColor = 0xFF000000;
			CajApp.appAboutVersion = "0.0.1";
			
			CajApp.displayEngineClass = CajDisplayStarlingEngine; //CajDisplayFlashEngine or CajDisplayStarlingEngine
			CajApp.assetsClass = CajAssetsAir;
			CajApp.configClass = CajConfig;
			CajApp.logClass = CajLogAir;
			CajApp.soundClass = CajSoundAir;
			CajApp.nativeWindowClass = CajNativeWindow;
			
			//start cross-platform code:
			CajApp.appStart(stage, loaderInfo);
		}
		//========================================
	}
}