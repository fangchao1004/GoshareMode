package com.goshare.view.home
{
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.Message;
	import com.goshare.data.MessageType;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.view.MainView;
	import com.goshare.view.login.LoginView;
	import com.goshare.view.personalCenter.PersonalCenterView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class TopBarView extends UIComponent
	{
		public function TopBarView()
		{
			super();
		}
		
		private var logout : Label;
		private var personCenter : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			var lab : Label = new Label();
			lab.text = "顶部条区";
			addChild(lab);
			lab.visible = false;
			
			logout = new Label();
			logout.buttonMode = true;
			logout.text = "注销";
			logout.color = 0xffffff;
			logout.fontFamily = FontFamily.STXIHEI;
			logout.fontSize = 18;
			logout.addEventListener(MouseEvent.CLICK,logout_Handler);
			addChild(logout);
			
			personCenter = new Label();
			personCenter.buttonMode = true;
			personCenter.text = "个人中心";
			personCenter.color = 0xffffff;
			personCenter.fontFamily = FontFamily.STXIHEI;
			personCenter.fontSize = 18;
			personCenter.addEventListener(MouseEvent.CLICK,personCenter_Handler);
			addChild(personCenter);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			logout.x = width-40-logout.text.length*logout.fontSize;
			logout.y = (height-logout.fontSize)/2;
			
			personCenter.x = logout.x - 100;
			personCenter.y = logout.y;
		}
		
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x689DF6);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function logout_Handler(event:MouseEvent):void
		{
			MainView.getInstance().pushView(LoginView);
			
			var sendMessage:Message = new Message();
			sendMessage.messageType = MessageType.Z005;
			sendMessage.messageContent = "客服注销";
			AppRCManager.getInstance().sendMessage(sendMessage);
			
//			var e : TestEvent = new TestEvent("logout");///向外界派发注销事件
//			EventManager.getInstance().dispatchEvent(e);
//			EventManager.getInstance().addEventListener("logout"
		}
		
		/**
		 * 点击 “个人中心” 按钮，进入个人中心模块
		 * 获取个人信息，同步显示各个组件的状态
		 * @param event
		 */
		protected function personCenter_Handler(event:MouseEvent):void
		{
			///假设已经从后台获取的个人信息，将其保存在一个可以全局访问的变量中
			DataOfPublic.getInstance().allDataByRegsiter ={
				"userId":"13000000000",
				"gender": "男",
				"work": [{
					"teachClasses": ["001", "002"],
					"subject": "英语",
					"grade": "001"
				}, {
					"teachClasses": ["003", "004"],
					"subject": "英语",
					"grade": "002"
				}],
				"userBirthday": "1997-10-6",
				"userNativePlace": "安徽省-合肥市-蜀山区",
				"userName": "张老师",
				"userAddress": "吉林省-白城市-洮北区",
				"userFace": "http://pic35.photophoto.cn/20150528/0005018363609539_b.jpg",
				"duty": [{
					"teachClasses": ["002", "003"],
					"role": "班主任",
					"grade": "001"
				}, {
					"teachClasses": ["004", "005"],
					"role": "班主任",
					"grade": "002"
				}],
				"school": "000000002"
			}
				
			///先进入个人中心模块
			MainView.getInstance().pushView(PersonalCenterView);
			///再向后台接口获取个人信息和课件信息
			EventManager.getInstance().dispatchEventQuick("getUserInfoFromServer");  ///PersonalCenterView中进行了监听
		}	
	}
}