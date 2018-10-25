package com.goshare.view.regsiter
{
	import com.goshare.components.NewDropList;
	import com.goshare.components.ToggleBtnForGender;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.EventManager;
	import com.goshare.render.itemRenderForDropList;
	import com.goshare.render.itemRenderForProjectList;
	
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 注册-个人信息录入部分（第二步）
	 */
	public class RegsiterPanelOfInfo extends UIComponent
	{
		public function RegsiterPanelOfInfo()
		{
			super();
		}
		
		private var nameLab : Label;
		private var nameInput : TextInput;
		private var genderLab : Label;
		private var toggleForMale : ToggleBtnForGender;
		private var toggleForFemale : ToggleBtnForGender;
		private var schoolLab : Label;
		private var schoolInput : TextInput;
		private var subjectLab : Label;
		/**课目列表 */
		private var subjectList : List;
		private var gradeLab : Label;
		
		
		/**教学第一组-年级 */
		private var gradeDroplist1 : NewDropList;
		/**教学第一组-班级 */
		private var classDroplist1 : NewDropList;
		/**教学第二组-年级 */
		private var gradeDroplist2 : NewDropList;
		/**教学第二组-班级 */
		private var classDroplist2 : NewDropList;
		/**教学第三组-年级 */
		private var gradeDroplist3 : NewDropList;
		/**教学第三组-班级 */
		private var classDroplist3 : NewDropList;
		
		private var headTeacherLab : Label;
		private var toggleForTrue : ToggleBtnForGender;
		private var toggleForFalse: ToggleBtnForGender;
		
		private var leadClassLab : Label;
		/**主任第一组-年级 */
		private var leadGradeDroplist1 : NewDropList;
		/**主任第一组-班级 */
		private var leadClassDroplist1 : NewDropList;
		/**主任第一组-年级 */
		private var leadGradeDroplist2 : NewDropList;
		/**主任第一组-班级 */
		private var leadClassDroplist2 : NewDropList;
		private var nextStepBtn : Button;
		/**顶部当前步骤显示图片 */
		private var stepImg : Image;
		
		/**与教学班级配套的加减按钮 */
		private var addIcon : Image;
		/**与教学班级配套的加减按钮 */
		private var removeIcon : Image;
		/**与主任班级配套的加减按钮 */
		private var addIcon2 : Image;
		/**与主任班级配套的加减按钮 */
		private var removeIcon2 : Image;
		/**与教学班级配套的组数记录（年级+班级为一组） */
		private var count : int=1;
		/**与主任班级配套的组数记录（年级+班级为一组） */
		private var leadCount : int = 1;
		
		/***work 字段 */
		private var workArray : Array = [];
		/***duty 字段 */
		private var dutyArray : Array = [];
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			stepImg = new Image();
			stepImg.source = "assets/regsiter/step2.png";
			addChild(stepImg);
			
			nameLab = new Label();
			nameLab.text = "姓    名";
			nameLab.fontFamily = FontFamily.STXIHEI;
			nameLab.bold = true;
			nameLab.fontSize = 16;
			addChild(nameLab);
			
			nameInput = new TextInput();
			nameInput.textAlign = TextAlign.CENTER;
			nameInput.height = 36;
			nameInput.width = 290;
			nameInput.radius = 10;
			nameInput.backgroundColor = 0xf6f5f5;
			nameInput.color = 0x8c8c8c;
			nameInput.fontSize = 18;
			nameInput.fontFamily = FontFamily.STXIHEI;
			addChild(nameInput);
			
			genderLab = new Label();
			genderLab.text = "性    别";
			genderLab.fontFamily = FontFamily.STXIHEI;
			genderLab.bold = true;
			genderLab.fontSize = 16;
			addChild(genderLab);
			
			toggleForMale  = new ToggleBtnForGender();
			toggleForMale.buttonMode = true;
			toggleForMale.txtLab = "男";
			toggleForMale.selected = true;
			toggleForMale.height = 30;
			toggleForMale.width = 100;
			toggleForMale.addEventListener(MouseEvent.CLICK,maleHandler);
			addChild(toggleForMale);
			
			toggleForFemale  = new ToggleBtnForGender();
			toggleForFemale.buttonMode = true;
			toggleForFemale.txtLab = "女";
			toggleForFemale.selected = false;
			toggleForFemale.height = 30;
			toggleForFemale.width = 100;
			toggleForFemale.addEventListener(MouseEvent.CLICK,femaleHandler);
			addChild(toggleForFemale);
			
			schoolLab = new Label();
			schoolLab.text = "学    校";
			schoolLab.fontFamily = FontFamily.STXIHEI;
			schoolLab.bold = true;
			schoolLab.fontSize = 16;
			addChild(schoolLab);
			
			schoolInput = new TextInput();
			schoolInput.textAlign = TextAlign.CENTER;
			schoolInput.text = "哥学";
			schoolInput.height = 36;
			schoolInput.width = 290;
			schoolInput.radius = 10;
			schoolInput.backgroundColor = 0xf6f5f5;
			schoolInput.color = 0x8c8c8c;
			schoolInput.fontSize = 18;
			schoolInput.fontFamily = FontFamily.STXIHEI;
			addChild(schoolInput);
			
			subjectLab = new Label();
			subjectLab.text = "科    目";
			subjectLab.fontFamily = FontFamily.STXIHEI;
			subjectLab.bold = true;
			subjectLab.fontSize = 16;
			addChild(subjectLab);
			
			subjectList = new List();
			subjectList.height = 80;
			subjectList.width = 290;
			subjectList.itemRendererColumnCount = 4;
			subjectList.gap = 15;
			subjectList.itemRendererClass = itemRenderForProjectList;
			subjectList.dataProvider = DataOfPublic.getInstance().subjectData;
//			subjectList.allowMultipleSelection = true;
			subjectList.selectedIndex = 0;
			addChild(subjectList);
			
			gradeLab = new Label();
			gradeLab.text = "班    级";
			gradeLab.fontFamily = FontFamily.STXIHEI;
			gradeLab.bold = true;
			gradeLab.fontSize = 16;
			addChild(gradeLab);
			
			gradeDroplist1 = new NewDropList();
			gradeDroplist1.labWidth = 40;
			gradeDroplist1.labText = "年级";
			gradeDroplist1.labX = 2;
			gradeDroplist1.MytextAlign = HorizontalAlign.LEFT;
			gradeDroplist1.buttonMode = true;
			gradeDroplist1.height = 36;
			gradeDroplist1.width = 70;
			gradeDroplist1.topRightRadius = gradeDroplist1.bottomRightRadius = 10;
			gradeDroplist1.backgroundColor = 0xf6f5f5;
			gradeDroplist1.itemRendererClass = itemRenderForDropList;
			gradeDroplist1.fontFamily = FontFamily.STXIHEI;
			gradeDroplist1.fontSize = 16;
			gradeDroplist1.color = 0x949494;
			gradeDroplist1.labelField = "name";
			gradeDroplist1.dataProvider = DataOfPublic.getInstance().gradeData;
			addChild(gradeDroplist1);
			
			classDroplist1 = new NewDropList();
			classDroplist1.labWidth = 40;
			classDroplist1.labX = 2;
			classDroplist1.labText = "班级";
			classDroplist1.MytextAlign = HorizontalAlign.LEFT;
			classDroplist1.buttonMode = true;
			classDroplist1.allowMultipleSelection = true;
			classDroplist1.height = 36;
			classDroplist1.width = 125;
			classDroplist1.topRightRadius = classDroplist1.bottomRightRadius = 10;
			classDroplist1.backgroundColor = 0xf6f5f5;
			classDroplist1.itemRendererClass = itemRenderForDropList;
			classDroplist1.fontFamily = FontFamily.STXIHEI;
			classDroplist1.fontSize = 16;
			classDroplist1.color = 0x949494;
			classDroplist1.labelField = "name";
			classDroplist1.dataProvider = DataOfPublic.getInstance().classData;
			addChild(classDroplist1);
			
			gradeDroplist2 = new NewDropList();
			gradeDroplist2.labWidth = 40;
			gradeDroplist2.labX = 2;
			gradeDroplist2.labText = "年级";
			gradeDroplist2.MytextAlign = HorizontalAlign.LEFT;
			gradeDroplist2.buttonMode = true;
			gradeDroplist2.height = 36;
			gradeDroplist2.width = 70;
			gradeDroplist2.topRightRadius = gradeDroplist2.bottomRightRadius = 10;
			gradeDroplist2.backgroundColor = 0xf6f5f5;
			gradeDroplist2.itemRendererClass = itemRenderForDropList;
			gradeDroplist2.fontFamily = FontFamily.STXIHEI;
			gradeDroplist2.fontSize = 16;
			gradeDroplist2.color = 0x949494;
			gradeDroplist2.labelField = "name";
			gradeDroplist2.dataProvider = DataOfPublic.getInstance().gradeData;
			addChild(gradeDroplist2);
			gradeDroplist2.visible = false;
			
			classDroplist2 = new NewDropList();
			classDroplist2.labWidth = 40;
			classDroplist2.labX = 2;
			classDroplist2.labText = "班级";
			classDroplist2.MytextAlign = HorizontalAlign.LEFT;
			classDroplist2.buttonMode = true;
			classDroplist2.allowMultipleSelection = true;
			classDroplist2.height = 36;
			classDroplist2.width = 125;
			classDroplist2.topRightRadius = classDroplist2.bottomRightRadius = 10;
			classDroplist2.backgroundColor = 0xf6f5f5;
			classDroplist2.itemRendererClass = itemRenderForDropList;
			classDroplist2.fontFamily = FontFamily.STXIHEI;
			classDroplist2.fontSize = 16;
			classDroplist2.color = 0x949494;
			classDroplist2.labelField = "name";
			classDroplist2.dataProvider = DataOfPublic.getInstance().classData;
			addChild(classDroplist2);
			classDroplist2.visible = false;
			
			gradeDroplist3 = new NewDropList();
			gradeDroplist3.labWidth = 40;
			gradeDroplist3.labX = 2;
			gradeDroplist3.labText = "年级";
			gradeDroplist3.MytextAlign = HorizontalAlign.LEFT;
			gradeDroplist3.buttonMode = true;
			gradeDroplist3.height = 36;
			gradeDroplist3.width = 70;
			gradeDroplist3.topRightRadius = gradeDroplist3.bottomRightRadius = 10;
			gradeDroplist3.backgroundColor = 0xf6f5f5;
			gradeDroplist3.itemRendererClass = itemRenderForDropList;
			gradeDroplist3.fontFamily = FontFamily.STXIHEI;
			gradeDroplist3.fontSize = 16;
			gradeDroplist3.color = 0x949494;
			gradeDroplist3.labelField = "name";
			gradeDroplist3.dataProvider = DataOfPublic.getInstance().gradeData;
			addChild(gradeDroplist3);
			gradeDroplist3.visible = false;
			
			classDroplist3 = new NewDropList();
			classDroplist3.labWidth = 40;
			classDroplist3.labX = 2;
			classDroplist3.labText = "班级";
			classDroplist3.MytextAlign = HorizontalAlign.LEFT;
			classDroplist3.buttonMode = true;
			classDroplist3.allowMultipleSelection = true;
			classDroplist3.height = 36;
			classDroplist3.width = 125;
			classDroplist3.topRightRadius = classDroplist3.bottomRightRadius = 10;
			classDroplist3.backgroundColor = 0xf6f5f5;
			classDroplist3.itemRendererClass = itemRenderForDropList;
			classDroplist3.fontFamily = FontFamily.STXIHEI;
			classDroplist3.fontSize = 16;
			classDroplist3.color = 0x949494;
			classDroplist3.labelField = "name";
			classDroplist3.dataProvider = DataOfPublic.getInstance().classData;
			addChild(classDroplist3);
			classDroplist3.visible = false;
			
			addIcon = new Image();
			addIcon.buttonMode = true;
			addIcon.source = "assets/regsiter/addIcon.png";
			addIcon.width = addIcon.height = 24;
			addIcon.addEventListener(MouseEvent.CLICK,addIcon_Handler);
			addChild(addIcon);
			
			removeIcon = new Image();
			removeIcon.buttonMode = true;
			removeIcon.source = "assets/regsiter/removeIcon.png";
			removeIcon.width = removeIcon.height = 26;
			removeIcon.addEventListener(MouseEvent.CLICK,removeIcon_Handler);
			addChild(removeIcon);
			removeIcon.visible = false
			
			headTeacherLab = new Label();
			headTeacherLab.text = "班主任";
			headTeacherLab.fontFamily = FontFamily.STXIHEI;
			headTeacherLab.bold = true;
			headTeacherLab.fontSize = 16;
			addChild(headTeacherLab);
			
			toggleForTrue  = new ToggleBtnForGender();
			toggleForTrue.buttonMode = true;
			toggleForTrue.txtLab = "是";
			toggleForTrue.selected = false;
			toggleForTrue.height = 30;
			toggleForTrue.width = 100;
			toggleForTrue.addEventListener(MouseEvent.CLICK,isHeadTeacherHandler);
			addChild(toggleForTrue);
			
			toggleForFalse  = new ToggleBtnForGender();
			toggleForFalse.buttonMode = true;
			toggleForFalse.txtLab = "否";
			toggleForFalse.selected = true;
			toggleForFalse.height = 30;
			toggleForFalse.width = 100;
			toggleForFalse.addEventListener(MouseEvent.CLICK,notHeadTeacherHandler);
			addChild(toggleForFalse);
			
			leadClassLab = new Label();
			leadClassLab.text = "主任班级";
			leadClassLab.fontFamily = FontFamily.STXIHEI;
			leadClassLab.bold = true;
			leadClassLab.fontSize = 16;
			addChild(leadClassLab);
			leadClassLab.visible = false;
			
			leadGradeDroplist1 = new NewDropList();
			leadGradeDroplist1.labWidth = 40;
			leadGradeDroplist1.labX = 2;
			leadGradeDroplist1.labText = "年级";
			leadGradeDroplist1.MytextAlign = HorizontalAlign.LEFT;
			leadGradeDroplist1.buttonMode = true;
			leadGradeDroplist1.height = 36;
			leadGradeDroplist1.width = 70;
			leadGradeDroplist1.topRightRadius = leadGradeDroplist1.bottomRightRadius = 10;
			leadGradeDroplist1.backgroundColor = 0xf6f5f5;
			leadGradeDroplist1.itemRendererClass = itemRenderForDropList;
			leadGradeDroplist1.fontFamily = FontFamily.STXIHEI;
			leadGradeDroplist1.fontSize = 16;
			leadGradeDroplist1.color = 0x949494;
			leadGradeDroplist1.labelField = "name";
			leadGradeDroplist1.dataProvider = DataOfPublic.getInstance().gradeData;
			addChild(leadGradeDroplist1);
			leadGradeDroplist1.visible = false;
			
			leadClassDroplist1= new NewDropList();
			leadClassDroplist1.labWidth = 40;
			leadClassDroplist1.labX = 2;
			leadClassDroplist1.labText = "班级";
			leadClassDroplist1.MytextAlign = HorizontalAlign.LEFT;
			leadClassDroplist1.buttonMode = true;
			leadClassDroplist1.allowMultipleSelection = true;
			leadClassDroplist1.height = 36;
			leadClassDroplist1.width = 125;
			leadClassDroplist1.topRightRadius = leadClassDroplist1.bottomRightRadius = 10;
			leadClassDroplist1.backgroundColor = 0xf6f5f5;
			leadClassDroplist1.itemRendererClass = itemRenderForDropList;
			leadClassDroplist1.fontFamily = FontFamily.STXIHEI;
			leadClassDroplist1.fontSize = 16;
			leadClassDroplist1.color = 0x949494;
			leadClassDroplist1.labelField = "name";
			leadClassDroplist1.dataProvider = DataOfPublic.getInstance().classData;
			addChild(leadClassDroplist1);
			leadClassDroplist1.visible = false;
			
			leadGradeDroplist2 = new NewDropList();
			leadGradeDroplist2.labWidth = 40;
			leadGradeDroplist2.labX = 2;
			leadGradeDroplist2.labText = "年级";
			leadGradeDroplist2.MytextAlign = HorizontalAlign.LEFT;
			leadGradeDroplist2.buttonMode = true;
			leadGradeDroplist2.height = 36;
			leadGradeDroplist2.width = 70;
			leadGradeDroplist2.topRightRadius = leadGradeDroplist2.bottomRightRadius = 10;
			leadGradeDroplist2.backgroundColor = 0xf6f5f5;
			leadGradeDroplist2.itemRendererClass = itemRenderForDropList;
			leadGradeDroplist2.fontFamily = FontFamily.STXIHEI;
			leadGradeDroplist2.fontSize = 16;
			leadGradeDroplist2.color = 0x949494;
			leadGradeDroplist2.labelField = "name";
			leadGradeDroplist2.dataProvider = DataOfPublic.getInstance().gradeData;
			addChild(leadGradeDroplist2);
			leadGradeDroplist2.visible = false;
			
			leadClassDroplist2 = new NewDropList();
			leadClassDroplist2.labWidth = 40;
			leadClassDroplist2.labX = 2;
			leadClassDroplist2.labText = "班级";
			leadClassDroplist2.MytextAlign = HorizontalAlign.LEFT;
			leadClassDroplist2.buttonMode = true;
			leadClassDroplist2.allowMultipleSelection = true;
			leadClassDroplist2.height = 36;
			leadClassDroplist2.width = 125;
			leadClassDroplist2.topRightRadius = leadClassDroplist2.bottomRightRadius = 10;
			leadClassDroplist2.backgroundColor = 0xf6f5f5;
			leadClassDroplist2.itemRendererClass = itemRenderForDropList;
			leadClassDroplist2.fontFamily = FontFamily.STXIHEI;
			leadClassDroplist2.fontSize = 16;
			leadClassDroplist2.color = 0x949494;
			leadClassDroplist2.labelField = "name";
			leadClassDroplist2.dataProvider = DataOfPublic.getInstance().classData;
			addChild(leadClassDroplist2);
			leadClassDroplist2.visible = false;
			
			addIcon2 = new Image();
			addIcon2.buttonMode = true;
			addIcon2.source = "assets/regsiter/addIcon.png";
			addIcon2.width = addIcon2.height = 24;
			addIcon2.addEventListener(MouseEvent.CLICK,addIcon2_Handler);
			addChild(addIcon2);
			addIcon2.visible = false;
			
			removeIcon2 = new Image();
			removeIcon2.buttonMode = true;
			removeIcon2.source = "assets/regsiter/removeIcon.png";
			removeIcon2.width = removeIcon2.height = 26;
			removeIcon2.addEventListener(MouseEvent.CLICK,removeIcon2_Handler);
			addChild(removeIcon2);
			removeIcon2.visible = false
			
			nextStepBtn = new Button();
			nextStepBtn.buttonMode = true;
			nextStepBtn.radius = 10;
			nextStepBtn.backgroundColor = 0x5c9dfd
			nextStepBtn.color = 0xffffff;
			nextStepBtn.fontFamily = FontFamily.STXIHEI;
			nextStepBtn.fontSize = 20;
			nextStepBtn.label = "下一步";
			nextStepBtn.width = 290;
			nextStepBtn.height = 36;
			nextStepBtn.addEventListener(MouseEvent.CLICK,nextStepBtn_Handler);
			addChild(nextStepBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			stepImg.width = 420*1.2;
			stepImg.height = 54*1.2;
			stepImg.x = (width-stepImg.width)/2;
			stepImg.y = 50;
			
			nameInput.x = (width-nameInput.width)/2+10;
			nameInput.y = 150;
			nameLab.x = nameInput.x - 80;
			nameLab.y = nameInput.y + 10;
			
			genderLab.x = nameLab.x;
			genderLab.y = nameLab.y+60;
			toggleForMale.x = nameInput.x+10;
			toggleForMale.y = genderLab.y-5;
			toggleForFemale.x = toggleForMale.x+120;
			toggleForFemale.y = genderLab.y-5;
			
			schoolLab.x = nameLab.x;
			schoolLab.y = genderLab.y+60;
			schoolInput.x = nameInput.x;
			schoolInput.y = schoolLab.y-10;
			
			subjectLab.x = nameLab.x;
			subjectLab.y = schoolLab.y+60;
			subjectList.x = schoolInput.x;
			subjectList.y = subjectLab.y-10;
			
			gradeLab.x = nameLab.x;
			gradeLab.y = subjectLab.y+90;
			gradeDroplist1.x = schoolInput.x+gradeDroplist1.labWidth;
			gradeDroplist1.y = gradeLab.y-10;
			
			classDroplist1.x = gradeDroplist1.x+gradeDroplist1.width+gradeDroplist1.labWidth+15;
			classDroplist1.y = gradeDroplist1.y ;
			
			gradeDroplist2.x = gradeDroplist1.x;
			gradeDroplist2.y = gradeDroplist1.y+50;
			classDroplist2.x = classDroplist1.x;
			classDroplist2.y = gradeDroplist2.y ;
			
			gradeDroplist3.x = gradeDroplist1.x;
			gradeDroplist3.y = gradeDroplist2.y+50;
			classDroplist3.x = classDroplist1.x;
			classDroplist3.y = gradeDroplist3.y ;
			
			addIcon.y = classDroplist1.y+8;
			addIcon.x = classDroplist1.x+classDroplist1.width+15;
			
			removeIcon.x = addIcon.x;
			removeIcon.y = addIcon.y+36;
			
			headTeacherLab.x = gradeLab.x;
			headTeacherLab.y = gradeLab.y+(count)*50;
			toggleForTrue.x = nameInput.x+10;
			toggleForTrue.y = headTeacherLab.y-5;
			toggleForFalse.x = toggleForTrue.x+120;
			toggleForFalse.y = headTeacherLab.y-5;
			
			leadClassLab.x = nameLab.x-16;
			leadClassLab.y = headTeacherLab.y+54;
			leadGradeDroplist1.x = gradeDroplist1.x;
			leadGradeDroplist1.y = headTeacherLab.y+48;
			leadClassDroplist1.x = leadGradeDroplist1.x+leadGradeDroplist1.width+15+leadClassDroplist1.labWidth;
			leadClassDroplist1.y = leadGradeDroplist1.y ;
			
			leadGradeDroplist2.x = leadGradeDroplist1.x;
			leadGradeDroplist2.y = leadGradeDroplist1.y+50;
			leadClassDroplist2.x = leadGradeDroplist2.x+leadGradeDroplist2.width+15+leadClassDroplist2.labWidth;
			leadClassDroplist2.y = leadGradeDroplist2.y ;
			
			addIcon2.y = leadClassDroplist1.y+8;
			addIcon2.x = leadClassDroplist1.x+leadClassDroplist1.width+15;
			removeIcon2.x = addIcon2.x;
			removeIcon2.y = addIcon2.y+36;
			
			nextStepBtn.x = nameInput.x;
			if(toggleForTrue.selected)
			{
				nextStepBtn.y = toggleForFalse.y+60+leadCount*55;
			}else
			{
				nextStepBtn.y = toggleForFalse.y+60;
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function removeIcon2_Handler(event:MouseEvent):void
		{
			if(leadCount>1)
				leadCount--;
			else
			leadCount=0
//			trace("leadCount"+leadCount);

			if(leadCount==1){
				removeIcon2.visible = false;
				clearLeadDropList2()
			}
			invalidateDisplayList();
		}	
		
		protected function removeIcon_Handler(event:MouseEvent):void
		{
			if(count>1)
				count--;
			else
			count=0
//			trace("count："+count);
			
			if(count==1)
			{
				removeIcon.visible = false;
				clearDropList2()
				clearDropList3()
			}else if(count==2){
				clearDropList3()
			}
			invalidateDisplayList();
		}
		
		/**
		 * 当选中“否”时，清除所有 主任的年级班级组
		 */
		private function clearAllLeadDropList():void
		{
			clearLeadDropList1();
			clearLeadDropList2();
			leadClassLab.visible = addIcon2.visible = removeIcon2.visible = false;
			leadCount=1;
		}
		
		/**
		 * 清除 主任年级班级 第一组
		 */
		private function clearLeadDropList1():void
		{
			leadGradeDroplist1.text = "";
			leadGradeDroplist1.list.selectedIndex = -1;
			
			leadClassDroplist1.text = "";
			leadClassDroplist1.list.selectedIndex = -1;
			leadClassDroplist1.list.selectedIndices = new Vector.<int>();
			leadClassDroplist1.mySelectedItems = [];
			
			leadGradeDroplist1.visible = leadClassDroplist1.visible = false;
		}
		
		/**
		 * 清除 主任年级班级 第二组
		 */
		private function clearLeadDropList2():void
		{
			leadGradeDroplist2.text = "";
			leadGradeDroplist2.list.selectedIndex = -1;
			
			leadClassDroplist2.text = "";
			leadClassDroplist2.list.selectedIndex = -1;
			leadClassDroplist2.list.selectedIndices = new Vector.<int>();
			leadClassDroplist2.mySelectedItems = [];
			
			leadGradeDroplist2.visible = leadClassDroplist2.visible = false;
		}
		
		/**
		 * 清除 教学年级班级 第三组
		 */
		private function clearDropList3():void
		{
			gradeDroplist3.text = "";
			gradeDroplist3.list.selectedIndex = -1;
			
			classDroplist3.text = "";
			classDroplist3.list.selectedIndex = -1;
			classDroplist3.list.selectedIndices = new Vector.<int>();
			classDroplist3.mySelectedItems = [];
			
			gradeDroplist3.visible = classDroplist3.visible = false;
		}
		
		/**
		 * 清除 教学年级班级 第二组
		 */
		private function clearDropList2():void
		{
			gradeDroplist2.text = "";
			gradeDroplist2.list.selectedIndex = -1;
			
			classDroplist2.text = "";
			classDroplist2.list.selectedIndex = -1;
			classDroplist2.list.selectedIndices = new Vector.<int>();
			classDroplist2.mySelectedItems = [];
			
			gradeDroplist2.visible = classDroplist2.visible = false;
		}
		
		/**
		 * 点击添加  教学 年级班级组
		 */
		protected function addIcon_Handler(event:MouseEvent):void
		{
			if(gradeDroplist1.text!=""&&classDroplist1.text!=""&&gradeDroplist2.text==""&&classDroplist2.text==""&&gradeDroplist3.text==""&&classDroplist3.text==""){
				gradeDroplist2.visible = classDroplist2.visible = true;
				gradeDroplist3.visible = classDroplist3.visible = false;
				removeIcon.visible = true;
				count=2;
				invalidateDisplayList();
			}
			else if(gradeDroplist1.text!=""&&classDroplist1.text!=""&&gradeDroplist2.text!=""&&classDroplist2.text!=""&&gradeDroplist3.text==""&&classDroplist3.text==""){
				gradeDroplist3.visible = classDroplist3.visible = true;
				count=3;
				invalidateDisplayList();
			}
		}
		/**
		 * 点击添加  主任 年级班级组
		 */
		protected function addIcon2_Handler(event:MouseEvent):void
		{
			if(leadGradeDroplist1.text!=""&&leadClassDroplist1.text!=""&&leadGradeDroplist2.text==""&&leadClassDroplist2.text==""){
				leadGradeDroplist2.visible = leadClassDroplist2.visible = true;
				removeIcon2.visible = true;
				leadCount=2;
				invalidateDisplayList();
			}
		}
		
		/**
		 * 选中“女”
		 */
		protected function femaleHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForMale.selected = false;
			}
		}
		/**
		 * 选中“男”
		 */
		protected function maleHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForFemale.selected = false;
			}
		}
		
		/**
		 * 班主任toggle 选中“否”
		 */
		protected function notHeadTeacherHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForTrue.selected = false;
				clearAllLeadDropList();
			}
			invalidateDisplayList();
		}
		
		/**
		 * 班主任toggle 选中“是”
		 */
		protected function isHeadTeacherHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForFalse.selected = false;
				addIcon2.visible = leadClassLab.visible=leadClassDroplist1.visible = leadGradeDroplist1.visible = true
			}
			invalidateDisplayList();
		}	
		
		
		/**
		 * 点击  ”下一步“
		 */
		protected function nextStepBtn_Handler(event:MouseEvent):void
		{
			checkSelectedData();
		}	
		
		/**
		 * 检查所有组件选中状态--整理数据
		 */
		private function checkSelectedData():void
		{
			if(!nameInput.text){
				Alert.show("请填写名称");
				return;
			}
			
			if(subjectList.selectedIndices.length==0){
				Alert.show("请选择课程");
				return;
			}
			
			if(toggleForTrue.selected&&(leadGradeDroplist1.text==""||leadClassDroplist1.text==""||leadClassDroplist1.mySelectedItems==[])){
				Alert.show("主任班级没有选择");
				return;
			}
			getWorkDataHandler();
			getDutyDataHandler();
			///将数据保存，等待个人中心模块再次恢复显示所选数据
			UserInfo.userName = nameInput.text
			UserInfo.gender = toggleForMale.selected?"男":"女"
			//			if(schoolInput.text=="哥学"){
			//				UserInfo.school = "000000002";  ///学校数据先定死
			//			}
			UserInfo.school = "000000002";  ///不论学校输入的什么，学校代号数据先定死
			
			UserInfo.work = workArray;
			UserInfo.duty = dutyArray;
			///先跳转至下个界面
			RegsiterNavigator.getInstance().pushView(RegsiterPanelOfPic);
			///再通知下一个界面打开摄像头
			EventManager.getInstance().dispatchEventQuick("openCamera");
		}
		
		/**
		 * duty字段获取数值
		 */
		private function getDutyDataHandler():void
		{
			//////duty字段获取数值
			if(toggleForTrue.selected&&leadGradeDroplist1.text!=""&&leadClassDroplist1.text!=""&&leadClassDroplist1.list.selectedItems){
				var roleStr : String ='';
				roleStr = toggleForTrue.selected?"班主任":"";
				var leadObj1 : Object = new Object();
				leadObj1.role = roleStr
				leadObj1.grade = leadGradeDroplist1.selectedItem["value"];
				leadObj1.teachClasses = getSelectedItemsValue(leadClassDroplist1.list.selectedItems,"value");
				dutyArray.push(leadObj1);
			}else{
				///如果不是班主任，duty字段为空为null
				UserInfo.duty = null;
//				trace("不是班主任");
			}
			if(toggleForTrue.selected&&leadGradeDroplist2.text!=""&&leadClassDroplist2.text!=""&&leadClassDroplist2.list.selectedItems){
				var leadObj2 : Object =new Object();
				leadObj2.role = roleStr
				leadObj2.grade = leadGradeDroplist2.selectedItem["value"];
				leadObj2.teachClasses = getSelectedItemsValue(leadClassDroplist2.list.selectedItems,"value");
				dutyArray.push(leadObj2);
			}
		}
		
		/**
		 * work字段获取数值
		 * 整体数据格式，参照DataOfPublic中的allDataByRegsiter
		 */
		private function getWorkDataHandler():void
		{
			if(gradeDroplist1.text!=""&&classDroplist1.text!=""&&classDroplist1.list.selectedItems){
				var obj1 : Object =new Object();
				obj1.grade = gradeDroplist1.selectedItem["value"];
				obj1.teachClasses = getSelectedItemsValue(classDroplist1.list.selectedItems,"value");
				obj1.subject = DataOfPublic.getInstance().subjectData[subjectList.selectedIndex];
				workArray.push(obj1);
			}else{
				Alert.show("没选年级和班级");
				return;
			}
			if(gradeDroplist2.text!=""&&classDroplist2.text!=""&&classDroplist2.list.selectedItems){
				var obj2 : Object =new Object();
				obj2.grade = gradeDroplist2.selectedItem["value"];
				obj2.teachClasses = getSelectedItemsValue(classDroplist2.list.selectedItems,"value");
				obj2.subject = DataOfPublic.getInstance().subjectData[subjectList.selectedIndex];
				workArray.push(obj2);
			}
			if(gradeDroplist3.text!=""&&classDroplist3.text!=""&&classDroplist3.list.selectedItems){
				var obj3 : Object =new Object();
				obj3.grade = gradeDroplist3.selectedItem["value"];
				obj3.teachClasses = getSelectedItemsValue(classDroplist3.list.selectedItems,"value");
				obj3.subject = DataOfPublic.getInstance().subjectData[subjectList.selectedIndex];
				workArray.push(obj3);
			}
		}
		
		/**
		 * 提取 对象元素数组 中的某个已有字段 生成新的数组返回
		 * @param targetVector  包含特定对象的Vector
		 * @param targetValue  对象元素中的特定字段
		 * @return 返回 字段值数组
		 */		
		public function getSelectedItemsValue(targetVector:Vector.<Object>,targetValue:String):Array
		{
			var tempArr : Array = [];
			for each (var i:Object in targetVector) 
			{
				tempArr.push(i[targetValue]);
			}
			return tempArr;
		}		
		
		
	}
}