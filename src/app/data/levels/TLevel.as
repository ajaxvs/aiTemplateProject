package app.data.levels
{
	public class TLevel extends CajLevelBase {
		//================================================================================
		
		//================================================================================
		public function TLevel(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		override public function init():void {
			super.init();
			
			correctCoords();
		}
		//================================================================================
		override public function clearResources():void {
			super.clearResources();
			
		}
		//================================================================================
		override public function correctCoords():void {
			super.correctCoords();
			
		}
		//================================================================================
		override public function OnStageResize():void {
			super.OnStageResize();
			
			correctCoords();
		}
		//================================================================================
		override protected function OnShow():void {
			super.OnShow();
			
			trace("TLevel show");
		}
		//================================================================================
		override protected function OnHide():void {
			super.OnHide();
			
		}
		//================================================================================
		override public function triggerFinish():void {
			super.triggerFinish();
			
			/*
			CajApp.p1.hide();
			this.hide();
			CajApp.introScene.show("intro_1", function() { CajGame.levels.startLevel(CajLevel1); });
			*/
		}
		//================================================================================
		override public function frameActions(ft:Number):void {
			super.frameActions(ft);
			
		}
		//================================================================================
	}
	
}

