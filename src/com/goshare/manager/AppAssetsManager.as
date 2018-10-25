package com.goshare.manager
{
	import coco.core.Application;
	
	import com.goshare.event.AppAssetsManagerEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(name="assetsSuccess", type="com.goshare.event.AppAssetsManagerEvent")]
	
	[Event(name="assetsProgress", type="com.goshare.event.AppAssetsManagerEvent")]
	
	[Event(name="assetsFault", type="com.goshare.event.AppAssetsManagerEvent")]
	
	/**
	 *
	 * 程序资源管理器
	 *
	 * @author coco
	 *
	 */
	public class AppAssetsManager extends EventDispatcher
	{
		public function AppAssetsManager()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:AppAssetsManager;
		
		public static function getInstance():AppAssetsManager
		{
			if (!instance)
				instance = new AppAssetsManager();
			
			return instance;
		}
		
		
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
		
		
		//--------------------------------------------------------------------------
		//
		//  Server Config
		//
		//--------------------------------------------------------------------------
		
		public var configXml:XML;
		public var assetsSwf:Object;
		
		private var _urlLoader:URLLoader;
		
		public function get urlLoader():URLLoader
		{
			if (!_urlLoader)
			{
				_urlLoader = new URLLoader();
				_urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
				_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			}
			
			return _urlLoader;
		}
		
		private var _loader:Loader;
		
		public function get loader():Loader
		{
			if (!_loader)
			{
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
				_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			}
			
			return _loader;
		}
		
		public function loadAssets():void
		{
			urlLoader.load(new URLRequest("assets/serverconfig.xml"));
		}
		
		protected function urlLoader_completeHandler(event:Event):void
		{
			try
			{
				configXml = new XML(event.currentTarget.data);
				loader.load(new URLRequest("assets/GoShareRemoteAssets.swf"));
			}
			catch (error:Error)
			{
				dispatchEvent(new AppAssetsManagerEvent(AppAssetsManagerEvent.ASSETS_FAULT));
			}
		}
		
		protected function loader_completeHandler(event:Event):void
		{
			try
			{
				assetsSwf = event.currentTarget.content;
				try
				{
					iconAssets = assetsSwf["iconAssets"];
					configAssets = assetsSwf["configAssets"];
				}
				catch (e:Error)
				{
					// do nothing
				}
				dispatchEvent(new AppAssetsManagerEvent(AppAssetsManagerEvent.ASSETS_SUCCESS));
			}
			catch (error:Error)
			{
				// error
				errorHandler(null);
			}
		}
		
		protected function loader_progressHandler(event:ProgressEvent):void
		{
			var value:Number = event.bytesLoaded / event.bytesTotal;
			var aame:AppAssetsManagerEvent = new AppAssetsManagerEvent(AppAssetsManagerEvent.ASSETS_PROGRESS);
			aame.value = value;
			dispatchEvent(aame);
		}
		
		protected function errorHandler(event:IOErrorEvent):void
		{
			dispatchEvent(new AppAssetsManagerEvent(AppAssetsManagerEvent.ASSETS_FAULT));
		}
		
		private var iconAssets:*; // 图标资源
		private var configAssets:*; // 配置资源
		/**
		 *
		 * 获取资源中的图标
		 *
		 * @return
		 *
		 */
		public function getIcon(iconname:String):BitmapData
		{
			try
			{
				var iconClass:Class = iconAssets[iconname] as Class;
				var icon:Bitmap = new iconClass();
				return icon.bitmapData;
			}
			catch (error:Error)
			{
				trace("can not found icon: " + iconname);
			}
			
			return null;
		}
		
		public function getConfig(configname:String):Object
		{
			try
			{
				return configAssets[configname];
			}
			catch (error:Error)
			{
				trace("can not found config: " + configname);
			}
			
			return null;
		}
		
	}
}
