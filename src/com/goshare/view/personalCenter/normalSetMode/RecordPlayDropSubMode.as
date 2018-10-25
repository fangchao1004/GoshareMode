package com.goshare.view.personalCenter.normalSetMode
{
	import com.goshare.components.EditBtn;
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.normalSetMode.blockOfRecordPlay.BlockOfRecordPlay;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 录播设置子模块_向下弹出
	 */	
	public class RecordPlayDropSubMode extends UIComponent
	{
		public function RecordPlayDropSubMode()
		{
			super();
			height = 40;
		}
		
		private var titleLab : Label;
		public var titleHeight : Number = 40;
		public var contentHeight : Number;
		private var showBtn : EditBtn;
		private var blockOfRecordPlay : BlockOfRecordPlay
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.fontSize = 18;
			titleLab.text = "录播设置";
			titleLab.color = 0x313131;
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			addChild(titleLab);
			
			showBtn = new EditBtn();
			showBtn.addEventListener(MouseEvent.CLICK,showHandler);
			addChild(showBtn);
			
//			testBtn = new Button();
//			testBtn.height = 300;
//			testBtn.label = "test1";
//			testBtn.addEventListener(MouseEvent.CLICK,testBtnHand);
//			addChild(testBtn);
//			testBtn.visible = false;
			
			blockOfRecordPlay = new BlockOfRecordPlay();
			blockOfRecordPlay.height = 40;
			addChild(blockOfRecordPlay);
			blockOfRecordPlay.visible = false;
		}
		
//		protected function testBtnHand(event:MouseEvent):void
//		{
//			testBtn.height = testBtn.height +5;
//			invalidateHight();
//			refreshHightShow();
//		}
		
		protected function showHandler(event:MouseEvent):void
		{
//			testBtn.visible = !testBtn.visible;
			blockOfRecordPlay.visible = !blockOfRecordPlay.visible;
			showBtn.selected = blockOfRecordPlay.visible;
			invalidateHight();
			refreshHightShow();
		}
		
		private function refreshHightShow():void
		{
			trace("刷新基本设置模块界面");
			var event :Event = new Event("refreshHightShow_NormalMode");
			EventManager.getInstance().dispatchEvent(event);
		}
		
		private function invalidateHight():void
		{
			if(blockOfRecordPlay.visible){
				this.height = titleHeight+blockOfRecordPlay.height;
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
			
			blockOfRecordPlay.width = width;
			showBtn.x = width-showBtn.width-60;
			showBtn.y = (titleHeight-showBtn.height)/2;
			
			blockOfRecordPlay.x = 60;
			blockOfRecordPlay.y = titleHeight+10;
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