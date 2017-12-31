package app.logic
{
	import app.CajApp;
	
	import ru.ajaxvs.android.CajConfigAir;
	
	/**
	 * for android and desktop.
	 */
	public class CajConfig extends CajConfigAir {
		//================================================================================
		public function CajConfig() {
			super();
		}
		//================================================================================
		override protected function onApply(json:Object):void {
			//sound:
			if (json.soundEnabled !== undefined) {
				var soundEnabled:Boolean = false;
				if (json.soundEnabled == "1" || json.soundEnabled == "true") {
					soundEnabled = true;
				}
				CajApp.sound.SetSoundEnable(soundEnabled);
				CajApp.sound.SetMusicEnable(soundEnabled); //same value for music in config.
			} else {
				showError("Config miss: soundEnabled");
			}
		}
		//================================================================================
	}
}