package com.goshare.view.Interactive
{
	import com.goshare.components.LabColorBtnWithChange;
	import com.goshare.components.PlayPauseBtn;
	import com.goshare.components.ToggleBtnForPlayAndStop;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.Message;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.ToggleButton;
	import coco.core.UIComponent;
	
	public class InteractiveBar extends UIComponent
	{
		public function InteractiveBar()
		{
			super();
			EventManager.getInstance().addEventListener("stopShowDeskStream",resetBtnStatus);///将机器人移除监控时，同时停止该终端桌面流
		}
		
		private var openAndStopBtn : ToggleBtnForPlayAndStop; ///开始上课/停止上课按钮
		private var playAndPauseBtn : PlayPauseBtn; ///播放暂停按钮
		private var shadow : DropShadowFilter;
		private var countTime : uint;
		private var countTime2 : uint;
		private var lastTimeStatusOfPP : Boolean;
		private var lastTimeStatusOfPS: Boolean;
		override protected function createChildren():void
		{
			super.createChildren();
			
			playAndPauseBtn = new PlayPauseBtn();
			playAndPauseBtn.width = 80;
			playAndPauseBtn.height = 35;
			playAndPauseBtn.buttonMode = true;
			playAndPauseBtn.addEventListener(MouseEvent.CLICK,PlayPauseBtn_Handler);
			addChild(playAndPauseBtn);
			
			openAndStopBtn = new ToggleBtnForPlayAndStop();
			openAndStopBtn.fontSize = 18;
			openAndStopBtn.radius = 10;
			openAndStopBtn.colorForUnselected = 0xffffff;
			openAndStopBtn.textForSelected = "停止上课";
			openAndStopBtn.bgColorForSelected = 0xff0000;
			openAndStopBtn.colorForSelected = 0xffffff;
			openAndStopBtn.textForUnselected = "开始上课";
			openAndStopBtn.bgColorForUnselected = 0x5c9dfd;
			openAndStopBtn.buttonMode = true;
			openAndStopBtn.addEventListener(MouseEvent.CLICK,PlayAndStop_handler);
			addChild(openAndStopBtn);
			
			shadow= new DropShadowFilter();
			with (shadow) {
				distance = 5;
				angle = 45;
				alpha = .25;
				blurX = 6;
				blurY = 6;
				color = 0x999999;
				hideObject = false;
				inner = false;
				knockout = false;
				quality = 1;
				strength = 1;
			}
			openAndStopBtn.filters = [shadow];
			playAndPauseBtn.filters = [shadow];
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			playAndPauseBtn.x = 30;
			playAndPauseBtn.y = (height-playAndPauseBtn.height)/2;
			
			openAndStopBtn.width = 120;
			openAndStopBtn.height = 35;
			openAndStopBtn.x = width-openAndStopBtn.width-10;
			openAndStopBtn.y = (height-openAndStopBtn.height)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			//			graphics.beginFill(0xeaf2fd);
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		///播放/暂停 按钮点击
		protected function PlayPauseBtn_Handler(event:MouseEvent):void
		{
			playAndPauseBtn.playFlag = !playAndPauseBtn.playFlag;
			
			if(countTime2)
				clearTimeout(countTime2);
			countTime2 = setTimeout(checkStatusHandler2,500);
		}
		
		///检查 播放/暂停 按钮状态
		private function checkStatusHandler2():void
		{
			if(lastTimeStatusOfPP==playAndPauseBtn.playFlag){
				trace("播放暂停状态与上一个状态一致，过滤操作");
				return;
			}
			if(playAndPauseBtn.playFlag==true){
				trace("暂停");
				pauseHandler();
			}else{
				trace("播放");
				playHandler();
			}
			///有效操作后记录上次状态
			lastTimeStatusOfPP = playAndPauseBtn.playFlag;
		}
		
		///播放操作
		private function playHandler():void
		{
			if(!AppRCManager.getInstance().nowClientID){
				return;
			}
			AppRCManager.getInstance().sendMessageToC1Quick("classPlanPlay",DataOfPublic.getInstance().fileDataOfSelected,
				AppRCManager.getInstance().nowClientID,AppRCManager.getInstance().userID);
		}
		
		///暂停操作
		private function pauseHandler():void
		{
			if(!AppRCManager.getInstance().nowClientID){
				return;
			}
			
			AppRCManager.getInstance().sendMessageToC1Quick("classPlanPause",DataOfPublic.getInstance().fileDataOfSelected,
				AppRCManager.getInstance().nowClientID,AppRCManager.getInstance().userID);
		}
		
		protected function PlayAndStop_handler(event:MouseEvent):void
		{
			///延时一段时间后 （当一个状态保持500ms以上时）再去获取toggle的选择状态 防止用户快速点击
			if(countTime)
				clearTimeout(countTime);
			countTime = setTimeout(checkStatusHandler,500);
		}
		
		private function checkStatusHandler():void
		{
			if(lastTimeStatusOfPS==openAndStopBtn.selected){
//				trace("开始上课和停止上课状态与上一个状态一致，过滤操作");
				return;
			}
			if(openAndStopBtn.selected==true){
				///发送开始上课指令
//				trace("开始上课");
				sendMessageToStartTeach()
			}else{
				///发送停止上课指令
//				trace("停止上课");
				sendMessageToStopTeach()
			}
			
			lastTimeStatusOfPS = openAndStopBtn.selected;
		}
		
		private function sendMessageToStopTeach():void
		{
			///开始上课时，要去获取课件选择区中，选中的课件。获取其信息
			if(DataOfPublic.getInstance().fileDataOfSelected==null||!AppRCManager.getInstance().nowClientID){
				Alert.show("课件没选中或终端对象不存在");
				openAndStopBtn.selected = !openAndStopBtn.selected
				return;
			}
			AppRCManager.getInstance().sendMessageToC1Quick("classPlanPause",DataOfPublic.getInstance().fileDataOfSelected,
				AppRCManager.getInstance().nowClientID,AppRCManager.getInstance().userID);
		}
		
		private function sendMessageToStartTeach():void
		{
			///开始上课时，要去获取课件选择区中，选中的课件。获取其信息
			if(DataOfPublic.getInstance().fileDataOfSelected==null||!AppRCManager.getInstance().nowClientID){
				Alert.show("课件没选中或终端对象不存在");
				openAndStopBtn.selected = !openAndStopBtn.selected
				return;
			}
			AppRCManager.getInstance().sendMessageToC1Quick("classPlanOpen",DataOfPublic.getInstance().fileDataOfSelected,
				AppRCManager.getInstance().nowClientID,AppRCManager.getInstance().userID);
		}
		
		protected function resetBtnStatus(event:TestEvent):void
		{
			openAndStopBtn.selected = false;
		}
		
	}
}