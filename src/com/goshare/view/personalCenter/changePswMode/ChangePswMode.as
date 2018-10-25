package com.goshare.view.personalCenter.changePswMode
{
	import com.goshare.components.TxtInputPlcHold;
	import com.goshare.manager.AppRCManager;
	import com.goshare.service.AppService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class ChangePswMode extends UIComponent
	{
		public function ChangePswMode()
		{
			super();
		}
		
		private var oldPswLab : Label;
		private var newPswLab : Label;
		private var ensureLab : Label;
		private var oldPswTxtInput : TxtInputPlcHold;
		private var newPswTxtInput : TxtInputPlcHold;
		private var ensureTxtInput : TxtInputPlcHold;
		private var saveBtn : Button;
		private var cancelBtn : Button;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			oldPswLab =  new Label();
			oldPswLab.text = "旧密码";
			oldPswLab.fontSize = 16;
			oldPswLab.bold = true;
			oldPswLab.fontFamily = FontFamily.STXIHEI;
			addChild(oldPswLab);
			
			newPswLab =  new Label();
			newPswLab.text = "新密码";
			newPswLab.fontSize = 16;
			newPswLab.bold = true;
			newPswLab.fontFamily = FontFamily.STXIHEI;
			addChild(newPswLab);
			
			ensureLab =  new Label();
			ensureLab.text = "确    定";
			ensureLab.fontSize = 16;
			ensureLab.bold = true;
			ensureLab.fontFamily = FontFamily.STXIHEI;
			addChild(ensureLab);
			
			oldPswTxtInput = new TxtInputPlcHold();
			oldPswTxtInput.displayAsPassword = true;
			oldPswTxtInput.placeHold = "请输入旧密码";
			oldPswTxtInput.maxChars = 12;
			oldPswTxtInput.height = 36;
			oldPswTxtInput.width = 290;
			oldPswTxtInput.radius = 10;
			oldPswTxtInput.borderColor = 0xf6f5f5;
			oldPswTxtInput.backgroundColor = 0xf6f5f5;
			oldPswTxtInput.color = 0x8c8c8c;
			oldPswTxtInput.fontSize = 18;
			oldPswTxtInput.fontFamily = FontFamily.STXIHEI;
			addChild(oldPswTxtInput);
			
			newPswTxtInput = new TxtInputPlcHold();
			newPswTxtInput.displayAsPassword = true;
			newPswTxtInput.placeHold = "设定新密码";
			newPswTxtInput.maxChars = 12;
			newPswTxtInput.height = 36;
			newPswTxtInput.width = 290;
			newPswTxtInput.radius = 10;
			newPswTxtInput.borderColor = 0xf6f5f5;
			newPswTxtInput.backgroundColor = 0xf6f5f5;
			newPswTxtInput.color = 0x8c8c8c;
			newPswTxtInput.fontSize = 18;
			newPswTxtInput.fontFamily = FontFamily.STXIHEI;
			addChild(newPswTxtInput);
			
			ensureTxtInput = new TxtInputPlcHold();
			ensureTxtInput.displayAsPassword = true;
			ensureTxtInput.placeHold = "请再次输入新密码";
			ensureTxtInput.maxChars = 12;
			ensureTxtInput.height = 36;
			ensureTxtInput.width = 290;
			ensureTxtInput.radius = 10;
			ensureTxtInput.borderColor = 0xf6f5f5;
			ensureTxtInput.backgroundColor = 0xf6f5f5;
			ensureTxtInput.color = 0x8c8c8c;
			ensureTxtInput.fontSize = 18;
			ensureTxtInput.fontFamily = FontFamily.STXIHEI;
			addChild(ensureTxtInput);
			
			saveBtn = new Button();
			saveBtn.width = 100;
			saveBtn.height = 30;
			saveBtn.fontSize = 18;
			saveBtn.backgroundColor = 0x5c9dfd;
			saveBtn.color = 0xffffff;
			saveBtn.radius = 8;
			saveBtn.label = "保存";
			saveBtn.fontFamily = "Microsoft  YaHei";
			saveBtn.buttonMode = true;
			saveBtn.addEventListener(MouseEvent.CLICK,saveBtn_handler);
			addChild(saveBtn);
			
			cancelBtn =new Button();
			cancelBtn.width = 100;
			cancelBtn.height = 30;
			cancelBtn.fontSize = 18;
			cancelBtn.backgroundColor = 0xffffff;
			cancelBtn.color = 0x5c9dfd;
			cancelBtn.borderColor = 0x5c9dfd;
			cancelBtn.radius = 8;
			cancelBtn.label = "取消";
			cancelBtn.fontFamily = "Microsoft  YaHei";
			cancelBtn.buttonMode = true;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtn_handler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			oldPswLab.x = 0;
			oldPswLab.y = 0;
			
			newPswLab.x = 0;
			newPswLab.y = oldPswLab.y+55;
			
			ensureLab.x = 0;
			ensureLab.y = newPswLab.y+55;
			
			oldPswTxtInput.x = oldPswLab.x+ 70;
			oldPswTxtInput.y = oldPswLab.y-5;
			
			newPswTxtInput.x = newPswLab.x+ 70;
			newPswTxtInput.y = newPswLab.y-5;
			
			ensureTxtInput.x = ensureLab.x+ 70;
			ensureTxtInput.y = ensureLab.y-5;
			
			saveBtn.x = ensureTxtInput.x+20;
			saveBtn.y = ensureTxtInput.y+55;
			
			cancelBtn.x = saveBtn.x+saveBtn.width+20;
			cancelBtn.y = saveBtn.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xff0000,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
		
		protected function cancelBtn_handler(event:MouseEvent):void
		{
			oldPswTxtInput.text = "";
			newPswTxtInput.text = "";
			ensureTxtInput.text = "";
		}		
		
		protected function saveBtn_handler(event:MouseEvent):void
		{
			if(oldPswTxtInput.text!=AppRCManager.getInstance().userPassword){
				Alert.show("原始密码不对");
				oldPswTxtInput.text = "";
				newPswTxtInput.text = "";
				ensureTxtInput.text = "";
				return;
			}
			
			if(newPswTxtInput.text!=ensureTxtInput.text&&newPswTxtInput.text!=""){
				Alert.show("确认密码不一致");
				newPswTxtInput.text = "";
				ensureTxtInput.text = "";
				return;
			}
			
			var PwData : Object = new Object();
			PwData.userId = AppRCManager.getInstance().userID;
			PwData.oldPwd = AppRCManager.getInstance().userPassword;
			PwData.newPwd = newPswTxtInput.text;
			
			AppService.getInstance().resetUserPwd(PwData,resetPwdSuccess,resetPwdFault);
		}
		
		private function resetPwdFault(e:Event):void
		{
			trace("密码修改失败");
			var resultObj : Object = JSON.parse(e.currentTarget.data);
			Alert.show(resultObj.rspmsg);
		}
		
		private function resetPwdSuccess(e:Event):void
		{
			trace("密码修改成功");
			var resultObj : Object = JSON.parse(e.currentTarget.data);
			Alert.show(resultObj.rspmsg);
		}
	}
}