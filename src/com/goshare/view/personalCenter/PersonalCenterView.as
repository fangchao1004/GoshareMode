package com.goshare.view.personalCenter
{
	import com.goshare.components.BgWithLabBtn;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.EventManager;
	import com.goshare.render.ItemRenderForSelectList;
	import com.goshare.view.MainView;
	import com.goshare.view.home.HomeView;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	public class PersonalCenterView extends UIComponent
	{
		public function PersonalCenterView()
		{
			super();
			EventManager.getInstance().addEventListener("getUserInfoFromServer",getUserInfoFromServer_Handler)///从后台获取个人信息数据
		}
		
		protected function getUserInfoFromServer_Handler(event:Event):void
		{
			invalidateProperties();
			invalidateDisplayList();
			recoverUserName();
			recoverUserFaceImage();
		}
		
		private function recoverUserFaceImage():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter){
				if(DataOfPublic.getInstance().allDataByRegsiter["userFace"]){
					var userFaceSource : String  = DataOfPublic.getInstance().allDataByRegsiter["userFace"];
					userFaceImage.source = userFaceSource;
					userFaceImage.visible = true;
				}else{
					userFaceImage.visible = false;
				}
			}
		}
		
		private function recoverUserName():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter){
				if(DataOfPublic.getInstance().allDataByRegsiter["userName"]){
					userNameLab.text = DataOfPublic.getInstance().allDataByRegsiter["userName"];
					userNameLab.visible = true;
				}else{
					userNameLab.visible = false;
				}
			}
		}
		
		private var lastTimeInt  : int;
		private var goHomeIcon : Image;
		private var userBg : Image;
		private var userFaceImage : Image;
		private var coverIcon : Image;
		private var userNameLab : TextInput;
		private var myFileBtn : BgWithLabBtn;
		private var myVideoBtn : BgWithLabBtn;
		private var selectList : List;
		private var editUserInfoVIew : EditUserInfoView;
		private var changePwdView :ChangePwdView;
		private var normalSetView : NormalSetView;
		override protected function createChildren():void
		{
			super.createChildren();
			
			goHomeIcon = new Image();
			goHomeIcon.source = "assets/personalCenter/gohome.png";
			goHomeIcon.buttonMode = true;
			goHomeIcon.addEventListener(MouseEvent.CLICK,goHomeIcon_Handler);
			addChild(goHomeIcon);
			
			userBg = new Image();
			userBg.source = "assets/personalCenter/userBg.png";
			addChild(userBg);
			
			userFaceImage = new Image();
			addChild(userFaceImage);
			userFaceImage.visible= false;
			
			coverIcon = new Image();
			coverIcon.source = "assets/regsiter/cover.png";
			addChild(coverIcon);
			
			userNameLab = new TextInput();
			userNameLab.autoDrawSkin = false;
			userNameLab.textAlign = HorizontalAlign.CENTER;
			userNameLab.text = "";
			userNameLab.fontFamily = FontFamily.STXIHEI;
			userNameLab.fontSize = 16;
			addChild(userNameLab);
			
			myFileBtn = new BgWithLabBtn();
			myFileBtn.width = 230;
			myFileBtn.height = 100;
			myFileBtn.bgImgSource = "assets/personalCenter/myFileBg.png";
			myFileBtn.iconImgSource = "assets/personalCenter/myFileIcon.png";
			myFileBtn.iconWidth = 63;
			myFileBtn.iconHeight = 75;
			myFileBtn.labTxt = "我的课件";
			myFileBtn.numTxt = "0";
			addChild(myFileBtn);
			
			myVideoBtn = new BgWithLabBtn();
			myVideoBtn.width = 230;
			myVideoBtn.height = 100;
			myVideoBtn.bgImgSource = "assets/personalCenter/myVideoBg.png";
			myVideoBtn.iconImgSource = "assets/personalCenter/myVideoIcon.png";
			myVideoBtn.iconWidth = 57;
			myVideoBtn.iconHeight = 72;
			myVideoBtn.labTxt = "我的录播";
			myVideoBtn.numTxt = "0";
			addChild(myVideoBtn);
			
			selectList = new List();
			selectList.width = 160;
			selectList.height = 430;
			selectList.itemRendererHeight = 50;
			selectList.gap = 10;
			selectList.verticalScrollEnabled = false;
			selectList.dataProvider = [{"name":"编辑资料","fileType":"editUserInfo"},{"name":"密码修改","fileType":"changePwd"},{"name":"基本设置","fileType":"normalSet"}];
			selectList.labelField = "name";
			selectList.itemRendererClass = ItemRenderForSelectList;
			selectList.selectedIndex = 0;
			selectList.addEventListener(UIEvent.CHANGE,selectList_ChangeHandler);
			addChild(selectList);
			
			editUserInfoVIew = new EditUserInfoView();
			addChild(editUserInfoVIew);
			editUserInfoVIew.visible = true;
			
			changePwdView = new ChangePwdView();
			addChild(changePwdView);
			changePwdView.visible = false;
			
			normalSetView = new NormalSetView();
			addChild(normalSetView);
			normalSetView.visible = false;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
//			if(UserInfo.userFaceImageData){
//				userBg.visible = false;
//				userFaceImage.bitmapData = UserInfo.userFaceImageData;
//				userFaceImage.visible = true;
//			}else{
//				userBg.visible = true;
//			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			goHomeIcon.width = goHomeIcon.height = 30;
			goHomeIcon.x = width - 80;
			goHomeIcon.y = (height*(70/768)-goHomeIcon.height)/2
			
			userFaceImage.width = userFaceImage.height = 80;
			userFaceImage.x = 60;
			userFaceImage.y = height*(70/768)+10+15;
			
			userBg.width = userBg.height=coverIcon.width = coverIcon.height = 80;
			userBg.x = coverIcon.x = userFaceImage.x;
			userBg.y = coverIcon.y = userFaceImage.y;
			
			userNameLab.width = 2*coverIcon.width;
			userNameLab.x = coverIcon.x-coverIcon.width/2;
			userNameLab.y = coverIcon.y+coverIcon.height+10;
			
			myFileBtn.x = 260;
			myFileBtn.y = height*(70/768)+10+(150-myFileBtn.height)/2;
			
			myVideoBtn.x = myFileBtn.x+myFileBtn.width+30;
			myVideoBtn.y = myFileBtn.y
			
			selectList.x = 20;
			selectList.y = height*(70/768)+10+150+10;
			
			editUserInfoVIew.x =changePwdView.x=normalSetView.x = 10+180+3;
			editUserInfoVIew.y =changePwdView.y=normalSetView.y= height*(70/768)+10+150+10;
			editUserInfoVIew.width = changePwdView.width = normalSetView.width = width-20-180-3;
			editUserInfoVIew.height = changePwdView.height = normalSetView.height = height-(height*(70/768)+10+150+10+10);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			
			graphics.clear();
			graphics.beginFill(0xdfdbdb);
			graphics.drawRect(0,0,width,height);
			
			graphics.beginFill(0x5c9dfd);
			graphics.drawRect(0,0,width,height*(70/768));
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(10,height*(70/768)+10,width-20,150);
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(10,height*(70/768)+10+150+10,180,height-(height*(70/768)+10+150+10+10));
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(10+180+3,height*(70/768)+10+150+10,width-20-180-3,height-(height*(70/768)+10+150+10+10));
			
		}
		
		protected function goHomeIcon_Handler(event:MouseEvent):void
		{
			selectList.selectedIndex = 0;
			invalidateModeShow(0);
			MainView.getInstance().pushView(HomeView);
		}
		
		protected function selectList_ChangeHandler(event:UIEvent):void
		{
			if(selectList.selectedIndex!=-1){
				lastTimeInt = selectList.selectedIndex;
			}else if(selectList.selectedIndex==-1){
				selectList.selectedIndex = lastTimeInt;
			}
			invalidateModeShow(lastTimeInt);
		}
		
		private function invalidateModeShow(selectedInt:int):void
		{
			if(selectedInt==0){
				//				trace("展示编辑资料界面");
				editUserInfoVIew.visible = true;
				changePwdView.visible = false;
				normalSetView.visible = false;
			}else if(selectedInt==1){
				//				trace("展示密码修改界面");
				editUserInfoVIew.visible = false;
				changePwdView.visible = true;
				normalSetView.visible = false;
			}else if(selectedInt==2){
				//				trace("展示基本设置界面");
				editUserInfoVIew.visible = false;
				changePwdView.visible = false;
				normalSetView.visible = true;
			}
		}		
	}
}