package com.goshare.view.personalCenter.editMode
{
	import com.goshare.components.EditBtn;
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.editMode.blockOfSubject.BlockOfSubject;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class SubjectDropSubMode extends UIComponent
	{
		public function SubjectDropSubMode()
		{
			super();
			height = 40;
		}
		
		private var titleLab : Label;
		public var titleHeight : Number = 40;
		public var contentHeight : Number;
		private var showBtn : EditBtn;
		private var blockOfSubject : BlockOfSubject;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.fontSize = 18;
			titleLab.text = "科目选择";
			titleLab.color = 0x313131;
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			addChild(titleLab);
			
			showBtn = new EditBtn();
			showBtn.addEventListener(MouseEvent.CLICK,showHandler);
			addChild(showBtn);
			
			blockOfSubject = new BlockOfSubject();
			blockOfSubject.height = 90;
			addChild(blockOfSubject);
			blockOfSubject.visible = false;
		}
		
		protected function showHandler(event:MouseEvent):void
		{
			blockOfSubject.visible = !blockOfSubject.visible;
			if(blockOfSubject.visible){
				blockOfSubject.showSubjectList();
			}
			showBtn.selected = blockOfSubject.visible;
			invalidateHight();
			refreshHightShow();
		}
		
		private function refreshHightShow():void
		{
			EventManager.getInstance().dispatchEventQuick("refreshHightShow");
		}
		
		private function invalidateHight():void
		{
			if(blockOfSubject.visible){
				this.height = titleHeight+blockOfSubject.height;
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
			
			blockOfSubject.width = width;
			showBtn.x = width-showBtn.width-60;
			showBtn.y = (titleHeight-showBtn.height)/2;
			
			blockOfSubject.x = 60;
			blockOfSubject.y = titleHeight+10;
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