package com.goshare.render
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.util.FontFamily;
	
	public class itemRenderForProjectList extends DefaultItemRenderer
	{
		public function itemRenderForProjectList()
		{
			super();
			autoDrawSkin = false;
		}
		
		
		
		private var selectedIcon : Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontFamily = FontFamily.STXIHEI;
			labelDisplay.bold = true;
			labelDisplay.fontSize = 16;
			
			selectedIcon = new Image();
			selectedIcon.source ="assets/regsiter/selectedIcon.png";
			selectedIcon.width = selectedIcon.height = 14;
			addChild(selectedIcon);
			selectedIcon.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			selectedIcon.x = width-selectedIcon.width;
			selectedIcon.y = 0;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			
			selectedIcon.visible = selected;
			labelDisplay.color = selected?0x5c9dfd:0x969696
			
			graphics.clear();
			graphics.beginFill(selected?0xf1f5fd:0xf6f5f5);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}