package com.goshare.view.login
{
	import com.goshare.data.DataOfPublic;
	import com.goshare.view.MainView;
	import com.goshare.view.home.HomeView;
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.ui.GameInput;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class LoginView extends UIComponent
	{
		public function LoginView()
		{
			super();
		}
		
		private static var instance:LoginView;
		
		public static function getInstance():LoginView
		{
			if (!instance)
				instance = new LoginView();
			
			return instance;
		}
		
		private var loginPanel : LoginPanel;
		private var shadow : DropShadowFilter;
		private var btn : Button;
		private var version : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			btn = new Button();
			btn.label = "登陆测试";
			btn.addEventListener(MouseEvent.CLICK,btn_clikHandler);
			addChild(btn);
			btn.visible = false;
			
			loginPanel = new LoginPanel();
			addChild(loginPanel);
			
			version =  new Label();
			version.color = 0xd0d0d0;
			version.text = "Version："+DataOfPublic.getInstance().version;
			addChild(version);
			
			shadow= new DropShadowFilter();
			with (shadow) {
				distance =40;
				angle = 165;
				alpha = 0.1;
				blurX = 10;
				blurY = 30;
				color = 0x5c9dfd;
				hideObject = false;
				inner = false;
				knockout = false;
				quality = 1;
				strength = 1;
			}
			
			loginPanel.filters = loginPanel.filters = [shadow];
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			btn.x = width-100;
			btn.y = 30;
			
			loginPanel.x = (width-loginPanel.width)/2;
			loginPanel.y = (height-loginPanel.height)/2;
			
			version.x = width-100;
			version.y = height-40;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0x8eb0f9, 0x5294f7];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(width/4, height/2, 45, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			graphics.drawRect(0,0,width/2,height);
			graphics.beginFill(0xffffff);
			graphics.drawRect(width/2,0,width/2,height);
			graphics.endFill();
		}
		
		protected function btn_clikHandler(event:MouseEvent):void
		{
			MainView.getInstance().pushView(HomeView);
		}
	}
}