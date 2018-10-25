package com.goshare.manager
{
	import com.goshare.components.Loading;
	import com.goshare.data.ClientType;
	import com.goshare.data.Message;
	import com.goshare.data.MessageType;
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.service.AppService;
	import com.goshare.view.home.LogView;
	
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import coco.core.Application;
	import coco.manager.PopUpManager;
	
	[Event(name="volumeStrengthStart", type="com.goshare.event.AppManagerEvent")]
	
	[Event(name="volumeStrengthChange", type="com.goshare.event.AppManagerEvent")]
	
	[Event(name="volumeStrengthStop", type="com.goshare.event.AppManagerEvent")]
	
	/**
	 *
	 * 程序管理器
	 *
	 */
	public class AppManager extends EventDispatcher
	{
		public function AppManager(target:IEventDispatcher = null)
		{
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:AppManager;
		
		public static function getInstance():AppManager
		{
			if (!instance)
				instance = new AppManager();
			
			return instance;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		public function get clienttype():String
		{
			return getShareObjectValue("clienttype");
		}
		
		public function set clienttype(value:String):void
		{
			setShareObjectValue("clienttype", value);
		}
		
		public function get username():String
		{
			if (clienttype == ClientType.ROBOT)
			{
				if(AppRCManager.getInstance().userName == "")
				{
					AppRCManager.getInstance().userName = getShareObjectValue("robotusername");
				}
				return AppRCManager.getInstance().userName;
				//				return getShareObjectValue("robotusername");
			}
			else
			{
				if(AppRCManager.getInstance().userName == "")
				{
					AppRCManager.getInstance().userName = getShareObjectValue("termusername");
				}
				return AppRCManager.getInstance().userName;
				//				return getShareObjectValue("termusername");
			}
		}
		
		public function set username(value:String):void
		{
			if (clienttype == ClientType.ROBOT)
				setShareObjectValue("robotusername", value);
			else
				setShareObjectValue("termusername", value);
		}
		
		public function get password():String
		{
			if (clienttype == ClientType.ROBOT)
				return getShareObjectValue("robotpassword");
			else
				return getShareObjectValue("termpassword");
		}
		
		public function set password(value:String):void
		{
			if (clienttype == ClientType.ROBOT)
				setShareObjectValue("robotpassword", value);
			else
				setShareObjectValue("termpassword", value);
		}
		
		public function get version():String
		{
			return getShareObjectValue("version");
		}
		
		public function set version(value:String):void
		{
			setShareObjectValue("version", value);
		}
		
		public var autoLogin:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		private var curApplication:Application;
		
		public function init(application:Application):void
		{
			curApplication = application;
			
			initJsCallback();
			initRightMenu();
			
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGIN,
				this_loginInHandler);
		}
		
		/**
		 * 初始化服务器
		 */
		public function initServer():void
		{
			// 终端服务器
			AppRCManager.getInstance().minaServerHost = AppAssetsManager.getInstance().configXml.minaserver1.@host;
			AppRCManager.getInstance().minaServerPort = AppAssetsManager.getInstance().configXml.minaserver1.@port;
			AppRCManager.getInstance().policyServerHost = AppAssetsManager.getInstance().configXml.policyserver1.@host;
			AppRCManager.getInstance().policyServerPort = AppAssetsManager.getInstance().configXml.policyserver1.@port;
			AppRCManager.getInstance().fmsServerUrl = AppAssetsManager.getInstance().configXml.fmsserver1.@url;
			AppService.getInstance().httpServerUrl = AppAssetsManager.getInstance().configXml.httpserver1.@url;
		}
		
		//--------------------------------------------------------------------------
		//
		//  LOADING VIEW 
		//
		//--------------------------------------------------------------------------
		
		private var _loading:Loading;
		
		public function get loading():Loading
		{
			if (!_loading)
				_loading = new Loading();
			
			return _loading;
		}
		
		public function showLoading(value:Number):void
		{
			if (!loading.isPopUp)
				PopUpManager.centerPopUp(PopUpManager.addPopUp(loading, null, true));
			
			loading.value = value;
		}
		
		public function hideLoading():void
		{
			if (loading.isPopUp)
				PopUpManager.removePopUp(loading);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Right Menu
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 程序版本号
		 */
		public const APP_VERSION:String = "V1.3.37.0 (20180412)";
		
		//❶❷❸❹❺🀁
		/*public const APP_VERSION_DESCRIPT:String = "🀇 修改 版本回归至大版本号:1.3.*" +
		"\r🀈 增加 快速检索功能" +
		"\r🀉 修复 远程桌面状态不正确问题" +
		"\r🀊 优化 监控界面跟操控界面视频的旋转角度同步" +
		"\r🀋 修复 机器人当前位置在地图上显示不正确问题" +
		"\r🀌 优化 屏蔽默写指定类型的包日志";
		*/
		
		/*public const APP_VERSION_DESCRIPT:String = "🀇 增加 快速检索内容使用NLP消息类型转发";*/
		
		//		public const APP_VERSION_DESCRIPT:String = 
		//			"┏┯┓┏┯┓┏┯┓┏┯┓┏┯┓┏┯┓ \r" +
		//			"┠上┨┠海┨┠棠┨┠棣┨┠科┨┠技┨ \r" +
		//			"┗┷┛┗┷┛┗┷┛┗┷┛┗┷┛┗┷┛ \r\r" +
		//			"1 更新委托策略\r" +
		//			"2 通知支持自动关闭\r\r";
		
		public const APP_VERSION_DESCRIPT:String = 
			"版本详细信息见：http://jqrcs.tangdi.net:9001/testWeb/Z0001.do\r";
		
		private var joinMonit:ContextMenuItem;
		
		private function initRightMenu():void
		{
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			//		***********************************************************************	
			//			joinMonit = new ContextMenuItem("加入监控");
			//			joinMonit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, joinMonit_selectHandler);
			//			cm.customItems.push(joinMonit);
			
			var copyLogItem:ContextMenuItem = new ContextMenuItem("拷贝坐席日志");
			copyLogItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyLogItem_selectHandler);
			cm.customItems.push(copyLogItem);
			
			// copy log
			var versionItem:ContextMenuItem = new ContextMenuItem("坐席版本："+AppManager.getInstance().APP_VERSION, true);
			versionItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, versionItem_selectHandler);
			cm.customItems.push(versionItem);
			
			curApplication.contextMenu = cm;
		}
		
		protected function joinMonit_selectHandler(event:ContextMenuEvent):void
		{
			if (joinMonit.caption == "加入监控")
			{
				//				AppRCManager.getInstance().addRCM(AppRCManager.getInstance().currentRC);  // 加入监控
				trace("执行了joinMonit_selectHandler");
			}
			else{
				//				AppRCManager.getInstance().removeRCM(AppRCManager.getInstance().currentRC); // 退出监控
			}
		}
		
		protected function copyLogItem_selectHandler(event:ContextMenuEvent):void
		{
			copyLogs();
		}
		
		protected function versionItem_selectHandler(event:ContextMenuEvent):void
		{
			if (AppAssetsManager.getInstance().getConfig("showDeveloperMenu")){
				//				AdminMenuView.getInstance().open();
			}
		}
		
		/**
		 * 复制日志
		 */
		public function copyLogs():void
		{
			LogView.getInstance().open(logs.join("\r"));
		}
		
		
		private function initJsCallback():void
		{
			//注册定时回调
			try
			{
				ExternalInterface.addCallback("invokeFlexOnTimer", js2FlexOnTimerHandler);
				ExternalInterface.call("invokeJsTimerStart");
				AppManager.getInstance().log("[防睡眠机制] 注册定时回调防睡眠成功");
			}
			catch (error:Error)
			{
				AppManager.getInstance().log("[防睡眠机制] 注册定时回调防睡眠失败 " + error.message);
			}
			
			// 注册释放回调
			try
			{
				ExternalInterface.addCallback("invokeFlexDispose", js2FlexDisposeHandler);
				AppManager.getInstance().log("[释放机制] 注册释放回调");
			}
			catch (error:Error)
			{
				AppManager.getInstance().log("[释放机制] 注册释放回调 " + error.message);
			}
		}
		
		private function js2FlexOnTimerHandler():void
		{
			//			log("[防睡眠机制] 防睡眠触发");
		}
		
		private function js2FlexDisposeHandler():void
		{
			log("[释放机制] 释放触发");
			
			//EntrustWork释放
			//			EntrustWorker.getInstance().dispose();
			
			// OCX释放
			//			AppOcxManager.getInstance().dispose();
			
			// 注销账号
			var sendMessage:Message = new Message();
			sendMessage.messageType = MessageType.Z005;
			sendMessage.messageContent = "客服注销";
			AppRCManager.getInstance().sendMessage(sendMessage);
		}
		
		/**
		 * 如果是第一次打开程序版本，则提示版本更新说明
		 */
		public function showVersionDescript():void
		{
			if (version != APP_VERSION)
			{
				version = APP_VERSION;
				//				AlertForApp.show(APP_VERSION_DESCRIPT, APP_VERSION + " 版本更新说明").textAlign = TextAlign.LEFT;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  LOG 
		//
		//--------------------------------------------------------------------------
		
		private var logs:Vector.<String> = new Vector.<String>();
		
		public function log(...args):void
		{
			var arg:Array = args as Array;
			if (arg.length == 1)
			{
				//只有一个参数的情况下，日志在浏览器和本地都写入
				writeLogInTxt(arg);
				writeLogInBrowser(arg);
			}else if (arg.length > 1)
			{
				//附带第二个参数时:
				//0:只写到浏览器中
				//1:只写到本地txt中
				//2:浏览器和本地都写入
				var writeFlg:String = String(arg[1]);
				if(arg[1] == "0")
				{
					writeLogInBrowser(arg);
				}else if(arg[1] == "1")
				{
					writeLogInTxt(arg);
				}else
				{
					writeLogInTxt(arg);
					writeLogInBrowser(arg);
				}
			}
			
			//			if (arg.length > 0)
			//			{
			//				//写入本地txt文件
			//				//此处加上 账号名 是为了区分坐席同时开两个页面登录两个账号的情况
			//				var logStr : String ;
			//				if(AppRCManager.getInstance().userName)
			//				{
			//					logStr = "[人工坐席] " + new Date().toLocaleString() + " [坐席号：]" + AppRCManager.getInstance().userName + " " + arg[0];
			//				}else
			//				{
			//					logStr = "[人工坐席] " + new Date().toLocaleString() + " " + arg[0];
			//				}
			//				//在此处调用js..js调用ocx方法，将单条log（数组）append进txt文本中
			//				AppOcxManager.getInstance().localLogTxtAppend(logStr);
			//				
			//				arg[0] = "[人工坐席] " + new Date().toLocaleString() + " " + arg[0];
			//			}
			//			trace(arg);
			//			logs.push(arg.join(" "));
			//			
			//			// 只保留最多100条记录 
			//			if (logs.length > 100)
			//				logs.shift();
		}
		
		private function writeLogInBrowser(arg:Array):void
		{
			arg[0] = "[人工坐席] " + new Date().toLocaleString() + " " + arg[0];
			logs.push(arg.join(" "));
			// 只保留最多100条记录 
			if (logs.length > 100)
				logs.shift();
		}
		
		private function writeLogInTxt(arg:Array):void
		{
			var logStr : String ;
			if(AppRCManager.getInstance().userName)
			{
				try
				{
					logStr = "[人工坐席] " + new Date().toLocaleString() + " [坐席号：" + AppRCManager.getInstance().userName +"] "+
						"[终端号：" + "] " + arg[0];
				} 
				catch(error:Error) 
				{
					logStr = "[人工坐席] " + new Date().toLocaleString() + " [坐席号：" + AppRCManager.getInstance().userName + "] " + arg[0];
				}
				
			}else
			{
				logStr = "[人工坐席] " + new Date().toLocaleString() + " " + arg[0];
			}
			//在此处调用js..js调用ocx方法，将单条log（数组）append进txt文本中
			//			AppOcxManager.getInstance().localLogTxtAppend(logStr);
		}
		
		public function logClear():void
		{
			logs.splice(0, logs.length);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  SharedObject Value
		//
		//--------------------------------------------------------------------------
		public function setShareObjectValue(key:String, value:String):void
		{
			SharedObject.getLocal("robotclient").data[key] = value;
			SharedObject.getLocal("robotclient").flush();
		}
		
		public function getShareObjectValue(key:String):String
		{
			if (SharedObject.getLocal("robotclient").data[key] != undefined)
				return SharedObject.getLocal("robotclient").data[key];
			else
				return null;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  获取敏感词 获取敏感词 获取敏感词 获取敏感词 获取敏感词
		//
		//--------------------------------------------------------------------------
		
		public var sensitiveWords:String = "";
		
		protected function this_loginInHandler(event:AgentManagerEvent):void
		{
			// 登录成功获取脏词
			AppService.getInstance().getClientSensitiveWords(getClientSensitiveWordsResultHandler,
				getClientSensitiveWordsFaultHandler);
		}
		
		private function getClientSensitiveWordsResultHandler(e:Event):void
		{
			try
			{
				sensitiveWords = JSON.parse(e.currentTarget.data).sensitiveWord;
			}
			catch (error:Error)
			{
				sensitiveWords = "";
			}
		}
		
		private function getClientSensitiveWordsFaultHandler(e:Event):void
		{
			sensitiveWords = "";
		}
		
	}
	
}