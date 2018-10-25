package com.goshare.event
{
	import com.goshare.data.Message;
	
	import flash.events.Event;
	
	public class AppRCManagerEvent extends Event
	{
		/**
		 * 休息状态提示信息改变
		 */
		public static const RESTMASK_PROMPT:String = "restMaskPrompt";
		
		/**
		 * 退出休息状态
		 */
		public static const RESTMASK_HIDE:String = "restMaskHide";
		
		/**
		 * 显示休息状态
		 */
		public static const RESTMASK_SHOW:String = "restMaskShow";
		
		/** ?? **/
		public static const RESTMASK_ERROR:String = "restMaskError";
		
		/**
		 * 进入/离开监控模式
		 */		
		public static const RC_LEAVE_MONITOR:String = "rcLeaveMonitor";
		
		/*
		 *进入正常模式 
		*/
		public static const RC_ENTER_NORMAL_MODEL:String = "rcEnterNormalModel";
		
		/*
		*进入远程控制
		*/
		public static const RC_ENTER_CONTROL_MODEL:String = "rcEnterControlModel";
		
		/*
		 *切换SingleRCMonitor中的narrowLargeBtn的外观
		*/
		public static const NARROWLARGEBTN_ICON_LARGE:String = "narrowLargeBtnIconLarge";
		public static const NARROWLARGEBTN_ICON_NARROW:String = "narrowLargeBtnIconNarrow";
		
		/**
		 * 离开大屏远程桌面模式
		 */		
		public static const RC_LEAVE_ROTOME:String = "rcLeaveRotome";
		
		/**
		 * 进入大屏远程桌面模式
		 */		
		public static const RC_ENTER_ROTOME:String = "rcEnterRotome";
		
		/**
		 * 离开大屏控制行走模式
		 */		
		public static const RC_LEAVE_LARGE_CONTROL:String = "rcLeaveLargeControl";
		
		/**
		 * 进入大屏控制行走模式
		 */		
		public static const RC_ENTER_LARGE_CONTROL:String = "rcEnterLargeControl";
		
		/**
		 * 终端客户端发生改变的时候派发 
		 */		
		public static const RC_LIST_CHAGNED:String = "rcListChanged";
		
		/**
		 * 终端的控制状态生变化的时候派发 
		 */		
		public static const RC_STATUS_CHANGED:String = "rcStatusChanged";
		
		/**
		 * 需要将RC添加到监视器的时候派发 
		 */		
		public static const RC_SELECT_CHANGED:String = "rcSelectChanged";
		
		/**
		 * 控制的RC发生变化的时候派发
		 * */
		public static const RC_CONTROL_CHANGED:String = "rcControlChanged";
		
		/**
		 * RC在监控模式下的选中状态发生变化
		 */		
		public static const RC_SELECT_IN_MONITOR:String = "rcSelectedInMonitor";

		/**
		 * 有终端消息的时候派发 
		 */		
		public static const ROBOT_MESSAGE:String = "robotMessage";
		
		/**
		 * 关闭操作终端时派发
		 */		
		public static const RCMONITOR_SIGNLE_CLOSE:String = "rcMonitorSignleClose";
		
		
		/**
		 * ocx监测到有RC被双击的时候派发
		 * */
		public static const RC_OCX_DOUBLECLCIK:String = "rcOcxDoubleClick";
		
		/**
		 * 图标状态改变
		 * */
		public static const RC_LIST_ICON_CHANGE:String = "rcListIconChange";
		
		
		/**
		 * 打开桌面流
		 * */
		public static const DESK_RTMP_START:String = "desktoprtmpStart";
		
		/**
		 * 关闭桌面流
		 * */
		public static const DESK_RTMP_END:String = "desktoprtmpEnd";

		/**
		 * 增加interactiveView的尺寸
		 * */
		public static const INCREASE_INTERACTIVEVIEW_SIZE:String = "increaseInteractiveViewSize";
		
		/**
		 * 减小interactiveView的尺寸
		 * */
		public static const DECREASE_INTERACTIVEVIEW_SIZE:String = "decreaseInteractiveViewSize";
		
		/**
		 * 页面缩放&RCControlView界面大小变动
		 * */
		public static const STAGE_SIZE_CHANGE:String = "stageSizeChange";
		
		/**
		 * 交互界面中的数据个数过多时
		 * */
		public static const DATA_COUNT_OVER :String = "dataCountOver";
		
		/**
		 *机器人状态 
		 */
		public static const ROBOT_STATUS : String = "robotStatus";
		
		/**
		 *机器人表情
		 */
		public static const ROBOT_FACE : String = "robotface";
		
		/**
		 *机器人表情
		 */
		public static const C2_VERSION_INFO : String = "C2VersionInfo";

		/**
		 *自定义列表刷新
		 */
		public static const PERSONAL_DEFINE_REFRESH : String = "personalDefineRefresh";
		
		/**
		 *自定义列表修改
		 */
		public static const PERSONAL_DEFINE_CHANGE : String = "personalDefineChange";
		
		/**
		 * interactiveView发送指令方式发生改变
		 * */
		public static const INTERACTIVEVIEW_ORDER_TYPE_CHANGE:String = "InteractiveViewOrderTypeChange";
		
		/** 半人工坐席 - 清空待处理推荐问清单 **/
		public static const QS_QUEUE_CLEAR_EVENT:String = "qsQueueClearEvent";
		/** 半人工坐席 - 推荐问选择界面 - 重置位置 **/
		public static const QS_SMART_VIEW_POSITION_RESET_EVENT:String = "qsSmartViewPositionResetEvent";
		/** 半人工坐席 - 推荐问处理 - 定时器重置事件 **/
		public static const QS_HANDLER_TIMER_RESET_EVENT:String = "qsHandlerTimerResetEvent";
		/** 半人工坐席 - 推荐问处理 - 定时器停止事件 **/
		public static const QS_HANDLER_TIMER_STOP_EVENT:String = "qsHandlerTimerStopEvent";
		
		/** 快捷键打开快速检索页面 (仅C2为新平台支持) **/
		public static const OPEN_SEARCH_VIEW_HOT_KEY_EVENT:String = "showSearchViewByHotKeyEvent";
		
		
		public function AppRCManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/** 休息状态下 - 提示信息参数 **/
		public var restMaskPromptText:String = "";
		
		/** 历史记录功能 - 传递的文字记录 */
		public var descript:String;
		/** 历史记录功能 - 指令类型 */
		public var MSType:String;
		/** 历史记录筛选  设置为1 就表示该类的历史记录不保存在数据库 */
		public var filtrateType:String;
		

		/** Message信息存储 */
		public var message:Message;
		
		/** DataObj信息存储--任意数据类型 */
		public var DataObj : *;
		
		public var rowCount:int;
		
		//选中修改的对象的数据
		public var selectChangeData : Object;
		//选中修改的对象的索引
		public var selectIndex : int;
		
	}
}