package com.goshare.render
{
	import coco.component.DefaultItemRenderer;
	import coco.util.FontFamily;
	
	public class itemRenderForDropList extends DefaultItemRenderer
	{
		public function itemRenderForDropList()
		{
			super();
			autoDrawSkin = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontFamily = FontFamily.STXIHEI;
			labelDisplay.bold = true;
			labelDisplay.fontSize = 14;
			labelDisplay.color = 0x969696;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(selected?0xe5e5e5:0xf6f5f5);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}