package app.assets {
	import flash.display.BitmapData;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	import app.CajApp;
	
	/**
	 * all platforms assets
	 */
	public class CajAssetsBase {
		//================================================================================
		static private const appLangParam:String = "appLanguage";
		//================================================================================
		public const whiteTextColor:uint = 0xB1B1B1;
		//================================================================================		
		protected var aStrings:Dictionary;
		protected var aStringsEn:Dictionary = new Dictionary();
		protected var aStringsRu:Dictionary = new Dictionary();
		protected var aImages:Dictionary = new Dictionary();
		protected var defaultBmd:BitmapData;
		//================================================================================
		protected var onAssetsLoaded:Function = null;
		//================================================================================
		public function CajAssetsBase() {
			defaultBmd = new BitmapData(2, 2, false, 0xFF000000);
		}
		//================================================================================
		//set font support:
		//Project Properies -> Compiler -> -managers=flash.fonts.AFEFontManager
		//[Embed(source="../assets/fonts/customfont1.ttf", fontName="CustomFont1", embedAsCFF = "false", mimeType='application/x-font')]
		//public var CustomFont1:Class;
		//================================================================================
		//embed files for all platforms:
		//[Embed(source="../assets/db/dbc.dat",mimeType="application/octet-stream")] static public const EObjDbc:Class;
		[Embed(source="../../assets/UI/button0.png")] public const EUIButton0:Class;
		[Embed(source="../../assets/UI/button1.png")] public const EUIButton1:Class;
		[Embed(source="../../assets/UI/soundOn.png")] public const EUISoundOn:Class;
		[Embed(source="../../assets/UI/soundOff.png")] public const EUISoundOff:Class;
		//================================================================================
		[Embed(source="../../assets/p1/p1_attack.png")] public const EP1attack:Class;
		[Embed(source="../../assets/p1/p1_attack_n.png")] public const EP1attack_n:Class;
		[Embed(source="../../assets/p1/p1_attack.xml", mimeType="application/octet-stream")]
																public const EP1attack_xml:Class;
		//================================================================================
		public function init(onLoad:Function):void {
			this.onAssetsLoaded = onLoad;
			
			initEnStrings();
			initRuStrings();
			initLang();			
			initImages();
		}
		//================================================================================
		private function initEnStrings():void {
			aStringsEn["butStart"] = "Start";
			aStringsEn["butOptions"] = "Options";
			aStringsEn["butAbout"] = "About";
			aStringsEn["butExit"] = "Exit";
			
			aStringsEn["butNewGame"] = "New Game";
			
			aStringsEn["AboutText"] = "Development: aiaxsoft, 2017.\nVersion: " + CajApp.appAboutVersion;			
		}
		//================================================================================
		private function initRuStrings():void {
			aStringsRu["butStart"] = "Старт";
			aStringsRu["butOptions"] = "Настройки";
			aStringsRu["butAbout"] = "О программе";
			aStringsRu["butExit"] = "Выход";
			
			aStringsRu["butNewGame"] = "Новая игра";
			
			aStringsRu["AboutText"] = "Разработка: aiaxsoft, 2017.\nВерсия: " + CajApp.appAboutVersion;
		}		
		//================================================================================
		private function initLang():void {			
			var lang:String = CajApp.config.getParam(appLangParam);
			if (lang) {
				//trace("assets set language: loaded from config:", lang);
				setLanguage(lang);
			} else {
				//trace("assets set language: Capabilities.language:", Capabilities.language);
				setLanguage(Capabilities.language);
			}
		}
		//================================================================================
		public function setLanguage(lang:String = ""):void {
			if (lang == null) {
				lang = "";
			}
			
			lang = lang.toLocaleLowerCase();
			if (lang.length >= 2) {
				lang = lang.substr(0, 2);
			} else {
				lang = "";
			}
			
			if (lang == "ru") {
				aStrings = aStringsRu;
			} else {
				aStrings = aStringsEn;
			}
			
			trace("language set:", lang);
		}
		//================================================================================
		public function getString(id:String):String {
			if (aStrings[id]) {
				return aStrings[id];
			} else {
				CajApp.log.add("CajAssetBase.getString() null: " + id);
				return "";
			}
		}
		//================================================================================
		protected function initImages():void {
			//override it
		}
		//================================================================================
		public function getImage(id:String):BitmapData {
			if (aImages[id]) {
				return aImages[id];	
			} else {
				CajApp.log.add("CajAssetBase.getImage() null: " + id);
				return defaultBmd;
			}			
		}
		//================================================================================
	}
}
