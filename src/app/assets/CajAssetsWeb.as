package app.assets
{
	/**
	 * web only assets 
	 */
	public class CajAssetsWeb extends CajAssetsBase	{
		//================================================================================
		//web-only embed files:
		//[Embed(source="../../assets/UI/buttonT.png")] public const EUIButtonT:Class;
		//etc.
		//================================================================================
		public function CajAssetsWeb() {
			super();
		}
		//================================================================================
		override protected function initImages():void {
			//not necessary. for access by getImage():
			/*
			aImages["button0"] = (new EUIButton0() as Bitmap).bitmapData;
			//etc
			*/
			
			if (this.onAssetsLoaded != null) {
				this.onAssetsLoaded();
			}
		}
		//================================================================================
		//================================================================================
	}
}