package app.view.windows
{
	import app.CajApp;
	
	import ru.ajaxvs.android.CajWindowObject;
	
	public class CajLobbyWindow extends CajWindowObject {
		//================================================================================
		private var butNewGame:Object;
		//================================================================================
		public function CajLobbyWindow(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		public function init():void {
			//add lobby UI: select game mode, level, shop or something else.
			
			butNewGame = CajApp.displayEngine.createButton(spMain, CajApp.assets.EUIButton0, 
				CajApp.assets.getString("butNewGame"), "Verdana", 32, CajApp.assets.whiteTextColor, onNewGame);
			
			correctCoords();
		}
		//================================================================================
		public function correctCoords():void {
			CajApp.displayEngine.centerDisplayObject(butNewGame, CajApp.appWidth, CajApp.appHeight);
		}
		//================================================================================
		override public function OnStageResize():void {
			correctCoords();
		}
		//================================================================================
		override protected function OnShow():void {
			trace("lobby window");
			
			correctCoords();
		}
		//================================================================================
		override protected function OnHide():void {
			
		}
		//================================================================================
		private function onNewGame():void {
			CajApp.startNewGame();
		}
		//================================================================================
		public function frameActions(ft:Number):void {
			
		}
		//================================================================================
	}

}