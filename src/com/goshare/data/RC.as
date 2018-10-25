package com.goshare.data
{
	import flash.net.NetStream;
	
	/**
	 *
	 * 终端客户端数据
	 *  
	 * @author coco
	 * 
	 */	
	public class RC
	{
		
		public function RC()
		{
		}
		
		// ----------------------------------------------
		// 该客户端基本信息
		// ----------------------------------------------
		public var id:String; // 客户端id  - termID
		public var version:String; // 客户端版本号
		public var online:Boolean; // 客户端是否在线
		
		// ----------------------------------------------
		// 该客户端委托信息
		// ----------------------------------------------
		/** 客户端是否是委托状态 **/
		public var entrusted:Boolean;
		/** 客户端是被委托状态 **/
		public var beenEntrusted:Boolean;
		/** 委托流水号 **/
		public var serialNo:String;
		
		// ----------------------------------------------
		// 该客户端fms连接信息
		// ----------------------------------------------
		/** fms服务是否正常 **/
		public var fmsServiceIsOK:Boolean = true;
		
		/** 监控视频流名称 **/
		public var monitorVideoStreamName:String = "";
		/** 监控视频流对象 **/
		public var monitorVideoStream:NetStream = null;
		/** 监控视频的旋转角度 **/
		public var monitorVideoAngle:Number = 0;
		
		/** 控制视频流名称 (远程桌面用) **/
		public var controlVideoStreamName:String = "";
		/** 控制视频流对象 (远程桌面用) **/
		public var controlVideoStream:NetStream = null;
		/** 控制视频的旋转角度 **/
		public var controlVideoAngle:Number = 0;
		
		
		// --------------- 坐席休息模式相关变量 start ----------------------
		/** 当前是否为休息状态 **/
		public static var isRestModel:Boolean=false;
		/** 休息时间 **/
		public  static var restTime:String;
		/** 休息期间动态提示信息 **/
		public static var promptText:String;
		// --------------- 坐席休息模式相关变量 end ----------------------
		
		
		
		// ----------------- 以下相关信息 暂未找到用于何处，待定 --------------------
		
		
		// ---------------------- 该客户端needhelp相关参数 start ------------------------
		private var _needHelp:Boolean; // 客户端是否需要帮助
		private var requestCount:int = 0;
		private var onlineLevel:int = 10000; //在线level等级数
		private var offlineLevel:int = 100000;  //离线level等级数
		
		public function get needHelp():Boolean
		{
			return _needHelp;
		}
		
		public function set needHelp(value:Boolean):void
		{
			_needHelp = value;
			
			if (_needHelp)
			{
				//如果请求一次  则请求计数自增一次
				requestCount++;
			}
		}
		
		/**
		 * 如果发出请求则返回 autoFill(10000 - requestCount) 函数所得到的值
		 * 如果发出请求用在线的等级数（level）去减请求的次数
		 * 这样得到的请求的等级数就会小于在线的等级数  那么根据sortOn排序
		 * 请求的就会排在在线的前面
		 */
		public function get level():String
		{
			if (needHelp){
				return autoFill(10000 - requestCount);
			}else if(online){
				return autoFill(onlineLevel);
			}else{
				return autoFill(offlineLevel);
			}
		}
		
		/**
		 * 自动补全字符(补足10位，不足则在左边补0)
		 * 因为sortOn的排序是根据首字符的编码排序的所以必须在得到的等级数前面补上一定数量的0  让所有的level都位数相等
		 */
		private function autoFill(num:int):String
		{
			var item:String = num.toString();
			while (item.length < 10)
			{
				item = "0" + item;
			}
			return item;
		}
		// ---------------------- 该客户端needhelp相关记录 end ------------------------
		
		// -------------------- 购物功能相关参数 start ---------------------
		public var needSmartShoppingHelp:Boolean; // 客户端是否需要购物人工客服模式(即单向语音通道)帮助
		public var needSmartServiceHelp:Boolean; // 客户端是否需要普通人工客服模式(即双向语音通道)帮助
		
		// -------------------- 购物功能相关参数 end ---------------------
	}
}