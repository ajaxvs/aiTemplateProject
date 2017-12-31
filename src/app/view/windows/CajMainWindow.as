package app.view.windows
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import app.CajApp;
	
	import ru.ajaxvs.android.CajWindowObject;
	
	public class CajMainWindow extends CajWindowObject
	{
		//================================================================================
		static private const soundEnabledConfigKey:String = "soundEnabled";
		//================================================================================
		private var bgImg:Object;
		private var bgImg2:Object;
		
		private var butStart:Object;
		private var butOptions:Object;
		private var butSound:Object;
		//================================================================================
		public function CajMainWindow(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		public function init():void {
			//bg:
			bgImg = CajApp.displayEngine.createImageFromColor(0xFF212121);						
			spMain.addChild(bgImg);
			bgImg2 = CajApp.displayEngine.createImageFromColor(0xFF424242);
			spMain.addChild(bgImg2);
			
			//menu:						
			var butBmd:BitmapData = (new CajApp.assets.EUIButton0() as Bitmap).bitmapData;
			butStart = CajApp.displayEngine.createButton(spMain, butBmd,
				CajApp.assets.getString("butStart"), "Verdana", 32, CajApp.assets.whiteTextColor, onStart);
			
			butOptions = CajApp.displayEngine.createButton(spMain, butBmd,
				CajApp.assets.getString("butOptions"), "Verdana", 32, CajApp.assets.whiteTextColor, onOptions);
			
			//sound button:
			butSound = CajApp.displayEngine.createSoundButton(spMain, 
				CajApp.assets.EUISoundOn, CajApp.assets.EUISoundOff, onSoundButton);
			
			var s:String;
			s = CajApp.config.getParam(soundEnabledConfigKey);
			if (s == "0") { //default sound = on.
				butSound.setOff();
				CajApp.sound.SetSoundEnable(false);
				CajApp.sound.SetMusicEnable(false);
			}
			
			correctCoords();
		}		
		//================================================================================
		public function correctCoords():void {
			var x:Number;
			var y:Number;
			
			if (bgImg) {
				bgImg.width = CajApp.appWidth;
				bgImg.height = CajApp.appHeight;
				bgImg.x = 0;
				bgImg.y = 0;
			}
			if (bgImg2) {
				bgImg2.width = CajApp.appWidth * 0.8;
				bgImg2.height = CajApp.appHeight * 0.8;
				bgImg2.x = CajApp.appWidth * 0.1;
				bgImg2.y = CajApp.appHeight * 0.1;
			}
			if (butStart) {
				CajApp.displayEngine.centerDisplayObject(butStart, CajApp.appWidth, CajApp.appHeight);
			}
			if (butOptions) {				
				butOptions.x = butStart.x;
				butOptions.y = butStart.y + butStart.height * 1.5;
			}
			if (butSound) {
				var offset:int = 10;
				y = CajApp.appHeight - offset - CajApp.displayEngine.getDisplayObjectSize(butSound).y;
				CajApp.displayEngine.setDisplayObjectPosition(butSound, offset, y);
			}
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
		private function onSoundButton():void {
			var b:Boolean = !CajApp.sound.IsSoundEnable();
			CajApp.sound.SetSoundEnable(b);
			CajApp.sound.SetMusicEnable(b);
			
			CajApp.config.save(soundEnabledConfigKey, b ? "1" : "0");
		}
		//================================================================================		
		private function onStart(... args):void {
			CajApp.showLobbyWindow();
		}
		//================================================================================
		private function onOptions():void {
			trace("options");
		}
		//================================================================================
		private function onAbout():void {
			trace("about");
		}
		//================================================================================
		public function frameActions(ft:Number):void {
			//.
		}
		//================================================================================
	}
	
}

