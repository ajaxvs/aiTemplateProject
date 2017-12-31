package app.logic
{
	
	import flash.utils.getQualifiedClassName;
	
	import app.CajApp;
	import app.data.levels.CajLevel1;
	import app.data.levels.CajLevelBase;

	/**
	 * port from JS.
	 */
	public class CajLevels {
		//================================================================================
		protected var startLevelClass:Class = null;
		protected var currentLevel:CajLevelBase = null;
		//================================================================================
		public function CajLevels()	{
			
		}
		//================================================================================
		public function init():void {
			startLevelClass = CajLevel1;
		}
		//================================================================================
		public function restartLevel():void {
			CajApp.p1.restartLevel();
			
			if (currentLevel) {
				var cl:Class = Object(currentLevel).constructor;				
				startLevel(cl);
			} else {
				startNewGame();
			}
			
		}
		//================================================================================
		public function startNewGame():void {
			CajApp.progress.clearProgress();
			CajApp.p1.startNewGame();
			
			CajApp.log.add("start new game");
			startLevel(startLevelClass);
		}
		//================================================================================
		public function startLevel(level:Class):void {
			if (currentLevel) {
				//TODO: fadeScreenLauncher
				startLevelDirect(level);
			} else {
				//first level, nn fade:
				startLevelDirect(level);
			}
		}
		//================================================================================
		protected function startLevelDirect(level:Class):void {
			//clear old:
			if (currentLevel) {
				currentLevel.Hide();
				currentLevel.clearResources();
			}
			
			//setting new:
			if (level) {
				try {
					CajApp.log.add("start level: " + getQualifiedClassName(level));
				
					currentLevel = new level(CajApp.layers.game);
					currentLevel.init();
					currentLevel.Show();
				} catch (err:Error) {
					CajApp.log.add("CajLevels.startLevelDirect() Error: wrong class: " + err);
					CajApp.showMainWindow(true);
					return;
				}
				
				//link level to p1?
				
			} else {
				CajApp.log.add("CajLevels.startLevelDirect() Error: null level");
				startNewGame();
			}
		}
		//================================================================================
		public function onBackKey():void {
			if (currentLevel) {
				currentLevel.Hide();
			}
		}
		//================================================================================		
		public function frameActions(ft:Number):void {
			if (currentLevel) {
				if (currentLevel.IsShowing()) {
					currentLevel.frameActions(ft);
				}
			}
		}			
		//================================================================================
		
	}
}