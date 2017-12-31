package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import app.CajApp;
	import app.assets.CajAssetsWeb;
	
	import ru.ajaxvs.android.CajConfigBase;
	import ru.ajaxvs.android.CajLog;
	import ru.ajaxvs.android.CajSound;
	import ru.ajaxvs.android.core.CajDisplayFlashEngine;
	import ru.ajaxvs.android.core.CajDisplayStarlingEngine;
	import ru.ajaxvs.android.core.CajNativeWindowBase;
	import ru.ajaxvs.android.flashdisplay.CajLoadingAppLabel;
	
	//========================================
	
	//set CajApp.appWidth, CajApp.appHeight below as well
	[SWF(width="1280", height="800", backgroundColor="0x000000", frameRate=60)]
	
	//========================================
	
	public class aiTemplateProject_web extends Sprite {
		//========================================
		public function aiTemplateProject_web() {
			super();
			
			trace("aiTemplateProject_web with Files in code");
			
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
			//web: (don't forget this for stage3D: <param name="wmode" value="direct"> )
			
			CajApp.appName = "aiTemplateProject_web";
			CajApp.appWidth = 1280;
			CajApp.appHeight = 800;
			CajApp.appBgColor = 0xFF000000;
			CajApp.appAboutVersion = "0.0.1";
			
			CajApp.displayEngineClass = CajDisplayStarlingEngine; //CajDisplayFlashEngine or CajDisplayStarlingEngine
			CajApp.assetsClass = CajAssetsWeb;
			CajApp.configClass = CajConfigBase;
			CajApp.logClass = CajLog;
			CajApp.soundClass = CajSound;
			CajApp.nativeWindowClass = CajNativeWindowBase;
			
			//start cross-platform code:
			CajApp.appStart(stage, loaderInfo);
		}
		//========================================
	}
}