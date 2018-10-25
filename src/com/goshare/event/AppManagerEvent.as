package com.goshare.event
{
	import flash.events.Event;
	
	public class AppManagerEvent extends Event
	{
		
		public function AppManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static const VOLUMESTRENGTH_START:String = "volumeStrengthStart";
		public static const VOLUMESTRENGTH_CHANGE:String = "volumeStrengthChange";
		public static const VOLUMESTRENGTH_STOP:String = "volumeStrengthStop";
		
		/**
		 * 相关描述
		 */		
		public var descript:String;
		
		public var volumeStrength:int;
		
	}
}