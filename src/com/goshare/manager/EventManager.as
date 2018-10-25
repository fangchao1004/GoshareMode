package com.goshare.manager
{
	import com.goshare.event.TestEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="addRobot", type="com.goshare.event.TestEvent")]
	[Event(name="addFile", type="com.goshare.event.TestEvent")]
	[Event(name="removeFile", type="com.goshare.event.TestEvent")]
	
	/**
	 * 用于简单的自定义的 类之间的事件派发  与 AppRCManager 分开 避免AppRCManager过于混乱 
	 */
	public class EventManager extends EventDispatcher
	{
		public function EventManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var eventManager : EventManager;
		
		public static function getInstance():EventManager
		{
			if(!eventManager) eventManager = new EventManager();
			return eventManager;
		}
		
		/**
		 *快捷派发自定义事件 
		 * @param EventName  事件名
		 * @param param 事件参数
		 */
		public function dispatchEventQuick(EventName:String, param:*=null):void
		{
			var evt : TestEvent = new TestEvent(EventName);
			evt.data = param
			this.dispatchEvent(evt);
		}
	}
}