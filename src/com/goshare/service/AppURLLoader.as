package com.goshare.service
{
	import com.goshare.manager.AppManager;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import coco.net.URLLoaderWithTimeout;
	
	public class AppURLLoader extends URLLoaderWithTimeout
	{
		private var resultCallback:Function;
		private var faultCallback:Function;
		
		public function AppURLLoader(resultHandler:Function, faultHandler:Function, useQueue:Boolean=false, timeout:Number=-1)
		{
			super(timeout);
			addEventListener(Event.COMPLETE, loadCompleteHandler);
			addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			resultCallback = resultHandler;
			faultCallback = faultHandler;
		}
		
		protected function errorHandler(event:Event):void
		{
//			AppManager.getInstance().log('[AppService]: ERROR');
			if (faultCallback != null && !isReleased)
				faultCallback.call(null, event);
		}
		
		protected function loadCompleteHandler(event:Event):void
		{
			// 记录下交易日志
			try{
				if(event.hasOwnProperty("currentTarget")  && event.currentTarget["data"]){
					var tradeInfo:String = event.currentTarget.data as String;
					if(tradeInfo && tradeInfo.length>1000){
						tradeInfo = tradeInfo.substr(0, 1000);
					}
//					AppManager.getInstance().log('[AppService]: SUCCESS -- info -- ' + tradeInfo, 1);
				}
			}catch(e:Error){
//				AppManager.getInstance().log('[AppService]: SUCCESS');
			}
			
			if (resultCallback != null && !isReleased)
				resultCallback.call(null, event);
		}
		
		private var isReleased:Boolean = false;
		
		override public function load(request:URLRequest):void
		{
//			AppManager.getInstance().log('[AppService]: ' + request.url + "?" + JSON.stringify(request.data));
			super.load(request);
		}
		
		public function release():void
		{
			isReleased = true;
		}
		
	}
}