/*

main App class.

*/

package app
{
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import app.assets.CajAssetsBase;
	import app.data.CajP1;
	import app.logic.CajLevels;
	import app.logic.CajProgress;
	import app.utils.tests.CajTests;
	import app.view.elements.CajLayers;
	import app.view.windows.CajActionWindow;
	import app.view.windows.CajLobbyWindow;
	import app.view.windows.CajMainWindow;
	
	import ru.ajaxvs.android.CajConfigBase;
	import ru.ajaxvs.android.CajFrameStats;
	import ru.ajaxvs.android.CajKeyboardInput;
	import ru.ajaxvs.android.CajLog;
	import ru.ajaxvs.android.CajSound;
	import ru.ajaxvs.android.CajWindowObject;
	import ru.ajaxvs.android.CajWindowObjectManager;
	import ru.ajaxvs.android.core.CajDisplayBaseEngine;
	import ru.ajaxvs.android.core.CajNativeWindowBase;
	import ru.ajaxvs.android.flashdisplay.CajLoadingAppLabel;
	
	public class CajApp {
		//================================================================================
		//app main "consts":
		static public var appName:String; //set in entry as file.
		static public var appWidth:int; //~. bigger part = width by default. check changes in onStageResize()
		static public var appHeight:int; //~~
		static public var appBgColor:uint;
		static public var appAboutVersion:String;
		//================================================================================
		//platform-specific class config:
		static public var displayEngineClass:Class;
		static public var assetsClass:Class;
		static public var configClass:Class;
		static public var logClass:Class;
		static public var soundClass:Class;
		static public var nativeWindowClass:Class;		
		//================================================================================
		//debug:
		static protected const launchTests:Boolean = false; 
								//false = release, true = debug
		
		static protected const borderColorTest:uint = 0; 
								//0xFFrrggbb = debug for flash.display, 0 = release
		//================================================================================
		//display engine:
		static protected const useBorderImages:Boolean = false;
								//false = increase app sizes to stage aspect, no borders (recommended).
								//true = keep app aspect, keep appWidth & appHeight (flash display only).
								
		//android:
		static protected const exitOnMainWindowBackKey:Boolean = false;
								//false = no auto-exit (using separate exit button)
		
		//for air classes: 
		static protected const configDocsPath:String = "aiTemplateProject/config.json";
		static protected const logsFolder:String = "aiTemplateProject/logs/"; //set to null to disable.		
		
		//for starling:
		static private var starlingObj:Object = null; //:Starling
		//================================================================================
		//app-specific objects:
		//assets:
		static public var assets:CajAssetsBase;
		
		//data:
		static public var log:CajLog;
		static public var p1:CajP1;

		//logic:		
		static public var frameStats:CajFrameStats;
		static public var config:CajConfigBase;
		static public var sound:CajSound;
		static public var levels:CajLevels;
		static public var progress:CajProgress;
		
		//view:
		static public var nativeWindow:CajNativeWindowBase;
		static public var stage:Stage;
		static protected var spMain:Object;			
		
		//windows:
		static public var layers:CajLayers;
		static protected var windowsManager:CajWindowObjectManager;		
		static protected var mainWindow:CajMainWindow;
		static protected var lobbyWindow:CajLobbyWindow;
		static protected var actionWindow:CajActionWindow;
		//================================================================================
		//misc vars:
		static public var displayEngine:CajDisplayBaseEngine;
		//================================================================================
		static protected var originalAppWidth:int;
		static protected var originalAppHeight:int;
		static protected var isActive:Boolean = true;
		//================================================================================
		public function CajApp() {}
		//================================================================================
		static public function appStart(stage:Stage, loaderInfo:LoaderInfo):void {
			CajApp.stage = stage;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.color = appBgColor;
			
			registerLoaderErrors(loaderInfo);

			//fit to stage if need:
			correctRotatedAppSize();
			originalAppWidth = appWidth;
			originalAppHeight = appHeight;			
			fitAppSizeToStage();
			
			//main display containers:
			displayEngine = new CajApp.displayEngineClass();
			var displayClass:Class = displayEngine.getSpriteClass();
			spMain = new displayClass();
			displayEngine.init(stage, spMain, appWidth, appHeight, init);
		}
		//================================================================================
		static protected function registerLoaderErrors(loaderInfo:LoaderInfo):void {
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtErrorEvent);
		}
		//================================================================================
		static protected function onUncaughtErrorEvent(err:UncaughtErrorEvent):void {
			err.preventDefault(); //don't show error msg if there's no internet connection
			trace("onUncaughtErrorEvent", err.text);
		}
		//================================================================================
		/**
		 * @param starlingObj - starling.core.Starling (Starling) or null (flash.display)
		 */
		static protected function init(starlingObj:Object):void {
			CajApp.starlingObj = starlingObj;
			
			layers = new CajLayers(spMain);
			
			//assets:
			assets = new CajApp.assetsClass();
			
			//data:
			log = new CajApp.logClass(logsFolder, true, true);
			p1 = new CajP1(layers.P1);
			
			//logic:
			frameStats = new CajFrameStats(false);			
			config = new CajApp.configClass();
			sound = new CajApp.soundClass();
			levels = new CajLevels();
			progress = new CajProgress();
			
			//view:
			nativeWindow = new CajApp.nativeWindowClass();
			nativeWindow.centerOnScreen();
			
			//borders if need:
			var bcolor:uint = appBgColor;
			if (borderColorTest != 0) {
				bcolor = borderColorTest;
			}
			displayEngine.initBorders(stage, useBorderImages, bcolor);
			
			//windows:			
			mainWindow = new CajMainWindow(layers.UI);
			lobbyWindow = new CajLobbyWindow(layers.UI);
			actionWindow = new CajActionWindow(layers.UI);
			
			//wmanager:
			windowsManager = new CajWindowObjectManager(exitOnMainWindowBackKey ? mainWindow : null, null);
			
			//config:
			config.loadConfig(onConfigLoaded, configDocsPath, log.add);
		}
		//================================================================================
		static protected function onConfigLoaded():void {
			assets.init(onFullLoading);
		}
		//================================================================================
		//config & assets loaded. time to init objects and show windows:
		static protected function onFullLoading():void {
			//stage setup:
			onStageResize(null);
			
			//data init:
			//?
			
			//logic init:
			frameStats.maxFrameTime = 100;
			levels.init();
			
			//windows init:			
			mainWindow.init();
			lobbyWindow.init();
			actionWindow.init();

			//global events:
			stage.addEventListener(Event.ACTIVATE, onActivate);
			stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(Event.ENTER_FRAME, frameActions);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			//start ux:	
			CajLoadingAppLabel.hide();
			showMainWindow(false);
			
			//tests:
			if (launchTests) {
				if (CajTests.tests()) {
					log.add("tests ok");
				} else {
					log.add("tests failed");
					return;
				}
			}
		}
		//================================================================================
		static protected function onActivate(e:Event):void {
			isActive = true;
			displayEngine.onActivate(e);
		}
		//================================================================================
		static protected function onDeactivate(e:Event):void {
			isActive = false;
			displayEngine.onDeactivate(e);
		}
		//================================================================================
		static protected function correctRotatedAppSize():void {
			//swap width & height on screen rotation:
			var newAW:int;
			var newAH:int;
			if (stage.stageWidth > stage.stageHeight) {
				newAW = Math.max(appWidth, appHeight);
				newAH = Math.min(appWidth, appHeight);
			} else {
				newAW = Math.min(appWidth, appHeight);
				newAH = Math.max(appWidth, appHeight);
			}
			appWidth = newAW;
			appHeight = newAH;		
		}
		//================================================================================
		static protected function fitAppSizeToStage():void {
			if (!useBorderImages) {
				//not fullScreenWidth and fullScreenHeight. works fine for all app types:
				var isLandscape:Boolean = stage.stageWidth > stage.stageHeight;
				var oMax:int = Math.max(originalAppWidth, originalAppHeight);
				var oMin:int = Math.min(originalAppWidth, originalAppHeight);
				var oWidth:int = isLandscape ? oMax : oMin;
				var oHeight:int = isLandscape ? oMin : oMax;
				var fsWidth:int = stage.stageWidth;
				var fsHeight:int = stage.stageHeight;
				var appSize:Point = CajDisplayBaseEngine.fitAppToFullscreenAspect(oWidth, oHeight, fsWidth, fsHeight);
				appWidth = appSize.x;
				appHeight = appSize.y;
			}
		}
		//================================================================================
		/** function is calling when application size is changing including first launch */
		static protected function onStageResize(e:flash.events.Event = null):void {			
			correctRotatedAppSize();
			fitAppSizeToStage();
			
			displayEngine.onStageResize(e, stage, spMain, appWidth, appHeight);
			
			var aShowingWindows:Vector.<CajWindowObject> = CajWindowObject.GetShowingWindows();
			for each (var w:CajWindowObject in aShowingWindows) {
				w.OnStageResize();
			}
			
			trace("onStageResize() end. app, stage, stageFs:", appWidth + "x" + appHeight,
				stage.stageWidth + "x" + stage.stageHeight,
				stage.fullScreenWidth + "x" + stage.fullScreenHeight);				
		}
		//================================================================================
		static private function onKeyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.BACK:
					if (levels) levels.onBackKey();
					windowsManager.OnKeyDown(e);
					break;
			}
			
			//if app uses keyboard: add CajKeyboardInput functions.			
		}			
		//================================================================================
		static protected function frameActions(e:Event):void {
			if (!isActive) return;
			
			var ft:Number = frameStats.FrameActions();
			
			//check starling / flash.display flow:
			displayEngine.frameActions(ft);
			
			//check framework fa:
			if (log) log.flush();
			if (config) config.flush();
			if (levels) levels.frameActions(ft);
			
			//window:
			var w:Object = windowsManager.GetCurrentWindow();
			if (w.frameActions is Function) {
				w.frameActions(ft);
			}
		}
		//================================================================================
		static public function showMainWindow(freshStart:Boolean):void {
			if (freshStart) {
				windowsManager.FreshStart(mainWindow);
			} else {
				windowsManager.SetCurrentWindow(mainWindow);	
			}
		}
		//================================================================================
		static public function showLobbyWindow():void {
			windowsManager.SetCurrentWindow(lobbyWindow);
		}
		//================================================================================
		static public function showActionWindow():void {
			windowsManager.SetCurrentWindow(lobbyWindow);
		}
		//================================================================================
		static public function startNewGame():void {
			//separate windows. actionWindow (game UI) can be temporary hidden for some movie-like level parts.
			windowsManager.SetCurrentWindow(actionWindow);
			levels.startNewGame();						
		}
		//================================================================================
	}
}
