package com.goshare.view.personalCenter.editMode
{
	import com.goshare.components.EditBtn;
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.editMode.blockOfUserInfo.BlockOfUserInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class UserInfoDropSubMode extends UIComponent
	{
		public function UserInfoDropSubMode()
		{
			super();
			height = 40;
		}
		
		private var titleLab : Label;
		public var titleHeight : Number = 40;
		public var contentHeight : Number;
		private var showBtn : EditBtn;
		private var testBtn : Button;
		private var blockOfUserInfo : BlockOfUserInfo;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.fontSize = 18;
			titleLab.text = "个人信息";
			titleLab.color = 0x313131;
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			addChild(titleLab);
			
			showBtn = new EditBtn();
			showBtn.addEventListener(MouseEvent.CLICK,showHandler);
			addChild(showBtn);
			
			/*testBtn = new Button();
			testBtn.height = 600;
			testBtn.label = "test1";
			testBtn.addEventListener(MouseEvent.CLICK,testBtnHand);
			addChild(testBtn);
			testBtn.visible = false;*/
			
			blockOfUserInfo = new BlockOfUserInfo();
			blockOfUserInfo.height = 400;
			addChild(blockOfUserInfo);
			blockOfUserInfo.visible = false;
		}
		
		protected function testBtnHand(event:MouseEvent):void
		{
			testBtn.height = testBtn.height +5;
			invalidateHight();
			refreshHightShow();
		}
		
		protected function showHandler(event:MouseEvent):void
		{
//			testBtn.visible = !testBtn.visible;
			blockOfUserInfo.visible = !blockOfUserInfo.visible;
			if(blockOfUserInfo.visible){
//				blockOfUserInfo.getAllData();
			}
			showBtn.selected = blockOfUserInfo.visible;
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
			if(blockOfUserInfo.visible){
				this.height = titleHeight+blockOfUserInfo.height;
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
			blockOfUserInfo.width = 400;
			showBtn.x = width-showBtn.width-60;
			showBtn.y = (titleHeight-showBtn.height)/2;
			
			blockOfUserInfo.x = titleLab.x;
			blockOfUserInfo.y = titleHeight+10;
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