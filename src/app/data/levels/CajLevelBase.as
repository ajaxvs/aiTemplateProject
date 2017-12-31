package app.data.levels
{
	import ru.ajaxvs.android.CajWindowObject;
	
	public class CajLevelBase extends CajWindowObject {
		//================================================================================
		
		//================================================================================
		public function CajLevelBase(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		public function init():void {
			
			correctCoords();
		}
		//================================================================================
		public function clearResources():void {
			
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
			
		}
		//================================================================================
		override protected function OnHide():void {
			
		}
		//================================================================================
		public function triggerFinish():void {
			
		}
		//================================================================================
		public function frameActions(ft:Number):void {
			
		}
		//================================================================================
	}

}