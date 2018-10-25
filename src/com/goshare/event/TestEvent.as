package com.goshare.event
{
	import flash.events.Event;
	
	/**
	 * 与EvenManager配合使用
	 * 主要用于 表示项目内的自定义事件
	 * 与AppRCManagerEvent 和 AppRCManager区分，防止其过与臃肿
	 */	
	public class TestEvent extends Event
	{
		public function TestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static const ADD_ROBOT:String = "addRobot";
		public static const ADD_FILE:String = "addFile";
		public static const REMOVE_FILE:String = "removeFile";
		
		public var descript:String;
		public var data : *;
	}
}