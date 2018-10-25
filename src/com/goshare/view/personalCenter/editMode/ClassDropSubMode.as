package com.goshare.view.personalCenter.editMode
{
	import com.goshare.components.EditBtn;
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.editMode.blockOfClass.BlockOfClass;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class ClassDropSubMode extends UIComponent
	{
		public function ClassDropSubMode()
		{
			super();
			height = 40;
			EventManager.getInstance().addEventListener("BlockOfClassNewSize",BlockOfClassNewSize_Handler);
		}
		
		protected function BlockOfClassNewSize_Handler(event:Event):void
		{
			invalidateHight();
			refreshHightShow();
		}
		
		private var titleLab : Label;
		public var titleHeight : Number = 40;
		public var contentHeight : Number;
		private var showBtn : EditBtn;
		private var testBtn : Button;
		private var blockOfClass : BlockOfClass;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.fontSize = 18;
			titleLab.text = "教课信息";
			titleLab.color = 0x313131;
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			addChild(titleLab);
			
			showBtn = new EditBtn();
			showBtn.addEventListener(MouseEvent.CLICK,showHandler);
			addChild(showBtn);
			
			blockOfClass = new BlockOfClass();
			blockOfClass.height = 120;
			addChild(blockOfClass);
			blockOfClass.visible = false;
		}
		
		protected function showHandler(event:MouseEvent):void
		{
			blockOfClass.visible = !blockOfClass.visible;
			if(blockOfClass.visible){
				blockOfClass.showDropList();
			}
			showBtn.selected = blockOfClass.visible;
			invalidateHight();
			refreshHightShow();
		}
		
		private function refreshHightShow():void
		{
//			trace("刷新界面");
			EventManager.getInstance().dispatchEventQuick("refreshHightShow");
		}
		
		private function invalidateHight():void
		{
			if(blockOfClass.visible){
				this.height = titleHeight+blockOfClass.height;
			}else{
				this.height = titleHeight;
			}
			
//			trace("newHeight:"+this.height);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.x = 60;
			titleLab.y = (titleHeight-titleLab.fontSize)/2;
			
			showBtn.x = width-showBtn.width-60;
			showBtn.y = (titleHeight-showBtn.height)/2;
			
			blockOfClass.width = 400;
			blockOfClass.x = titleLab.x;
			blockOfClass.y = titleHeight;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x5c9dfd,0.2);
			graphics.drawRoundRect(0,0,width,titleHeight,8,8);
			graphics.endFill();
		}
	}
}