package com.goshare.view.login
{
	import com.goshare.components.TxtInputWithIcon;
	import com.goshare.data.Message;
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.manager.AppManager;
	import com.goshare.manager.AppRCManager;
	import com.goshare.view.MainView;
	import com.goshare.view.home.HomeView;
	import com.goshare.view.regsiter.RegsiterView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class LoginPanel extends UIComponent
	{
		public function LoginPanel()
		{
			super();
			width =1150;
			height = 500;
			
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGIN,
				appManager_appLoginHandler); ///监听到登录成功（与mina服务器长连接成功）
			//			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGOUT,
			//				appManager_appLogoutHandler);
			//			AppRCManager.getInstance().addEventListener(AgentManagerEvent.SYSTEM_ERROR,
			//				appManager_systemErrorHandler);
			//			AppRCManager.getInstance().addEventListener(AgentManagerEvent.SYSTEM_NOTICE,
			//				appManager_systemNoticeHandler);
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGIN_FAIL,appManager_appLoginFailHandler); ///监听到登录失败
		}
		
		
		
		private var logo : Image;
		private var lab : Label;
		private var userNameTxtInput : TxtInputWithIcon;
		
		private var passWordTxtInput : TxtInputWithIcon;
		private var loginBtn : Button;
		private var registerLab : Label;
		private var forgetPassWordLab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			logo = new Image();
			logo.width = 150;
			logo.height = 150;
			logo.source = "assets/login/logo.png";
			addChild(logo);
			
			lab = new Label();
			lab.fontFamily = FontFamily.STXIHEI;
			lab.fontSize = 26;
			lab.text = "密码登录";
			lab.bold = true;
			addChild(lab);
			
			userNameTxtInput = new TxtInputWithIcon();
			userNameTxtInput.color = 0x626262;
			userNameTxtInput.fontFamily = FontFamily.STXIHEI;
			userNameTxtInput.fontSize = 18;
			userNameTxtInput.maxChars = 11;
			userNameTxtInput.iconHeight = 30;
			userNameTxtInput.iconWidth = 27;
			userNameTxtInput.iconX = 15;
			userNameTxtInput.labX = 10;
			userNameTxtInput.height = 60;
			userNameTxtInput.width = (width/2-180);
			userNameTxtInput.iconSource = "assets/login/user.png";
			userNameTxtInput.placeHold = "账号";
//						userNameTxtInput.flag = true;///是否为报错样式
			userNameTxtInput.text = "fangchao";
			addChild(userNameTxtInput);
			
			passWordTxtInput = new TxtInputWithIcon();
			passWordTxtInput.color = 0x626262;
			passWordTxtInput.fontFamily = FontFamily.STXIHEI;
			passWordTxtInput.fontSize = 18;
			passWordTxtInput.maxChars = 18;
			passWordTxtInput.iconHeight = 30;
			passWordTxtInput.iconWidth = 19;
			passWordTxtInput.iconX = 19;
			passWordTxtInput.labX = 14;
			passWordTxtInput.height = 60;
			passWordTxtInput.width = (width/2-180);
			passWordTxtInput.iconSource = "assets/login/password.png";
			passWordTxtInput.placeHold = "密码";
			passWordTxtInput.displayAsPassword = true;
			passWordTxtInput.text = "111111";
			addChild(passWordTxtInput);
			
			
			loginBtn = new Button();
			loginBtn.radius = 10;
			loginBtn.width = (width/2-180);
			loginBtn.height = 60;
			loginBtn.fontSize = 18;
			loginBtn.color = 0xffffff;
			loginBtn.backgroundColor = 0x5c9dfd;
			loginBtn.label = "登录";
			loginBtn.fontSize = 26;
			loginBtn.fontFamily = FontFamily.STHEITI;
			loginBtn.buttonMode = true;
			loginBtn.addEventListener(MouseEvent.CLICK,loginBtn_handler);
			addChild(loginBtn);
			
			registerLab = new Label();
			registerLab.text = "快速注册";
			registerLab.buttonMode = true;
			registerLab.fontSize = 18;
			registerLab.fontFamily = FontFamily.STXIHEI;
			registerLab.addEventListener(MouseEvent.CLICK,registerLab_Handler);
			addChild(registerLab);
			
			forgetPassWordLab = new Label();
			forgetPassWordLab.text = "忘记密码";
			forgetPassWordLab.buttonMode = true;
			forgetPassWordLab.fontSize = 18;
			forgetPassWordLab.fontFamily = FontFamily.STXIHEI;
			addChild(forgetPassWordLab);
		}
		
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			logo.x = (width/2-logo.width)/2;
			logo.y = (height-logo.width)/2;
			
			lab.x = width/2+90;
			lab.y = 80;
			
			userNameTxtInput.x = lab.x;
			userNameTxtInput.y = lab.y+75;
			
			passWordTxtInput.x = lab.x;
			passWordTxtInput.y = userNameTxtInput.y+90;
			
			loginBtn.x = lab.x;
			loginBtn.y = passWordTxtInput.y+90;
			
			registerLab.x = lab.x;
			registerLab.y = loginBtn.y+loginBtn.height+35;
			
			forgetPassWordLab.x = loginBtn.x+loginBtn.width-(forgetPassWordLab.text.length)*forgetPassWordLab.fontSize;
			forgetPassWordLab.y = registerLab.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.2);
			graphics.drawRect(0,0,width/2,height);
			graphics.beginFill(0xf5f5f5);
			graphics.drawRect(width/2,0,width/2,height);
			graphics.endFill();
		}
		
		
		private function checkPhoneAvailable():Boolean
		{
			var myreg:RegExp=/^[1][3,4,5,6,7,8,9][0-9]{9}$/;
			return myreg.test(userNameTxtInput.text)
		}
		
		protected function loginBtn_handler(event:MouseEvent):void
		{
			checkData();
		}
		
		private function checkData():void
		{
			/*if(!checkPhoneAvailable()){Alert.show("手机号码有误");return}
			if(passWordTxtInput.text.length<6){Alert.show("密码未达到6位");return}*/
			
			//			AppService.getInstance().login(userNameTxtInput.text,passWordTxtInput.text,loginResult,loginFault);  ///http登录？
			
			// 开始登录
			AppRCManager.getInstance().login(userNameTxtInput.text,
				passWordTxtInput.text,
				AppManager.getInstance().APP_VERSION);
		}
		
		//		private function loginResult(e:Event):void
		//		{
		//			trace("resultHandler: "+e.currentTarget.data);
		//			var resultObj : Object = JSON.parse(e.currentTarget.data)
		//			if(resultObj["rspcod"]=="200"){
		//				trace(resultObj["rspmsg"]);
		//				goToHomeView();
		//			}else {
		//				Alert.show(resultObj["rspcod"]+";"+resultObj["rspmsg"]);
		//			}
		//		}
		
		
		/**
		 * 登录失败
		 */
		protected function appManager_appLoginFailHandler(event:AgentManagerEvent):void
		{
			trace(event.descript);
			Alert.show(event.descript);
		}
		
		/**
		 * 登录成功
		 */
		protected function appManager_appLoginHandler(event:AgentManagerEvent):void
		{
			AppManager.getInstance().log("[LoginPanel] 坐席登录成功");
			//			// 程序登录成功 保存登录账号信息
			//			AppManager.getInstance().username = nameInput.text;
			//			AppManager.getInstance().password = passwordInput.text;
			
			//登录成功时 告诉后台将历史记录保存至数据库
			//			saveHistroy();
			
			AppRCManager.getInstance().logout = false; ///注销标志位至false
			AppRCManager.getInstance().userID = userNameTxtInput.text; ///记录有效的坐席账号
			AppRCManager.getInstance().userPassword = passWordTxtInput.text; ///记录有效的坐席密码
			setTimeout(goToHomeView, 100);
		}
		
		///登录成功，进入主页面
		private function goToHomeView():void
		{
			MainView.getInstance().pushView(HomeView);
			
			/*var sendMessage:Message = new Message();
			sendMessage.messageType = "c1VersionQuest";
			sendMessage.messageTarget = "T0000040";
			sendMessage.messageSource = "fangchao";
			sendMessage.messageContent = "测试内容";
			AppRCManager.getInstance().sendMessageToC1(sendMessage);*/
		}
		
		private function loginFault(e:Event):void
		{
			trace("登录失败");
		}
		
		protected function registerLab_Handler(event:MouseEvent):void
		{
			MainView.getInstance().pushView(RegsiterView);
		}
	}
}