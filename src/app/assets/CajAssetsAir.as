package app.assets
{
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import app.CajApp;
	
	import ru.ajaxvs.android.loaders.CajBitmapLoader;

	/**
	 * for android and desktop
	 */
	public class CajAssetsAir extends CajAssetsBase {
		//================================================================================
		//================================================================================
		public function CajAssetsAir() {
			super();
		}
		//================================================================================
		override protected function initImages():void {
			//use atlases for level objects
			
			//preload always-using files.
			try {
				var appDir:File = File.applicationDirectory;				
				var dir:String;
				var aImgPath:Array = new Array();
				
				dir = appDir.resolvePath("assets/UI").url + "/"; //use url, not nativePath for appDir
				
				aImgPath.push(dir + "soundOn.png");
				aImgPath.push(dir + "soundOff.png");	
				
				var bl:CajBitmapLoader = new CajBitmapLoader();
				bl.load(aImgPath, onImagesLoaded);
				
			} catch (err:Error) {
				CajApp.log.add("CajAssets.initImages() Error: " + err);
				onImagesLoaded(null);
			}
		}
		//================================================================================
		private function onImagesLoaded(aImgBmds:Dictionary):void {
			if (aImgBmds) {
				aImages = aImgBmds;
			}
			
			//for (var imgId:String in aImages) { trace(imgId, (aImages[imgId] as BitmapData).rect); } //test			
			
			if (this.onAssetsLoaded != null) {
				this.onAssetsLoaded();
			}
		}
		//================================================================================
	}
}