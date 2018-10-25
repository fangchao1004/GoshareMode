package com.goshare.render
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	import coco.util.FontFamily;
	
	public class ItemRenderForCategoryList extends DefaultItemRenderer
	{
		public function ItemRenderForCategoryList()
		{
			super();
			mouseChildren = true;
		}
		
		private var icon : Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			icon = new Image();
			icon.width = icon.height = 24;
			addChild(icon);
			
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.color = 0x313131;
			labelDisplay.x = 40;
			labelDisplay.fontFamily = FontFamily.STXIHEI;
			labelDisplay.bold = true;
			labelDisplay.fontSize  = 18;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			icon.x = 12;
			icon.y = (height-icon.height)/2;
			
			labelDisplay.y = (height-labelDisplay.fontSize)/2-12;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			
			graphics.lineStyle(3,selected?0x5c9dfd:0xffffff);
			graphics.moveTo(0,height);
			graphics.lineTo(width,height);
			graphics.endFill();
			
			labelDisplay.color = selected?0x5c9dfd:0x313131;
			icon.source = selected?"assets/file/"+data["fileType"]+"_selected.png":"assets/file/"+data["fileType"]+"_unSelected.png"
		}
	}
}