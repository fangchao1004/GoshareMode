package com.goshare.view.personalCenter.normalSetMode.blockOfRecordPlay
{
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.ToggleButton;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 录播子块
	 */	
	public class BlockOfRecordPlay extends UIComponent
	{
		public function BlockOfRecordPlay()
		{
			super();
		}
		
		private var lab : Label;
		private var openToggle : ToggleButton;
		private var closeToggle : ToggleButton;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = "自动录播：";
			lab.fontSize = 18;
			lab.color = 0x313131;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.bold = true;
			addChild(lab);
			
			openToggle = new ToggleButton();
			openToggle.label = "开";
			openToggle.width = 100;
			openToggle.height = 35;
			openToggle.radius = 8;
			openToggle.selected = false;
			addChild(openToggle);
			
			closeToggle = new ToggleButton();
			closeToggle.label = "关";
			closeToggle.width = 100;
			closeToggle.height = 35;
			closeToggle.radius = 8;
			closeToggle.selected = true;
			addChild(closeToggle);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.x = 0;
			lab.y = 10;
			
			openToggle.x = lab.x+120;
			openToggle.y = 2;
			
			closeToggle.x = openToggle.x+openToggle.width+20;
			closeToggle.y = openToggle.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xff00000,.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
	}
}