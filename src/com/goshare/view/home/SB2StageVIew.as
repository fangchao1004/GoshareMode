package com.goshare.view.home
{
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.event.FMSServerEvent;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.service.FMSServerService;
	import com.goshare.view.Interactive.InteractiveView;
	
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class SB2StageVIew extends UIComponent
	{
		public function SB2StageVIew()
		{
			super();
			
//			width = 765;
//			height = 710;
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGOUT,clientLogoutHandler);
			AppRCManager.getInstance().addEventListener("openRobotDeskTopStreamSuc",openRobotDeskTopStreamSuc_Handler);///桌面流数据获取成功
			EventManager.getInstance().addEventListener("stopShowDeskStream",stopShowDeskStream_Handler);///将机器人移除监控时，同时停止该终端桌面流
			FMSServerService.getInstance().addEventListener(FMSServerEvent.CONNECT, fms_connectHandler);
		}
		
		protected function clientLogoutHandler(event:AgentManagerEvent):void
		{
			closeDeskStream();
		}
		
		protected function fms_connectHandler(event:FMSServerEvent):void
		{
			if(!AppRCManager.getInstance().isPublishing&&AppRCManager.getInstance().connectedFMS){
				getDeskStream();
			}
		}
		
		private var bgImg :Image;
		private var stageVIdeo : Video;
		private var interactiveView : InteractiveView;
		private var deskStreamName : String; ///桌面流名
		private var nowDeskNetStream : NetStream ///当前的桌面视频流
		override protected function createChildren():void
		{
			super.createChildren();
			
			var lab : Label = new Label();
			lab.text = "课件播放区";
			addChild(lab);
			lab.visible = false;
			
			bgImg = new Image();
			bgImg.source = "assets/view/stageBg2.png";
			addChild(bgImg);
			
			stageVIdeo = new Video();
			addChild(stageVIdeo);
			stageVIdeo.visible = false;
			
			interactiveView =new InteractiveView();
			addChild(interactiveView);
			
			var testBtn : Button = new Button();
			testBtn.label = "check";
			testBtn.y = -50;
			testBtn.addEventListener(MouseEvent.CLICK,openTestHandler);
			addChild(testBtn);
			testBtn.visible = false;
			
			var testBtn2 : Button = new Button();
			testBtn2.x = 200;
			testBtn2.label = "close";
			testBtn2.addEventListener(MouseEvent.CLICK,closeTestHandler);
			addChild(testBtn2);
			testBtn2.visible = false;
		}
		
		protected function closeTestHandler(event:MouseEvent):void
		{
			closeDeskStream();
		}
		
		protected function openTestHandler(event:MouseEvent):void
		{
//			getDeskStream();
			Alert.show("connectedFMS:: "+AppRCManager.getInstance().connectedFMS);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = width*9/16;
			
			stageVIdeo.width = bgImg.width;
			stageVIdeo.height = bgImg.height;
			
			interactiveView.x = 0;
			interactiveView.y = bgImg.y+bgImg.height+5;
			interactiveView.width = width;
			interactiveView.height = height-bgImg.height-5;
		
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		///监听到桌面流事件
		protected function openRobotDeskTopStreamSuc_Handler(e:AppRCManagerEvent):void
		{
			if(!Object(e.DataObj).hasOwnProperty("streamName")){
				return;
			}
			deskStreamName = String(e.DataObj.streamName);
			AppRCManager.getInstance().nowClientID = deskStreamName.substr(0,8);
//			trace("==============");
//			trace("截取：：",deskStreamName.substr(0,8));
//			trace("==============");
			///收到桌面流信息时，已经获取到了机器人的摄像头视频流，说明已经在拉流，FMS已经连接
			if(!AppRCManager.getInstance().isSubscribing&&!AppRCManager.getInstance().isPublishing&&!AppRCManager.getInstance().connectedFMS){
//				trace("-----FMS未连接-未拉流-未推流-执行-loginFMS-拉流至true-");
				AppRCManager.getInstance().isSubscribing = true;
				AppRCManager.getInstance().loginFMS();
			}else{
				getDeskStream();
			}
		}
		
		private function getDeskStream():void
		{
			if(deskStreamName){
				nowDeskNetStream= AppRCManager.getInstance().subscribe(deskStreamName);
				stageVIdeo.attachNetStream(nowDeskNetStream);
				stageVIdeo.visible = true;
			}
		}
		
		protected function stopShowDeskStream_Handler(e:TestEvent):void
		{
//			trace("removeClientID",AppRCManager.getInstance().removeClientID);
//			trace("nowClientID",AppRCManager.getInstance().nowClientID);
			if(AppRCManager.getInstance().removeClientID==AppRCManager.getInstance().nowClientID)
			closeDeskStream();
		}
		
		private function closeDeskStream():void
		{
			deskStreamName = null;
			stageVIdeo.clear();
			stageVIdeo.attachCamera(null);
			stageVIdeo.visible = false;
			if(nowDeskNetStream){
				nowDeskNetStream.close();
			}
		}
	}
}