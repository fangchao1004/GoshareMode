package com.goshare.view.regsiter
{
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.EventManager;
	import com.goshare.service.AppService;
	import com.goshare.view.MainView;
	import com.goshare.view.login.LoginView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Encoder;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 注册-录入人脸部分（第三步）
	 */
	public class RegsiterPanelOfPic extends UIComponent
	{
		public function RegsiterPanelOfPic()
		{
			super();
			EventManager.getInstance().addEventListener("openCamera",openCameraEventHandler);
		}
		
		protected function openCameraEventHandler(event:Event):void
		{
			openCamera();
		}
		
		private var video : Video;
		private var camera : Camera;
		private var coverIcon : Image;
		private var camIcon : Image;
		private var picShow : Bitmap;
		private var okBtn : Button;
		private var lab : Label;
		private var picDataStr : String
		private var stepImg : Image;
		private var bm : Bitmap;
		private var result : Label;
		private var okIcon : Image;
		private var gobackBtn : Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			stepImg = new Image();
			stepImg.source = "assets/regsiter/step3.png";
			addChild(stepImg);
			
			video = new Video(240,240);
			addChild(video);
			video.visible = false;
			
			bm = new Bitmap();
			addChild(bm);
			bm.visible = false;
			
			coverIcon = new Image();
			coverIcon.source = "assets/regsiter/cover2.png";
			coverIcon.width = coverIcon.height = 240;
			addChild(coverIcon);
			coverIcon.visible = false;
			
			camIcon = new Image();
			camIcon.source = "assets/regsiter/cameraIcon.png";
			camIcon.width =  80;
			camIcon.height = 70;
			camIcon.buttonMode = true;
			camIcon.addEventListener(MouseEvent.CLICK,camIcon_Handler);
			addChild(camIcon);
			
			lab = new Label();
			lab.text = "请将面部放入相机取景框中";
			lab.fontFamily = FontFamily.STXIHEI;
			lab.bold = true;
			lab.fontSize = 22;
			addChild(lab);
			
			okIcon = new Image();
			okIcon.source = "assets/regsiter/ok.png";
			okIcon.width = okIcon.height = 26;
			addChild(okIcon);
			okIcon.visible = false;
			
			result = new Label();
			result.text = "拍摄成功";
			result.fontFamily = FontFamily.STXIHEI;
			result.bold = true;
			result.fontSize = 20;
			addChild(result);
			result.visible = false;
			
			okBtn = new Button();
			okBtn.buttonMode = true;
			okBtn.radius = 10;
			okBtn.backgroundColor = 0x5c9dfd
			okBtn.color = 0xffffff;
			okBtn.fontFamily = FontFamily.STXIHEI;
			okBtn.fontSize = 20;
			okBtn.label = "确定";
			okBtn.width = 290;
			okBtn.height = 46;
			okBtn.addEventListener(MouseEvent.CLICK,okBtn_Handler);
			addChild(okBtn);
			
			gobackBtn = new Button();
			gobackBtn.buttonMode = true;
			gobackBtn.radius = 10;
			gobackBtn.backgroundColor = 0x5c9dfd
			gobackBtn.color = 0xffffff;
			gobackBtn.fontFamily = FontFamily.STXIHEI;
			gobackBtn.fontSize = 20;
			gobackBtn.label = "返回首页";
			gobackBtn.width = 290;
			gobackBtn.height = 46;
			gobackBtn.addEventListener(MouseEvent.CLICK,gobackBtn_Handler);
			addChild(gobackBtn);
			gobackBtn.visible = false;
		}
		
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			stepImg.width = 420*1.2;
			stepImg.height = 54*1.2;
			stepImg.x = (width-stepImg.width)/2;
			stepImg.y = 50;
			
			camIcon.x = (width-camIcon.width)/2;
			camIcon.y = 260;
			
			video.x = (width-video.width)/2;
			video.y = 180;
			
			coverIcon.x = video.x;
			coverIcon.y = video.y;
			
			lab.x  = (width-lab.text.length*lab.fontSize)/2;
			lab.y = video.y+video.height + 40;
			
			
			
			result.x  = (width-result.text.length*result.fontSize)/2;
			result.y = video.y+video.height + 40;
			
			okIcon.x = result.x -40;
			okIcon.y = result.y;
			
			gobackBtn.x = okBtn.x = (width-okBtn.width)/2;
			gobackBtn.y =okBtn.y = video.y + video.height + 90;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			
			graphics.beginFill(0xf6f5f5);
			graphics.drawRect(width/2-220,160,440,420);
			graphics.endFill();
			
			graphics.beginFill(0xffffff);
			graphics.drawCircle(width/2,300,120);
			graphics.endFill();
		}
		
		protected function camIcon_Handler(event:MouseEvent):void
		{
//			openCamera();
			getPhoto();
		}
		
		private function openCamera():void
		{
			camera=Camera.getCamera("0"); 
			if(camera==null){Alert.show("无摄像头\n");} 
			camera.setMode(240,240,10); 
			camera.setQuality(0,100); 
			video.attachCamera(camera);
			video.visible = true;
			coverIcon.visible = true;
		}
		
		protected function okBtn_Handler(event:MouseEvent):void
		{
//			getPhoto();
			trace("点击确定");
			sendData();
		}	
		
		private function getPhoto():void
		{
			if(video.visible)
			{
				var bmd : BitmapData = new BitmapData(video.width,video.height);
				var myMatrix:Matrix=new Matrix(); 
				myMatrix.scale(1,1);//关键处，该处的值应该是由video的大小和camera设置的大小决定的。 
				bmd.draw(video,myMatrix); 
				
				bm.bitmapData = bmd;
				bm.y = video.y;
				bm.x = video.x;
				bm.visible = true;
				camIcon.visible = false;
				coverIcon.visible = true;
				lab.visible = false;
				result.visible = true;
				okIcon.visible = true;
				
				///成功后关闭camera
				video.attachCamera(null);
				video.clear();
				video.visible = false;
				
				var bmdbytes : ByteArray = bmd.getPixels(new Rectangle(0,0,video.width,video.height));
				var base64encoder : Base64Encoder = new Base64Encoder();
				base64encoder.encodeBytes(bmdbytes);
				picDataStr = base64encoder.flush();
				
//				trace("位图经过base64转码后的数据长度：",picDataStr.length);
//				trace("截取前50位测试",picDataStr.substring(0,50));
				/////picDataStr数据量很大，无法在控制台打印
				UserInfo.userFace = picDataStr;
				UserInfo.userFaceBitmapData = bmd;
			}
		}
		
		private function sendData():void
		{
			if(picDataStr){
				var data : Object = new Object();
				data.userName = UserInfo.userName;
				data.userId = UserInfo.userId;
				data.userFace = UserInfo.userFace;
				data.gender = UserInfo.gender;
				data.school = UserInfo.school;
				data.work = UserInfo.work;
				data.duty = UserInfo.duty;
				
				///发送数据
//				trace("正式发送数据: "+JSON.stringify(data));
				
				/////picDataStr数据量很大，无法在控制台打印,输入文件进行调试
				var f: File = File.desktopDirectory.resolvePath("test.txt");
				var fs : FileStream = new FileStream();
				fs.open(f,FileMode.WRITE);
				fs.writeMultiByte(JSON.stringify(data),"utf-8");
				fs.close();
				
				DataOfPublic.getInstance().allDataByRegsiter = data;
				AppService.getInstance().putUserInfo(data,putUserInfoResultHandler,putUserInfoFaultHandler);
				
				///发送成功后 提供返回登录界面的按钮
				gobackBtn.visible = true;
				okBtn.visible = false;
			}else{
				Alert.show("请先拍摄照片");
			}
		}
		
		private function putUserInfoFaultHandler(e:Event):void
		{
			Alert.show("上传个人信息失败");
		}
		
		private function putUserInfoResultHandler(e:Event):void
		{
//			trace("resultHandler: "+e.currentTarget.data);
			var resultObj : Object = JSON.parse(e.currentTarget.data)
			if(resultObj["rspcod"]=="200"){
//				Alert.show("上传个人信息成功");
			}else {
				Alert.show(resultObj["rspcod"]+";"+resultObj["rspmsg"]);
			}
		}
		
		protected function gobackBtn_Handler(event:MouseEvent):void
		{
			goToLoginView();
			resetView();
		}
		
		private function resetView():void
		{
//			trace("重置界面");
			video.visible = false;
			bm.visible = false;
			coverIcon.visible = false;
			camIcon.visible = true;
			lab.visible = true;
			okIcon.visible =result.visible = false;
			gobackBtn.visible = false;
			okBtn.visible = true;
			picDataStr = "";
		}
		
		private function goToLoginView():void
		{
			RegsiterNavigator.getInstance().pushView(RegsiterPanelOfID)
			MainView.getInstance().pushView(LoginView);
		}
	}
}