package com.goshare.components
{
	import coco.component.Label;
	import coco.util.FontFamily;
	
	
	public class NewDropList extends MyDropDownList
	{
		public function NewDropList()
		{
			super();
			height = 46;
		}
		
		private var lab : Label;
		public var labText:String;
		public var labX:Number=5;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = labText;
			lab.fontFamily= FontFamily.STXIHEI;
			lab.color = 0xa0a0a0;
			lab.fontSize = 16;
			lab.y = (height-lab.fontSize)/2-2;
//			lab.x = -labWidth+(labWidth-lab.fontSize)/2;
			lab.x = -labWidth+labX;
			addChild(lab);
		}
		
		public var labWidth : Number=36;
		public var topLeftRs : Number;
		public var bottomLeftRs : Number;
		
		override protected function drawSkin():void
		{
			super.drawSkin();
//			graphics.clear();
			graphics.lineStyle(1,0x969696);
			graphics.moveTo(width-30,height*2/5);
			graphics.lineTo(width-22,height*3/5);
			graphics.lineTo(width-14,height*2/5);
			
			graphics.beginFill(0xe5e5e5);
			graphics.lineStyle(1,0xe5e5e5);
//			graphics.drawRoundRectComplex(0,0,labWidth,height,topLeftRs,0,bottomLeftRs,0);
			graphics.drawRoundRectComplex(-labWidth,0,labWidth,height,10,0,10,0);
			graphics.endFill();
		}
		
	}
}