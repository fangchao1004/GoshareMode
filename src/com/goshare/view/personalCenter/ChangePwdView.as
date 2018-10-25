package com.goshare.view.personalCenter
{
	import com.goshare.components.LabColorBtnWithChange;
	import com.goshare.components.TxtInputPlcHold;
	import com.goshare.view.personalCenter.changePswMode.ChangePswMode;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class ChangePwdView extends UIComponent
	{
		public function ChangePwdView()
		{
			super();
		}
		
		private var lab : Label;
		private var titleIcon : Image;
		private var changePswMode : ChangePswMode;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleIcon = new Image();
			titleIcon.source = "assets/personalCenter/changePwd_selected.png";
			titleIcon.width = 18;
			titleIcon.height = 18;
			addChild(titleIcon);
			
			lab = new Label();
			lab.text = "密码修改";
			lab.color = 0x5c9dfd;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.bold = true;
			lab.fontSize = 20;
			addChild(lab);
			
			changePswMode = new ChangePswMode();
			changePswMode.width = 400;
			changePswMode.height = 200;
			addChild(changePswMode);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleIcon.width = titleIcon.height = 24;
			titleIcon.x = 35;
			titleIcon.y = 13;
			
			lab.x = 80;
			lab.y = 13;
			
			changePswMode.x = 80;
			changePswMode.y = titleIcon.y+40;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xffff00,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
	}
}