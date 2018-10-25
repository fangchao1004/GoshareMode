package com.goshare.event
{
	import flash.events.Event;
	
	
	public class AppAssetsManagerEvent extends Event
	{
		
		public static const ASSETS_SUCCESS:String = "assetsSuccess";
		public static const ASSETS_PROGRESS:String = "assetsProgress";
		public static const ASSETS_FAULT:String = "assetsFault";
		
		public function AppAssetsManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var value:Number;
		
	}
}