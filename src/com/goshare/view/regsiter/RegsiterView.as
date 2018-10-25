package com.goshare.view.regsiter
{
	import com.goshare.view.MainView;
	import com.goshare.view.login.LoginView;
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class RegsiterView extends UIComponent
	{
		public function RegsiterView()
		{
			super();
		}
		
		private static var instance:RegsiterView;
		
		public static function getInstance():RegsiterView
		{
			if(!instance) instance = new RegsiterView();
			
			return instance;
		}
		
		private var lab : Label;
		private var goBack : Button;
		private var logo : Image;
		private var regsiterPanel : RegsiterPanelOfID;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = "注册界面";
			addChild(lab);
			lab.visible = false;
			
			logo = new Image();
			logo.source = "assets/login/logo.png";
			logo.buttonMode = true;
			logo.addEventListener(MouseEvent.CLICK,goBack_Handler);
			addChild(logo);
			
			
			addChild(RegsiterNavigator.getInstance());
			RegsiterNavigator.getInstance().pushView(RegsiterPanelOfID);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			logo.x = 30;
			logo.width = logo.height =height*(70/768)*5/7 ;
			logo.y = (height*(70/768)-logo.height)/2;
			
			RegsiterNavigator.getInstance().x =0;
			RegsiterNavigator.getInstance().y = 70;
			RegsiterNavigator.getInstance().width = width;
			RegsiterNavigator.getInstance().height = height-70;
		}
		
	
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0x8eb0f9, 0x5294f7];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(width/4, 50, 45, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			graphics.clear();
			graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			graphics.drawRect(0,0,width,height*(70/768));
			graphics.endFill();
			
//			graphics.beginFill(0xffffff);
//			graphics.drawRect(0,70,width,height-height*(70/768));
//			graphics.endFill();
		}
		
		protected function goBack_Handler(event:MouseEvent):void
		{
			MainView.getInstance().pushView(LoginView);
			RegsiterNavigator.getInstance().pushView(RegsiterPanelOfID);
		}
	}
}