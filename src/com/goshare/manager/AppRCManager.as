package com.goshare.manager
{
	import com.goshare.data.ClientMessageType;
	import com.goshare.data.Message;
	import com.goshare.data.RC;
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.event.TestEvent;
	import com.goshare.service.AppService;
	
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.core.Application;
	
	[Event(name="rcListChanged", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="rcStatusChanged", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="rcSelectChanged", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="robotMessage", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="rc//notice", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="increaseInteractiveViewSize", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="decreaseInteractiveViewSize", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="InteractiveViewOrderTypeChange", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="stageSizeChange", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="dataCountOver", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="transmitRcInfo", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="personalDefineRefresh", type="com.goshare.event.AppRCManagerEvent")]
	
	[Event(name="personalDefineChange", type="com.goshare.event.AppRCManagerEvent")]
	
	/**
	 * 终端管理器Z
	 */ 
	public class AppRCManager extends AgentManager
	{
		public function AppRCManager(target:IEventDispatcher = null)
		{
			super(target);
			
			addEventListener(AgentManagerEvent.CLIENT_LOGIN, this_clientLoginHandler);
			addEventListener(AgentManagerEvent.CLIENT_MESSAGE, this_clientMessageHandler);
			addEventListener(AgentManagerEvent.CLIENT_STATUS, this_clientStatusHandler);
			addEventListener(AgentManagerEvent.SYSTEM_ERROR,appManager_systemErrorHandler);
			addEventListener(AgentManagerEvent.LOG_MESSAGE, this_clientLogMessageHandler);
			agentService.messageTypeFilters.push("TEST_MAP_POS_LINK"); // 屏蔽TEST_MAP_POS_LINK类型消息
			agentService.messageTypeFilters.push("SynNonMapObstacleList"); // 屏蔽SYN_NON_MAP_OBSTACLE_LIST类型消息
			
			addEventListener(AgentManagerEvent.FMS_DISCONNECT_UNNORMALEVENT, myFmsDisconnectHandler);
			addEventListener(AgentManagerEvent.FMS_DISCONNECT_NORMAL_EVENT, myFmsReconnectHandler);
			addEventListener(AgentManagerEvent.FMS_CONNECT_EVENT, myFmsReconnectHandler);
			addEventListener(AgentManagerEvent.FMS_RECONNECT_EVENT, myFmsReconnectHandler);
		}
		
		protected function appManager_systemErrorHandler(event:AgentManagerEvent):void
		{
			if(isService && servicetTime!=0 && event.descript == "账号在其他地方登录"){
				isService=false;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:AppRCManager;
		
		public static function getInstance():AppRCManager
		{
			if (!instance) instance = new AppRCManager();
			
			return instance;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  properties
		//
		//--------------------------------------------------------------------------
		
		
		/**c1版本号*/
		public var c1VersionNumber : String;
		
		private var servicetTime:Number;
		
		/** 当前是否处于等待Z端FMS重连状态 **/
		public var waitFmsReConnect:Boolean = false;
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		private var curApplication:Application;
		
		public function init(application:Application):void
		{
			curApplication = application;
		}
		
		override protected function log(...args):void
		{
			AppManager.getInstance().log(args);
		}
		
		protected function this_clientMessageHandler(e:AgentManagerEvent):void
		{
			/*if(AppRCManager.getInstance().logout)
			{
			//已经注销的情况下不处理
			return;
			}*/
			var message:Message = e.message;
			//			trace("收到C1端的报文   ___ ",message.messageType);
			
			switch (message.messageType)
			{
				/*case "c1VersionResponse": // C1版本号回复
				{
				trace("收到C1端的报文了：c1VersionResponse:",message.messageContent);
				break;
				}	*/
				case "openRobotVideoStreamSuc": // 坐席控制打开终端视频流成功，获取当前终端的流信息
				{
					var evt1 : AppRCManagerEvent = new AppRCManagerEvent("openRobotVideoStreamSuc");
					evt1.DataObj = message.messageContent;
					AppRCManager.getInstance().dispatchEvent(evt1);
					break;
				}
				case "openRobotVideoStreamFail":
				{
					Alert.show("C1摄像头推流失败");
				}
				case "openRobotDesktopVideoSuc": // 坐席控制打开终端桌面流成功，获取当前终端的流信息
				{
					trace("桌面流信息");
					var evt2 : AppRCManagerEvent = new AppRCManagerEvent("openRobotDeskTopStreamSuc");
					evt2.DataObj = message.messageContent;
					AppRCManager.getInstance().dispatchEvent(evt2);
					break;
				}
				case "openRobotDesktopVideoFail":
				{
					Alert.show("C1打开桌面流失败");
					break;
				}
				case "talkInfoReport":{  ///获取到 机器人、学生对话信息推送
					var event : AppRCManagerEvent = new AppRCManagerEvent("talkInfoReport");
					event.DataObj = message.messageContent;
					AppRCManager.getInstance().dispatchEvent(event);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		
		protected function this_clientLoginHandler(event:AgentManagerEvent):void
		{
			//			refreshRCList();
		}
		
		protected function this_clientStatusHandler(event:AgentManagerEvent):void
		{
			// 终端状态发生改变, 同步状态，然后派发终端列表已改变事件
			
			// 终端下线 如果在监控窗口上 从监控窗口移除
			
			// 终端下线 设置为无需协助状态
			
			AppManager.getInstance().log("派发事件：刷新终端列表状态！RC_LIST_CHAGNED");
			dispatchEvent(new AppRCManagerEvent(AppRCManagerEvent.RC_LIST_CHAGNED));
		}
		
		
		private var _userName:String = "";
		public function get userName():String
		{
			return _userName;
		}
		public function set userName(value:String):void
		{
			_userName = value;
		}
		//--------------------------------------------------------------------------
		//
		//  终端控制状态失效
		//
		//--------------------------------------------------------------------------
		
		private var invalidateRobotControlStatusFlag:Boolean = false; // 终端控制状态失效
		
		public function invalidateRobotControlStatus():void
		{
			if (!invalidateRobotControlStatusFlag)
			{
				invalidateRobotControlStatusFlag = true;
				curApplication.callLater(validateRobotControlStatus).descript = "validateRobotControlStatus()";
			}
		}
		
		/**
		 * call commitStatus now
		 */
		private function validateRobotControlStatus():void
		{
			if (invalidateRobotControlStatusFlag)
			{
				invalidateRobotControlStatusFlag = false;
				commitRobotControlStatus();
			}
		}
		
		private function commitRobotControlStatus():void
		{
			dispatchEvent(new AppRCManagerEvent(AppRCManagerEvent.RC_STATUS_CHANGED));
		}
		
		
		public var rcMenuViewShow:Boolean=false;
		public var enterMonitor:Boolean=false;
		public var leaveMonitor:Boolean=false;
		
		private var checkTime:Number;  // 存储服务开始时间，判断是否发送服务KPI
		private var isService:Boolean=false;  
		private var isFristIn:Boolean=false;
		private var isRequest:Boolean=false;
		public var isPeopleMode:Boolean=false;
		
		public var remotePeopleModel:Boolean=true;
		
		/**是否正在推流*/
		public var isPublishing : Boolean = false; ///是否正在推流
		/**是否正在拉流*/
		public var isSubscribing : Boolean = false; ///是否正在拉流
		
		// 当前控制终端的区域ID
		public var currentRCOrgId:String;
		
		/**
		 *是否注销 
		 */
		public var logout : Boolean = false;
		
//		public var testRobotID : String = "T0000039";
		
		/**
		 *当前正在桌面拉流的唯一终端号
		 */
		public var nowClientID : String = "";
		
		/**
		 *当前从控制区移除的终端号
		 */
		public var removeClientID : String = "";
		
		/**
		 *当前坐席账号 
		 */
		public var userID : String;
		
		/**
		 *当前坐席密码 
		 */
		public var userPassword : String;
		
		/**
		 * 教师端推流的流名
		 */
		public var teacherStreamName : String = null;
		
		/**
		 * 记录core核心库内日志
		 */
		protected function this_clientLogMessageHandler(event:AgentManagerEvent):void
		{
			AppManager.getInstance().log(event.descript);
		}
		
		
		//-----------------------------------
		//
		//	fms连接异常处理
		//
		//--------------------------------------
		private function myFmsDisconnectHandler(event:AgentManagerEvent=null):void
		{
			waitFmsReConnect = true;
			AppManager.getInstance().log("[AppRCManager] Z端的FMS服务异常掉线，开始尝试重连！");
		}
		
		private function myFmsReconnectHandler(event:AgentManagerEvent):void
		{
			waitFmsReConnect = false;
			AppManager.getInstance().log("[AppRCManager] Z端的FMS服务恢复/断开，不再重连！");
		}
		
		/**
		 * c1端fms异常掉线处理
		 * ps：C1端与FMS之间的生命周期：坐席打开该终端的C1摄像头开始监控 --- > 坐席移除监控 ，故当收到c1端fms异常掉线时候，必定已经处于坐席的监控下)
		 */
		private function c1FmsServiceDisconnectHandler(termID:String):void
		{
		}
		
		/**
		 * c1端fms异常掉线恢复处理
		 */
		private function c1FmsServiceReconnectHandler(termID:String):void
		{
		}
		
	}
}