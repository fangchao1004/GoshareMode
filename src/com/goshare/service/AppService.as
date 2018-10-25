package com.goshare.service
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import coco.net.URLLoaderWithTimeout;
	
	/**
	 * 自助服务接口
	 *
	 * @author Coco
	 */
	public class AppService
	{
		public function AppService()
		{
		}
		
		private static var instance:AppService;
		
		public static function getInstance():AppService
		{
			if (!instance)
			{
				instance = new AppService();
			}
			
			return instance;
		}
		
		public var httpServerUrl:String;
		
		/**
		 *
		 * 获取终端信息
		 *
		 * @param termId 终端ID
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getRobotInfoData(termId:String,
										 resultHandler:Function = null,
										 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/ACI0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 *
		 * 获取终端菜单信息
		 *
		 * @param termId 终端ID
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getRobotMenuData(termId:String,
										 parMenu:String = null,
										 subMenu:String = null,
										 resultHandler:Function = null,
										 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AMI0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			if (parMenu)
			{
				reqMsg.parMenu = parMenu;
			}
			if (subMenu)
			{
				reqMsg.subMenu = subMenu;
			}
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 *
		 * 获取坐席端的表情列表数据
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getClientFaces(username:String,
									   resultHandler:Function = null,
									   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AEI0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = username;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 *
		 * 获取坐席端的常用语
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getClientPhraseBook(username:String,
											resultHandler:Function = null,
											faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/ALI0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = username;
			reqMsg.messageType = "";
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
			
//			var request:URLRequest=new URLRequest();
//			request.url="http://115.28.189.99/tb/query.php";
//			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
//			urlLoader.load(request);
		}
		
		/**
		 *
		 * 获取坐席端的笑话库
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getClientJokeBank(username:String,
											resultHandler:Function = null,
											faultHandler:Function = null):void
		{
			var request:URLRequest=new URLRequest();
			request.url="http://192.168.1.2:8097/gsassist/joke0001.do";
//			trace("请求了笑话url地址 "+count.toString()+"次；");
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(request);
		}
		
		
		/**
		 *
		 * 告诉后台刷新笑话库
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function refreshJokeBank(username:String,
									   resultHandler:Function = null,
									   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl+"/gsassist/joke0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = username;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = "refreshJokeBank";
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 *
		 * 告诉后台新的账号和密码数据
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		/*public function changePassWord(username:String,
									   messages:String,
										resultHandler:Function = null,
										faultHandler:Function = null):void
		{
          ///var url:String = "http://192.168.1.2:8097/gsassist/ASI0001.do";
			var url:String = "http://192.168.1.2:8097/haha.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = username;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = messages;
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}*/
		
		/**
		 *
		 * 获取坐席端的控制指令
		 *
		 * @param username 坐席用户名
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getClientControlCommand(username:String,
												resultHandler:Function = null,
												faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/ALI0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = username;
			reqMsg.messageType = "robotMove";
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 *
		 * 获取坐席端需要过滤的敏感词
		 *
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function getClientSensitiveWords(resultHandler:Function = null,
												faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/ASW0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		//-----------------------------------------------------------------------------------------------
		//  2016-11-01 增加委托机制接口 
		//-----------------------------------------------------------------------------------------------
		
		/**
		 * 获取同组其他坐席
		 * @param userName 用户名
		 * @param queryType 查询类型 00 在线 01 在线
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getOtherSeatsInGroup(userName:String,
											 queryType:String,
											 resultHandler:Function = null,
											 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/ASI0002.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.queryType = queryType;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 申请委托
		 * @param userName  委托者
		 * @param mandatary 被委托者
		 * @param termList 委托的终端列表
		 * @param entrustDesc 委托描述
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function requestEntrust(userName:String,
									   mandatary:String,
									   termList:Array,
									   entrustDesc:String = "",
									   resultHandler:Function = null,
									   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0002.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.mandatary = mandatary;
			reqMsg.termList = termList;
			reqMsg.entrustDesc = entrustDesc;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 接受委托
		 * @param userName
		 * @param serialNo
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function acceptEntrust(userName:String,
									  serialNo:String,
									  resultHandler:Function = null,
									  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0003.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.serialNo = serialNo;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 拒绝委托
		 * @param userName
		 * @param serialNo
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function rejectEntrust(userName:String,
									  serialNo:String,
									  resultHandler:Function = null,
									  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0004.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.serialNo = serialNo;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 取消委托
		 * @param userName
		 * @param serialNo
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function cancelEntrust(userName:String,
									  serialNo:String,
									  resultHandler:Function = null,
									  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0007.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.serialNo = serialNo;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 * 同意取消委托
		 * @param userName
		 * @param serialNo
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function agreeCancelEntrust(userName:String,
										   serialNo:String,
										   resultHandler:Function = null,
										   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0006.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.serialNo = serialNo;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 拒绝取消委托
		 * @param userName
		 * @param serialNo
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function rejectCancelEntrust(userName:String,
											serialNo:String,
											resultHandler:Function = null,
											faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0008.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.serialNo = serialNo;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 查询有效委托
		 * @param userName
		 * @param queryType
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function queryEntrust(userName:String,
									 queryType:String,
									 resultHandler:Function = null,
									 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AWI0005.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.queryType = queryType;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 获取终端的视频信息
		 * @param termId 终端id
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getRobotVideoList(termId:String,
										  resultHandler:Function = null,
										  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/AMK0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		*  获取远程行走的点信息
		**/
		public function getWalkPointListInfo(termId:String,
											 resultHandler:Function = null,
											 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/PIT0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler);
			urlLoader.load(urlrequest);
		}
		
		/**
		 *  获取历史记录
		 **/
		public function getHistoryInfo(termId:String,
									   resultHandler:Function = null,
									   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl+"/gsassist/record0002.do";
			
			
			var params:URLVariables = new URLVariables();
			params.termId = termId;
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler);
			urlLoader.load(urlrequest);
		}
		
		/**
		*  获取地图
		*/
		public function getMapInfo(termId:String,
								   resultHandler:Function = null,
								   faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/MAP0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 搜索关键字
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function searchKey(userName:String,
								  termId:String,
								  orgId:String,
								  keyword:String,
								  resultHandler:Function = null,
								  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/IKN0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.orgId = orgId;
			reqMsg.userName = userName;
			reqMsg.searchMsg = keyword;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 搜索场景
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function searchScene(userName:String,
									termId:String,
									orgId:String,
									keyid:String,
									resultHandler:Function = null,
									faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/IKN0002.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.orgId = orgId;
			reqMsg.userName = userName;
			reqMsg.serialNo = keyid;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 * 添加知识库
		 * @param resultHandler
		 * @param faultHandler
		 *
		 */
		public function addKnowledgeInfo(userName:String,
								  termId:String,
								  orgId:String,
								  problem:String,
								  answer:String,
								  resultHandler:Function = null,
								  faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/IKN0003.do";
			
			var reqMsg:Object = new Object();
			reqMsg.termId = termId;
			reqMsg.orgId = orgId;
			reqMsg.userName = userName;
			reqMsg.statements = problem;
			reqMsg.speakContent = answer;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		public function restTimeAndCount(type:String, time:String, ZXId:String,resultHandler:Function=null,faultHandler:Function=null):void
		{
			var url:String = httpServerUrl + "/gsassist/REST0001.do";
//			var url:String = "http://192.168.3.11:8080/gsassist/REST0001.do";	 //本地测试用
			var reqMsg:Object = new Object();
			reqMsg.messageType = type;
			reqMsg.memberId = ZXId;
			reqMsg.restTime = time;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		/**
		 * 呼叫请求转移
		 * @param termId 正在服务的终端
		 * @param userName  转移呼叫请求的坐席
		 * @param workStatus 工作繁忙状态  00 空闲， 01 繁忙
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function transferEntrust(userName:String,
										termId:String,
										workStatus:String,
										resultHandler:Function = null,
										faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/TRF0001.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.termId = termId;
			reqMsg.workStatus = workStatus;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		
		/**
		 * 呼叫请求回收
		 * @param userName  呼叫请求回收的坐席
		 * @param workStatus 工作繁忙状态  00 空闲， 01 繁忙
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function recyclingEntrust(userName:String,
										 workStatus:String,
										 resultHandler:Function = null,
										 faultHandler:Function = null):void
		{
			var url:String = httpServerUrl + "/gsassist/TRF0002.do";
			
			var reqMsg:Object = new Object();
			reqMsg.userName = userName;
			reqMsg.workStatus = workStatus;
			reqMsg.flowNo =  (new Date()).getTime() + "" + int(Math.random() * 1000);
			
			var params:URLVariables = new URLVariables();
			params.REQ_MESSAGE = JSON.stringify(reqMsg);
			
			var urlrequest:URLRequest = new URLRequest(url);
			urlrequest.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = params;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 * 坐席kpi考核接口*
		 *@param data:String 要发到服务器的数据
		 * */
		public function serviceMessageSend(data:String):void
		{
			/*if(RC.isRestModel)
			{
				trace("[AppService]   当前为休息状态,坐席kpi考核数据不发送");
				return;
			}*/
			trace("[AppService]   坐席kpi考核数据开始发送");
			try
			{
				var urlRequest:URLRequest= new URLRequest();
				urlRequest.url=httpServerUrl+"/gsassist/count0001.do"; //服务器接口地址(先用本地环境测试)
				var variables:URLVariables = new URLVariables(data);//传过去的data
				urlRequest.data=variables;//绑定数据
				urlRequest.method = URLRequestMethod.POST;
				var loader:URLLoaderWithTimeout = new URLLoaderWithTimeout();
				loader.addEventListener(Event.COMPLETE,function(e:Event):void{
					trace("[AppService]   坐席kpi考核数据发送成功");
				});
				loader.addEventListener(IOErrorEvent.IO_ERROR,function(e:Event):void{
					trace("[AppService]   坐席kpi考核数据发送失败");
				});
				loader.load(urlRequest);//发送数据
			} 
			catch(error:Error) 
			{
				trace("[AppService]   坐席kpi考核数据发送出现错误");
			}
		}
		/**
		 * 将时间戳变为201709010909的形式*
		 *@param date:Date 要改变的时间戳
		 * */
		public function dateHandel(date:Date):Number
		{
			var time:Number;
			var month:String;
			var hours:String;
			var data:String;
			var minutes:String;
			var seconds:String;
			if(date.month+1<10){
				month="0"+String(date.month+1);
			}else{
				month=String(date.month+1);
			}
			
			if(date.date<10){
				data="0"+String(date.date);
			}else{
				data=String(date.date);
			}
			if(date.hours<10){
				hours="0"+String(date.hours);
			}else{
				hours=String(date.hours);
			}
			if(date.minutes<10){
				minutes="0"+String(date.minutes);
			}else{
				minutes=String(date.minutes);
			}
			if(date.seconds<10){
				seconds="0"+String(date.seconds);
			}else{
				seconds=String(date.seconds);
			}
			time=Number(String(date.fullYear)+month+data+hours+minutes+seconds);
			return time;
		}
		
		/**
		 * 发送历史记录
		 *@param date:String 要发送的数据
		 * */
		public function historyMessageSend(data:String):void
		{
			try
			{
				var urlRequest:URLRequest= new URLRequest();
				urlRequest.url=httpServerUrl+"/gsassist/record0001.do"; //服务器接口地址(先用本地环境测试)
				var variables:URLVariables = new URLVariables(data);//传过去的data
				urlRequest.data=variables;//绑定数据
				urlRequest.method = URLRequestMethod.POST;
				trace(JSON.stringify(variables))
				var loader:URLLoaderWithTimeout = new URLLoaderWithTimeout();
				loader.addEventListener(Event.COMPLETE,function(e:Event):void{
					trace("[AppService]   历史记录数据发送成功");
				});
				loader.addEventListener(IOErrorEvent.IO_ERROR,function(e:Event):void{
					trace("[AppService]   历史记录数据发送失败");
				});
				loader.load(urlRequest);//发送数据
			} 
			catch(error:Error) 
			{
				trace("[AppService]   历史记录数据发送出现错误");
			}
		}
		
		/**
		 * 发送录屏文件列表（当天的录屏文件）
		 *@param date:String 要发送的数据
		 * */
		public function sendVideoList(data:Object):void
		{
			try
			{
				var urlRequest:URLRequest= new URLRequest();
				urlRequest.url=httpServerUrl+"/gsassist/AVI0001.do"; //服务器接口地址(先用本地环境测试)
				var variables:URLVariables = new URLVariables();//传过去的data
				variables.REQ_MESSAGE=JSON.stringify(data);
				urlRequest.data=variables;//绑定数据
				urlRequest.method = URLRequestMethod.POST;
				trace(JSON.stringify(variables));
				var loader:URLLoaderWithTimeout = new URLLoaderWithTimeout();
				loader.addEventListener(Event.COMPLETE,function(e:Event):void{
					trace("[AppService]   录屏文件列表发送成功");
				});
				loader.addEventListener(IOErrorEvent.IO_ERROR,function(e:Event):void{
					trace("[AppService]   录屏文件列表发送失败");
				});
				loader.load(urlRequest);//发送数据
			} 
			catch(error:Error) 
			{
				trace("[AppService]   录屏文件列表发送出现错误");
			}
		}
		
		/**
		 * 发送 半人工坐席的信息给后台 
		 * 智能快速检索  依据C2场景参数，缩小检索范围
		 * @param tdosToken         从tdos端获取的token
		 * @param tdosRobotStateSet     从tdos端获取的场景参数
		 * @param keyword    输入的关键字（标准问？）
		 * @param serialNo     连载号
		 */
		public function SendSEMIZAgentMessage(
											  tdosToken : String,
											  tdosRobotStateSet : Array,
											  keyword:String,
											  serialNo:Number =NaN,
											  resultHandler:Function = null,
											  faultHandler:Function = null):void
		{
			var reauestUrl:String = httpServerUrl+"/gsassist/IKN0004.do";
			
			var reqBody:Object = new Object();
			reqBody.token = tdosToken ; //令牌  注意防止过期  由tdos提供
			reqBody.uniqueCode =  (new Date()).getTime() + "" + int(Math.random() * 1000); //交互唯一码	
			reqBody.supportModel = "000300";  //支持模式码
			reqBody.serialNo = serialNo;  //知识唯一码
			
			var keywordArr:Array = [];
			keywordArr.push(keyword);
			reqBody.questions =  keywordArr;
			
			reqBody.robotStateSet = tdosRobotStateSet;
			
			var dataStr:String = JSON.stringify(reqBody);
			trace("发往tdos终端的数据:"+dataStr);
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.REQ_MESSAGE = dataStr;
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		///获取验证码
		public function getCode(userPhone:String,
									 resultHandler:Function = null,faultHandler:Function = null):void
		{
			var reauestUrl:String = "http://192.168.1.2:3000/mock/12/gsassist/auth/genCaptcha.do";
			
			
			var variables:URLVariables = new URLVariables();
			variables.userPhone = userPhone; ///http请求参数
			
//			trace(variables);
			
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.GET;
			
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}	
		
		
		/**
		 *注册  http
		 * @param userPhone 用户手机号
		 * @param password 密码
		 * @param code 验证码
		 * @param resultHandler 成功回调
		 * @param faultHandler 失败回调
		 */
		public function regsiterTest(userPhone:String,password : String,code:String,
									 resultHandler:Function = null,faultHandler:Function = null):void
		{
			var reauestUrl:String = "http://192.168.1.2:3000/mock/12/gsassist/auth/register.do";
			
			var variables:URLVariables = new URLVariables();
			variables.userPhone = userPhone; ///http请求参数
			variables.userPwd = password; ///http请求参数
			variables.captcha = code;
			
//			trace(variables);
			
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 *上传用户信息 
		 * @param userInfo
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */
		public function putUserInfo(userInfo:Object, resultHandler:Function = null,faultHandler:Function = null):void
		{
			var reauestUrl:String = "http://192.168.1.2:3000/mock/12/gsassist/auth/perfect/info.do";
			
			var variables:URLVariables = new URLVariables();
			variables.message = JSON.stringify(userInfo);
//			trace(variables);
			
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		/**
		 * 修改用户密码
		 * @param data  整体数据 包含userId，oldPwd，newPwd 三个字段
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function resetUserPwd(data:Object, resultHandler:Function = null,faultHandler:Function = null):void
		{
			var reauestUrl:String = "http://192.168.1.2:3000/mock/12/gsassist/auth/resetUserPwd.do";
			
			var variables:URLVariables = new URLVariables();
			variables.userId = data.userId;
			variables.oldPwd = data.oldPwd;
			variables.newPwd = data.newPwd;
//			trace(variables);
			
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.POST;
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
		
		
		/**
		 *淘宝 http 接口测试 
		 * @param phoneNumber
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */
		public function getPhoneTest(phoneNumber:String,
									 resultHandler:Function = null,faultHandler:Function = null):void
		{
			var reauestUrl:String = "http://tcc.taobao.com/cc/json/mobile_tel_segment.htm";
			
			
			var variables:URLVariables = new URLVariables();
			variables.tel = phoneNumber; ///http请求参数
			
			var urlrequest:URLRequest = new URLRequest(reauestUrl);
			urlrequest.method = URLRequestMethod.GET;
			
			urlrequest.data = variables;
			
			var urlLoader:AppURLLoader = new AppURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest);
		}
	}
	
	
}
