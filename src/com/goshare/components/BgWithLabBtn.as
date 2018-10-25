package com.goshare.components
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class BgWithLabBtn extends UIComponent
	{
		public function BgWithLabBtn()
		{
			super();
//			width = 230;
//			height = 100;
			buttonMode = true;
		}
		
		private var bgImg : Image;
		public var bgImgSource : String;
		private var iconImg : Image;
		public var iconImgSource : String;
		public var iconHeight : Number;
		public var iconWidth : Number;
		private var lab : Label;
		public var labTxt : String;
		private var numLab : Label;
		public var numTxt : String;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = bgImgSource;
			bgImg.height = height;
			bgImg.width = width;
			addChild(bgImg);
		
			iconImg  = new Image();
			iconImg.source = iconImgSource;
			iconImg.width = iconWidth;
			iconImg.height = iconHeight;
			addChild(iconImg);
			
			lab = new Label();
			lab.text = labTxt;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.color = 0xffffff;
			lab.fontSize = 20;
			addChild(lab);
			
			numLab = new Label();
			numLab.text = numTxt;
			numLab.fontFamily = FontFamily.STXIHEI;
			numLab.color = 0xffffff;
			numLab.fontSize = 26;
			numLab.bold = true;
			addChild(numLab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			iconImg.x = width/8;
			iconImg.y = (height-iconHeight)/2;
			lab.x = width/2;
			lab.y = height*2/3-3;
			
			numLab.x = width/2;
			numLab.y = height/4;
		}
	}
}