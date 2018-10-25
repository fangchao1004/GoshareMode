package com.goshare.components
{
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class BgColorLab extends UIComponent
	{
		public function BgColorLab()
		{
			super();
		}
		
		public var labText : String=""; 
		public var labX : Number;
		public var labY : Number;
		public var bgHeight : Number=30;
		public var bgWidth : Number=100;
		public var bgColor : uint=0xffffff;
		public var bgAlp : int=1;
		public var labColor : uint=0x000000;
		
		public var lab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.color = labColor;
			lab.x = labX;
			lab.y = labY;
			lab.text = labText;
			lab..fontFamily = FontFamily.STXIHEI;
			lab.fontSize = 16;
			addChild(lab);
		}
	
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(bgColor,bgAlp);
//			graphics.drawRoundRect(0,0,bgWidth,bgHeight,6,6);
			graphics.drawRoundRectComplex(0,0,bgWidth,bgHeight,10,0,10,0);
			graphics.endFill();
		}
	}
}