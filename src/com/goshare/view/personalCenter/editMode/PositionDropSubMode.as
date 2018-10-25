package com.goshare.view.personalCenter.editMode
{
	import com.goshare.components.EditBtn;
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.editMode.blockOfPosition.BlockOfPosition;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class PositionDropSubMode extends UIComponent
	{
		public function PositionDropSubMode()
		{
			super();
			height = 40;
			EventManager.getInstance().addEventListener("BlockOfPositionNewSize",BlockOfPositionNewSize_Handler);
		}
		
		protected function BlockOfPositionNewSize_Handler(event:Event):void
		{
			invalidateHight();
			refreshHightShow();
		}
		
		private var titleLab : Label;
		public var titleHeight : Number = 40;
		public var contentHeight : Number;
		private var showBtn : EditBtn;
		private var testBtn : Button;
		private var blockOfPos:BlockOfPosition;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.fontSize = 18;
			titleLab.text = "职位信息";
			titleLab.color = 0x313131;
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			addChild(titleLab);
			
			showBtn = new EditBtn();
			showBtn.addEventListener(MouseEvent.CLICK,showHandler);
			addChild(showBtn);
			
			blockOfPos = new BlockOfPosition();
			addChild(blockOfPos);
			blockOfPos.visible = false;
		}
		
		
		/**
		 * 点击“编辑按钮” 显示职位模块（班主任）
		 */
		protected function showHandler(event:MouseEvent):void
		{
			blockOfPos.visible = !blockOfPos.visible;
			if(blockOfPos.visible){
				blockOfPos.showDropList();
			}
			showBtn.selected = blockOfPos.visible;
			invalidateHight();
			refreshHightShow();
		}
		
		private function refreshHightShow():void
		{
			EventManager.getInstance().dispatchEventQuick("refreshHightShow");
		}
		
		private function invalidateHight():void
		{
			if(blockOfPos.visible){
				this.height = titleHeight+blockOfPos.height;
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
			
//			testBtn.width = width;
			showBtn.x = width-showBtn.width-60;
			showBtn.y = (titleHeight-showBtn.height)/2;
			
//			testBtn.x = 0;
//			testBtn.y = titleHeight;
			
			blockOfPos.width = 400;
			blockOfPos.x = titleLab.x;
			blockOfPos.y = titleHeight;
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