/*

Starling demo level: using atlas and lights.

*/

package app.data.levels
{
	import flash.utils.getTimer;
	
	import app.CajApp;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.extensions.lighting.LightSource;
	import starling.extensions.lighting.LightStyle;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class CajLevel1 extends CajLevelBase {
		//================================================================================
		private var hero:MovieClip;
		private var aHeroNormals:Vector.<Texture>;
		private var heroLightStyle:LightStyle;		
		private var hero2:MovieClip;
		//================================================================================
		public function CajLevel1(parentSprite:Object) {
			super(parentSprite);
		}
		//================================================================================
		override public function init():void {
			super.init();
			
			trace("level1 init");
			
			//resources:
			var xmlHeroAtlas:XML = XML(new CajApp.assets.EP1attack_xml());
			var txHeroAtlas:Texture = Texture.fromEmbeddedAsset(CajApp.assets.EP1attack);			
			var atHero:TextureAtlas = new TextureAtlas(txHeroAtlas, xmlHeroAtlas);
			
			var txHeroNormalsAtlas:Texture = Texture.fromEmbeddedAsset(CajApp.assets.EP1attack_n);
			var atHeroNormals:TextureAtlas = new TextureAtlas(txHeroNormalsAtlas, xmlHeroAtlas);
			aHeroNormals = atHeroNormals.getTextures();
			
			//char1:
			const heroScale:Number = 0.25;			
			hero = new MovieClip(atHero.getTextures(), 12);
			hero.scaleX = heroScale;
			hero.scaleY = heroScale;
			CajApp.displayEngine.centerDisplayObject(hero, CajApp.appWidth, CajApp.appHeight);
			spMain.addChild(hero);					
			for (var i:int = 0; i < hero.numFrames; i++) {
				hero.setFrameAction(i, updateHero);					
			}
			
			//char2:
			hero2 = new MovieClip(atHero.getTextures(), 12);
			hero2.scaleX = heroScale;
			hero2.scaleY = heroScale;
			hero2.x = 100;
			hero2.y = hero.y;
			spMain.addChild(hero2);		
			Starling.juggler.add(hero2);

			//starling lights:
			initLight();
			
			//done:
			correctCoords();
		}
		//================================================================================
		private function updateHero(mc:MovieClip, frame:int):void {
			heroLightStyle.normalTexture = aHeroNormals[frame];
		}
		//================================================================================
		private function initLight():void {
			heroLightStyle = new LightStyle(aHeroNormals[0]);
			heroLightStyle.ambientRatio = 0.3;
			heroLightStyle.diffuseRatio = 0.7;
			heroLightStyle.specularRatio = 0.5;
			heroLightStyle.shininess = 8.0;
			hero.style = heroLightStyle;
			
			var pointLightA:LightSource = LightSource.createPointLight(0xFFFF0000, 0.5);
			pointLightA.x = CajApp.appWidth * 0.66;
			pointLightA.y = CajApp.appHeight * 0.5;
			pointLightA.z = -200;
			pointLightA.showLightBulb = true;
			spMain.addChild(pointLightA);
			
			var ambientLight:LightSource = LightSource.createAmbientLight(0xFFA0A000, 1);
			ambientLight.showLightBulb = true;
			spMain.addChild(ambientLight);
			
			var directionalLight:LightSource = LightSource.createDirectionalLight(0xFFFFFFFF, 1);
			directionalLight.rotationZ = Math.PI / 3.0;
			directionalLight.rotationY = -1;
			directionalLight.showLightBulb = true;
			spMain.addChild(directionalLight);	
		}
		//================================================================================
		override public function clearResources():void {
			super.clearResources();
			
			//don't dispose resources if there's only one level.
			
			trace("level1 clear");
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

			hero.play();
			
			trace("level1 show");
		}
		//================================================================================
		override protected function OnHide():void {
			super.OnHide();
			
		}
		//================================================================================
		override public function triggerFinish():void {
			/*
			//go to the new level, i.e.:
			CajApp.p1.hide();
			this.hide();
			CajApp.introScene.show("intro_1", function() { CajGame.levels.startLevel(CajLevel1); });
			*/
		}
		//================================================================================
		override public function frameActions(ft:Number):void {
			super.frameActions(ft);
		
			hero.advanceTime(ft * 0.001); //manual update.		
		}
		//================================================================================
	}
	
}
