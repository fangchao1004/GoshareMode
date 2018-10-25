package com.goshare.view.personalCenter
{
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.editMode.ClassDropSubMode;
	import com.goshare.view.personalCenter.editMode.PositionDropSubMode;
	import com.goshare.view.personalCenter.editMode.SubjectDropSubMode;
	import com.goshare.view.personalCenter.editMode.UserInfoDropSubMode;
	
	import flash.events.Event;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.Scroller;
	import coco.component.VGroup;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class EditUserInfoView extends UIComponent
	{
		public function EditUserInfoView()
		{
			super();
			EventManager.getInstance().addEventListener("refreshHightShow",refreshHightShow);
		}
		
		protected function refreshHightShow(event:Event):void
		{
			invalidateDisplayList();
		}
		
		private var titleIcon : Image;
		private var lab : Label;
		private var vg : VGroup;
		private var scroller : Scroller;
		private var userInfoMode : UserInfoDropSubMode;
		private var subjectMode : SubjectDropSubMode;
		private var positionMode : PositionDropSubMode;
		private	 var classMode : ClassDropSubMode;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleIcon = new Image();
			titleIcon.source = "assets/personalCenter/editUserInfo_selected.png";
			addChild(titleIcon);
			
			lab = new Label();
			lab.text = "编辑资料";
			lab.color = 0x5c9dfd;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.fontSize = 20;
			lab.bold = true;
			addChild(lab);
			
			scroller = new Scroller();
			scroller.autoDrawSkin = true;
			scroller.verticalScrollEnabled = true;
			scroller.horizontalScrollEnabled = false;
			addChild(scroller);
			
			vg = new VGroup();
			vg.gap = 10;
			scroller.addChild(vg);
			
			userInfoMode = new UserInfoDropSubMode();
			vg.addChild(userInfoMode);
			
			subjectMode = new SubjectDropSubMode();
			vg.addChild(subjectMode);
			
			positionMode = new PositionDropSubMode();
			vg.addChild(positionMode);
			
			classMode = new ClassDropSubMode();
			vg.addChild(classMode);
		}
		
	    override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleIcon.width = titleIcon.height = 28;
			titleIcon.x = 35;
			titleIcon.y = 10;
			
			lab.x = 80;
			lab.y = 13;
		
			scroller.x =0;
			scroller.y = 40;
			scroller.width = width-10;
			scroller.height = height-scroller.y;
			vg.width = scroller.width;
			userInfoMode.width  =  subjectMode.width  =positionMode.width  = classMode.width = scroller.width-10;
			
			
			vg.height = userInfoMode.height+subjectMode.height+positionMode.height+classMode.height+45;
//			trace("vg.height: "+vg.height);
			//			scroller.verticalScrollPosition = scroller.maxVerticalScrollPosition
//			setTimeout(function abc(): void { scroller.verticalScrollPosition = scroller.maxVerticalScrollPosition; },10)
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
//			graphics.beginFill(0x5c9dfd,0.2);
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}