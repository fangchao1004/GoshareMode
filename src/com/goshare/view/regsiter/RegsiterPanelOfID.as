package com.goshare.view.regsiter
{
	import com.goshare.components.TxtInputPlcHold;
	import com.goshare.data.UserFormInfo;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.AppManager;
	import com.goshare.service.AppService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 注册-输入账号密码部分（第一步）
	 */
	public class RegsiterPanelOfID extends UIComponent
	{
		public function RegsiterPanelOfID()
		{
			super();
			//			width = 420;
			//			height = 370;
		}
		
		private var idLab : Label;
		private var idInput : TxtInputPlcHold;
		private var codeLab : Label;
		private var codeInput : TextInput;
		private var codeBtn : Button;
		private var passwordLab : Label;
		private var passwordInput : TxtInputPlcHold;
		private var ensurePaswrdLab : Label;
		private var ensurePaswrdInput : TxtInputPlcHold;
		private var nextStepBtn : Button;
		private var stepImg : Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			stepImg = new Image();
			stepImg.source = "assets/regsiter/step1.png";
			addChild(stepImg);
			
			idLab = new Label();
			idLab.text = "账    号";
			idLab.bold = true;
			idLab.fontFamily = FontFamily.STXIHEI;
			idLab.fontSize = 16;
			addChild(idLab);
			
			idInput = new TxtInputPlcHold();
			idInput.placeHold = "请输入手机号码";
			idInput.maxChars = 11;
			idInput.height = 36;
			idInput.width = 290;
			idInput.radius = 10;
			idInput.backgroundColor = 0xf6f5f5;
			idInput.color = 0x8c8c8c;
			idInput.fontSize = 18;
			idInput.fontFamily = FontFamily.STXIHEI;
			addChild(idInput);
			
			codeLab = new Label();
			codeLab.text = "验证码";
			codeLab.bold = true;
			codeLab.fontFamily = FontFamily.STXIHEI;
			codeLab.fontSize = 16;
			addChild(codeLab);
			
			codeInput = new TextInput();
			codeInput.height = 36;
			codeInput.width = 140;
			codeInput.radius = 10;
			codeInput.backgroundColor = 0xf6f5f5;
			codeInput.color = 0x8c8c8c;
			codeInput.fontSize = 18;
			codeInput.fontFamily = FontFamily.STXIHEI;
			addChild(codeInput);
			
			codeBtn = new Button();
			codeBtn.buttonMode = true;
			codeBtn.radius = 10;
			codeBtn.backgroundColor = 0xe4e4e4;
			codeBtn.color = 0x8c8c8c;
			codeBtn.fontFamily = FontFamily.STXIHEI;
			codeBtn.fontSize = 18;
			codeBtn.label = "获取验证码";
			codeBtn.width = 140;
			codeBtn.height = 36;
			codeBtn.addEventListener(MouseEvent.CLICK,codeBtn_Handler);
			addChild(codeBtn);
			
			passwordLab = new Label();
			passwordLab.text = "密    码";
			passwordLab.bold = true;
			passwordLab.fontFamily = FontFamily.STXIHEI;
			passwordLab.fontSize = 16;
			addChild(passwordLab);
			
			passwordInput = new TxtInputPlcHold();
			passwordInput.placeHold = "设定登录密码";
			passwordInput.height = 36;
			passwordInput.width = 290;
			passwordInput.radius = 10;
			passwordInput.backgroundColor = 0xf6f5f5;
			passwordInput.color = 0x8c8c8c;
			passwordInput.fontSize = 18;
			passwordInput.fontFamily = FontFamily.STXIHEI;
			addChild(passwordInput);
			
			ensurePaswrdLab = new Label();
			ensurePaswrdLab.text = "确    认";
			ensurePaswrdLab.bold = true;
			ensurePaswrdLab.fontFamily = FontFamily.STXIHEI;
			ensurePaswrdLab.fontSize = 16;
			addChild(ensurePaswrdLab);
			
			ensurePaswrdInput = new TxtInputPlcHold();
			ensurePaswrdInput.placeHold = "请再次输入登录密码";
			ensurePaswrdInput.height = 36;
			ensurePaswrdInput.width = 290;
			ensurePaswrdInput.radius = 10;
			ensurePaswrdInput.backgroundColor = 0xf6f5f5;
			ensurePaswrdInput.color = 0x8c8c8c;
			ensurePaswrdInput.fontSize = 18;
			ensurePaswrdInput.fontFamily = FontFamily.STXIHEI;
			addChild(ensurePaswrdInput);
			
			nextStepBtn = new Button();
			nextStepBtn.buttonMode = true;
			nextStepBtn.radius = 10;
			nextStepBtn.backgroundColor = 0x5c9dfd
			nextStepBtn.color = 0xffffff;
			nextStepBtn.fontFamily = FontFamily.STXIHEI;
			nextStepBtn.fontSize = 20;
			nextStepBtn.label = "下一步";
			nextStepBtn.width = 290;
			nextStepBtn.height = 36;
			nextStepBtn.addEventListener(MouseEvent.CLICK,nextStepBtn_Handler);
			addChild(nextStepBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			stepImg.width = 420*1.2;
			stepImg.height = 54*1.2;
			stepImg.x = (width-stepImg.width)/2;
			stepImg.y = 50;
			
			idLab.x = 10+(width-420)/2;
			idLab.y = 40+(height-450)/2;
			
			idInput.x = 90+(width-420)/2;
			idInput.y = 30+(height-450)/2;
			
			codeLab.x = 10+(width-420)/2;
			codeLab.y = 95+(height-450)/2;
			
			codeInput.x = 90+(width-420)/2;
			codeInput.y = 85+(height-450)/2;
			
			codeBtn.x = codeInput.x+codeInput.width+10;
			codeBtn.y = codeInput.y;
			
			passwordLab.x = 10+(width-420)/2;
			passwordLab.y = 150+(height-450)/2;
			
			passwordInput.x = 90+(width-420)/2;
			passwordInput.y = 140+(height-450)/2;
			
			ensurePaswrdLab.x = 10+(width-420)/2;
			ensurePaswrdLab.y = 205+(height-450)/2;
			
			ensurePaswrdInput.x = 90+(width-420)/2;
			ensurePaswrdInput.y = 195+(height-450)/2;
			
			nextStepBtn.x = 90+(width-420)/2;
			nextStepBtn.y = 260+(height-450)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		private var getCodeFlag : Boolean;
		private var num : int;
		private var setIntervalTime : uint;
		protected function codeBtn_Handler(event:MouseEvent):void
		{
			if(getCodeFlag){Alert.show("已经发送，请稍等");return}
			if(!checkPhoneAvailable()){Alert.show("手机号码有误");return}
			
			num = 20;
			getCodeHandler();
			setIntervalTime = setInterval(refreshTimeHandler,1000); ///每秒刷新一次
		}
		
		private function checkPhoneAvailable():Boolean
		{
			var myreg:RegExp=/^[1][3,4,5,6,7,8,9][0-9]{9}$/;
			return myreg.test(idInput.text)
		}
		
		private function refreshTimeHandler():void
		{
			num--;
			codeBtn.label = "重新发送 ("+num+")"
			if(num==0){resetGetCodeFLag()}
		}
		
		///重置获取验证码状态
		private function resetGetCodeFLag():void
		{
			trace("清除循环定时，重置获取验证码状态");
			clearInterval(setIntervalTime)
			getCodeFlag = false
			codeBtn.label = "获取验证码"
		}
		
		private function getCodeHandler():void
		{
			UserInfo.userId = idInput.text;
			
			///往后台接口发送 账号（手机号）获取验证码
//			trace("往后台接口发送：",idInput.text,"；用于获取验证码");
			AppService.getInstance().getCode(idInput.text,getCodeResultHandler,getCodeFaultHandler);
			///正常发送后
			getCodeFlag = true;
		}
		
		private function getCodeFaultHandler(e:Event):void
		{
			Alert.show("获取验证码失败",e.type);
		}
		
		private function getCodeResultHandler(e:Event):void
		{
			var dataObj : Object = JSON.parse(e.currentTarget.data);
			if(dataObj["rspcod"]=="200"){
				codeInput.text = dataObj["obj"]
//				trace("获取验证码成功");
				AppManager.getInstance().log("[RegsiterPanelOfID] 获取验证码成功");
			}
		}
		
		protected function nextStepBtn_Handler(event:MouseEvent):void
		{
			///调试用testHandler，正常用checkSelectedData;
//			checkSelectedData(); 
			testHandler();
		}
		
		/**
		 * 直接赋值跳转，用于测试，防止后台注册失败无法跳转到下一页面
		 */
		private function testHandler():void
		{
			RegsiterNavigator.getInstance().pushView(RegsiterPanelOfInfo);
			UserInfo.userId = idInput.text;
		}
		
		private function checkSelectedData():void
		{
			///往后台发送 账号，验证码，密码，正式注册
//			trace("账号："+idInput.text,"密码："+passwordInput.text,"验证码："+codeInput.text);
			if(idInput.text.length<11){ Alert.show("账号位数有误");return;}
			if(!codeInput.text){Alert.show("验证码不存在");return;}
			if(passwordInput.text.length<6){Alert.show("密码未达到6位");return;}
			if(ensurePaswrdInput.text!=passwordInput.text){Alert.show("确认密码不一致");return;}
			///开始注册
			AppService.getInstance().regsiterTest(idInput.text,passwordInput.text,codeInput.text,resultHandler,faultHandler);
		}
		///注册结果
		private function resultHandler(e:Event):void
		{
//			trace("resultHandler: "+e.currentTarget.data);
			var resultObj : Object = JSON.parse(e.currentTarget.data)
			if(resultObj["rspcod"]=="200"){
				trace("注册成功");
				///如果账号注册成功  下一步 进入完善个人信息界面
				UserInfo.userId = idInput.text;///将账号信息存入UserInfo.userId
				RegsiterNavigator.getInstance().pushView(RegsiterPanelOfInfo);
				resetGetCodeFLag();
			}else {
				Alert.show(resultObj["rspcod"]+";"+resultObj["rspmsg"]);
			}
		}
		
		private function faultHandler(e:Event):void
		{
			Alert.show("注册失败: "+e.type);
		}
		
	}
}