package com.goshare.view.home
{
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.event.FMSServerEvent;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.service.FMSServerService;
	
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class RobotVideoView extends UIComponent
	{
		public function RobotVideoView()
		{
			super();
			//			width = 280;
			//			height = 200;
			FMSServerService.getInstance().addEventListener(FMSServerEvent.CONNECT, fms_connectHandler);
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGOUT,clientLogout_Handler);
			AppRCManager.getInstance().addEventListener("openRobotVideoStreamSuc",openRobotVideoHandler); ///监听到机器人摄像头视频流事件，准备订阅
			
			EventManager.getInstance().addEventListener("removeRbt",removeRbtHandler);
			EventManager.getInstance().addEventListener("changeRobotVideoVolume",changeRobotVideoVolume_Handler);
		}
		
		protected function clientLogout_Handler(event:AgentManagerEvent):void
		{
			closeVideoAndNetStream();
			if(AppRCManager.getInstance().connectedFMS){
				AppRCManager.getInstance().disconnectFMS();
			}
		}
		
		private var nowNetStream : NetStream ///当前唯一的视频流
		private var robotVIdeo : Video;
		private var bgImg :Image;
		private var soundTrans : SoundTransform;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = "assets/view/rbtVideoBg.png";
			addChild(bgImg);
			
			var lab : Label = new Label();
			lab.text = "机器人视频区";
			addChild(lab);
			lab.visible = false;
			
			robotVIdeo = new Video();
			addChild(robotVIdeo);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = (3/4)*width;
			
			robotVIdeo.width = width;
			robotVIdeo.height = (3/4)*width;
			robotVIdeo.x = robotVIdeo.y = 0;
		}
		
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0xdddddd);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			
			//			graphics.beginFill(0x0000ff,.2);
			//			graphics.drawRect(5,5,width-10,width-10);
			//			graphics.endFill();
		}
		
		protected function fms_connectHandler(event:com.goshare.event.FMSServerEvent):void
		{
			if(!AppRCManager.getInstance().isPublishing&&AppRCManager.getInstance().connectedFMS){
//				trace("不在推流，监听到fms连接，可以执行拉流操作");
				attachNetStreamHandler();
			}
		}
		
		private function attachNetStreamHandler():void
		{
			soundTrans = new SoundTransform();
			soundTrans.volume = 0.5;
			nowNetStream= AppRCManager.getInstance().subscribe(robotStreamName);
			if(nowNetStream)
			nowNetStream.soundTransform = soundTrans;
			robotVIdeo.attachNetStream(nowNetStream);
			robotVIdeo.visible = true;
		}
		
		private var robotStreamName : String ;
		/**
		 * 监听到机器人视频流数据
		 */
		protected function openRobotVideoHandler(e:AppRCManagerEvent):void
		{
			AppRCManager.getInstance().isSubscribing = true;
			///准备开始拉流
			robotStreamName = e.DataObj.streamName;
			if(!AppRCManager.getInstance().connectedFMS){
//				trace("没有推流和拉视频流，说明fms也是断开的，执行连接fms操作");
				AppRCManager.getInstance().loginFMS();
			}else{
//				trace("已经连接fms，直接捕获视频流");
				attachNetStreamHandler();
			}
		}
		
		///监听到将机器人移除控制区
		protected function removeRbtHandler(event:TestEvent):void
		{
			if(AppRCManager.getInstance().removeClientID==AppRCManager.getInstance().nowClientID)
			closeVideoHandler();
		}
		
		private function closeVideoHandler():void
		{
			closeVideoAndNetStream();
			AppRCManager.getInstance().isSubscribing = false;
			if(!AppRCManager.getInstance().isPublishing){
//				trace("没有推流，断开FMS连接");
				AppRCManager.getInstance().disconnectFMS();
			}
		}
		
		private function closeVideoAndNetStream():void
		{
//			trace("closeVideoAndNetStream:::注销");
			if(nowNetStream)
				nowNetStream.close();
			
			robotVIdeo.clear();
			robotVIdeo.visible = false;
			robotStreamName = null;
		}
		
		protected function changeRobotVideoVolume_Handler(e:TestEvent):void
		{
			try
			{
				trace("获取音量值："+int(e.data));
				var newVolumeValue : int = int(e.data)
				if(nowNetStream){
					soundTrans.volume = newVolumeValue/100;
					nowNetStream.soundTransform = soundTrans;
				}
			} 
			catch(error:Error) 
			{
				
			}
		}
	}
}