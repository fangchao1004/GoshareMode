package com.goshare.view.home
{
	import com.goshare.components.IconSlider;
	import com.goshare.components.ToggleIconLabBtn;
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.event.FMSServerEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.service.FMSServerService;
	import com.goshare.util.DateTimeUtil;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class LocalVideoView extends UIComponent
	{
		public function LocalVideoView()
		{
			super();
			FMSServerService.getInstance().addEventListener(FMSServerEvent.CONNECT, fms_connectHandler);
			//			FMSServerService.getInstance().addEventListener(FMSServerEvent.DISCONNECT, fms_disconnectHandler);
			//			FMSServerService.getInstance().addEventListener(FMSServerEvent.ERROR, fms_errorHandler);
			//			FMSServerService.getInstance().addEventListener(FMSServerEvent.DATA, fms_dataHandler);
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGOUT,clientLogout_Handler);
		}
		
		protected function clientLogout_Handler(event:AgentManagerEvent):void
		{
			camTogBtn.selected = false;
			micTogBtn.selected = false;
			micSlider.visible = false;
			AppRCManager.getInstance().teacherStreamName = null;
			if(AppRCManager.getInstance().isPublishing){
				closeVideoAndNetStream();
				AppRCManager.getInstance().disconnectFMS();
			}
		}
		
		protected function fms_connectHandler(event:com.goshare.event.FMSServerEvent):void
		{
			if(!AppRCManager.getInstance().isSubscribing&&AppRCManager.getInstance().connectedFMS){
//				trace("不在拉流，可以正式推流操作");
				publishStream();
			}
		}
		
		
		private var bgImg : Image;
		public var localVideo : Video;
		private var myCamera : Camera;
		private var myMic : Microphone;
		private var micSlider : IconSlider;
		private var camTogBtn : ToggleIconLabBtn;
		private var micTogBtn : ToggleIconLabBtn;
		private var countTime : uint;
		private var shadow : DropShadowFilter;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = "assets/view/localVideoBg.png";
			addChild(bgImg);
			
			var lab : Label = new Label();
			lab.text = "本地视频区";
			addChild(lab);
			lab.visible = false;
			
			localVideo = new Video();
			localVideo.visible = false;
			addChild(localVideo);
			
			camTogBtn = new ToggleIconLabBtn();
			camTogBtn.iconArray = ["camera_unselected.png","camera_selected.png"];
			camTogBtn.radius = 30;
			camTogBtn.txtLab = "摄像头";
			camTogBtn.addEventListener(MouseEvent.CLICK,camTogBtn_Handler);
			addChild(camTogBtn);
			
			micTogBtn = new ToggleIconLabBtn();
			micTogBtn.iconArray = ["mic_unselected.png","mic_selected.png"];
			micTogBtn.radius = 30;
			micTogBtn.txtLab = "麦克风";
			micTogBtn.addEventListener(MouseEvent.CLICK,micTogBtn_Handler);
			addChild(micTogBtn);
			
			micSlider = new IconSlider();
			micSlider.iconSourceArray = ["mic_open_old.png","mic_close_old.png"];
			micSlider.x = micSlider.y = 40;
			micSlider.width = 140;
			micSlider.height = 24;
			micSlider.sliderIsVertical = true;
			micSlider.addEventListener(UIEvent.CHANGE,changeHandler);
			addChildAt(micSlider,3);
			micSlider.visible = false;
			
			///阴影滤镜
//			shadow= new DropShadowFilter();
//			with (shadow) {distance = 5; angle = 45; alpha = .25;
//				blurX = 6; blurY = 6; color = 0x999999; hideObject = false;
//				inner = false; knockout = false; quality = 1;strength = 1;
//			}
//			camTogBtn.filters = [shadow];
//			micTogBtn.filters = [shadow];
		}
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = (3/4)*width;
			
			localVideo.width = width;
			localVideo.height = (3/4)*width;
			localVideo.x = localVideo.y = 0;
			
			camTogBtn.x = 5;
			camTogBtn.y = localVideo.y+localVideo.height+10;
			camTogBtn.width = (width-30)/2;
			camTogBtn.height = 0.8*height/5;
			
			micTogBtn.x = camTogBtn.x+camTogBtn.width+20;
			micTogBtn.y = camTogBtn.y;
			micTogBtn.width = camTogBtn.width;
			micTogBtn.height = camTogBtn.height;
			
			micSlider.x = micTogBtn.x+micTogBtn.width-micSlider.height;
			micSlider.y = micTogBtn.y-micSlider.width;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			//			graphics.lineStyle(1,0x999999);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		///麦克风按钮点击
		protected function micTogBtn_Handler(event:MouseEvent):void
		{
			micSlider.visible = !micSlider.visible;
		}
		
		///麦克风滑块改变mic增益
		protected function changeHandler(event:UIEvent):void
		{
			if(myMic) {
				myMic.gain = Math.ceil(micSlider.sliderNumber)
			}
		}
		///摄像头按钮点击
		protected function camTogBtn_Handler(event:MouseEvent):void
		{
			///延时一段时间后 （当一个状态保持500ms以上时）再去获取toggle的选择状态 防止用户快速点击
			if(countTime)
				clearTimeout(countTime);
			countTime = setTimeout(checkStatusHandler,500);
		}
		
		////摄像头状态改变
		private function checkStatusHandler():void
		{
			if(camTogBtn.selected)
			{
				if(localVideo.visible)
				{
					trace("视频已经开了，无需重复打开摄像头");
					return;
				}
				///准备开始推流操作
				openVideoHandler();
			}else  ///关闭视频，停止推流
			{
				if(!localVideo.visible)
				{
					trace("已经关了，无需重复关闭摄像头");
					return;
				}
				closeVideoHandler();
			}
		}
		
		private function closeVideoHandler():void
		{
			camTogBtn.selected = false;
			closeVideoAndNetStream();
			
			if(!AppRCManager.getInstance().isSubscribing){
				AppRCManager.getInstance().disconnectFMS(); ////执行到此  如果没有连接FMS则，此时本地摄像头会关闭（灯灭）。如果连接了FMS服务器，本地摄像头不会关闭？why?
				trace("没有拉流，且当前fms连接，断开FMS服务器");
			}
		}
		
		private function closeVideoAndNetStream():void
		{
			localVideo.clear();
			localVideo.attachCamera(null);
			localVideo.visible = false;
			AppRCManager.getInstance().isPublishing = false;
			
			if(myNetStream){
				myNetStream.attachAudio(null);
				myNetStream.attachCamera(null);
				myNetStream.close();
				myNetStream = null;
			}
			
			if(AppRCManager.getInstance().isSubscribing){
				//				Alert.show("如果事先拉流，教师端推流后 再派发事件通知控制区的机器人端");
				EventManager.getInstance().dispatchEventQuick("toldClientCloseTeacherSteam");
			}
		}
		
		private function openVideoHandler():void
		{
			trace("openVideo");
			AppRCManager.getInstance().isPublishing = true;
			////检查连接FMS的状态   即 有没有拉流
			trace("loginFMS");
			if(!AppRCManager.getInstance().isSubscribing&&!AppRCManager.getInstance().connectedFMS){
				trace("没有正在拉流，说明fms也是断开的，执行连接fms操作");
				AppRCManager.getInstance().loginFMS();
			}else{
				///如果已经连接 则直接推流
				trace("fms已经连接,直接打开本地摄像头");
				publishStream();
			}
		}
		
		private var myNetStream : NetStream;
		private function publishStream():void
		{
			///正式推流
			myCamera = Camera.getCamera();
			myCamera.setMode(480,360,15);
			myCamera.setKeyFrameInterval(15);
			myCamera.setQuality(0,100);
			
			myMic = Microphone.getMicrophone();
			myMic.setUseEchoSuppression(true);  
			//			myMic.setLoopBack(true);    //将麦克风捕获的音频传送到本地扬声器。
			myMic.gain = micSlider.sliderNumber;
			
			var steamName : String = getTeacherStreamName();
			AppRCManager.getInstance().teacherStreamName = steamName;
			myNetStream = AppRCManager.getInstance().agentService.publish(steamName,myCamera,myMic);
			
			///本地视频
			localVideo.attachCamera(myCamera);
			localVideo.visible = true;
			
			///如果事先拉流，教师端推流后 再派发事件通知控制区的机器人端
			if(AppRCManager.getInstance().isSubscribing){
//				Alert.show("如果事先拉流，教师端推流后 再派发事件通知控制区的机器人端");
				EventManager.getInstance().dispatchEventQuick("toldClientOpenTeacherSteam");
			}
		}
		
		public function getTeacherStreamName():String{
			var streamName:String = AppRCManager.getInstance().userID +"_"+ DateTimeUtil.formatDateTime(new Date(), "yyyyMMdd_HHmmss");
			return streamName;
		}
		
		
	}
}