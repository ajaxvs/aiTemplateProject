package app.view.elements
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * port from JS
	 */
	public class CajLayers {
		//================================================================================
		public var game:Object;
		public var UI:Object;
		public var fadeScreenLauncher:Object;
		
		public var P1:Object;
		public var mapObjects:Object;
		public var NPC:Object;
		public var bullets:Object;
		public var tileMap:Object;
		public var panoramas:Object;
		public var messages:Object;
		public var vjoy:Object;
		//================================================================================
		/**
		 * @param parentSprite - flash.display.Sprite or starling sprite.
		 */
		public function CajLayers(parentSprite:Object) {
			//var cl:Class = parentSprite.constructor as Class;
			
			var className:String = getQualifiedClassName(parentSprite);
			var cl:Class = getDefinitionByName(className) as Class;
			
			init(cl);
			place(parentSprite);
		}
		//================================================================================
		private function init(cl:Class):void {
			game = new cl();
			UI = new cl();
			fadeScreenLauncher = new cl();
			
			P1 = new cl();
			mapObjects = new cl();
			NPC = new cl();
			bullets = new cl();
			tileMap = new cl();
			panoramas = new cl();
			messages = new cl();
			vjoy = new cl();
		}
		//================================================================================
		private function place(parentSprite:Object):void {
			//z-order:
			
			//on stage:
			parentSprite.addChild(game);
			parentSprite.addChild(UI);
			parentSprite.addChild(fadeScreenLauncher);
			
			//on game:
			game.addChild(panoramas);
			game.addChild(tileMap);
			game.addChild(mapObjects);
			game.addChild(NPC);
			game.addChild(P1);
			game.addChild(bullets);
			game.addChild(messages);
			game.addChild(vjoy);
		}
		//================================================================================
	}
}