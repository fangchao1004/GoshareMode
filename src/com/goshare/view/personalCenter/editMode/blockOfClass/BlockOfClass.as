package com.goshare.view.personalCenter.editMode.blockOfClass
{
	import com.goshare.components.NewDropList;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserFormInfo;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.EventManager;
	import com.goshare.render.itemRenderForDropList;
	import com.goshare.util.DataToolForDropList;
	import com.goshare.view.regsiter.RegsiterPanelOfInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class BlockOfClass extends UIComponent
	{
		public function BlockOfClass()
		{
			super();
			height = 120;
			EventManager.getInstance().addEventListener("getUserInfoFromServer",getUserInfoFromServer_Handler);///进入“个人中心”触发
		}
		
		protected function getUserInfoFromServer_Handler(event:Event):void
		{
			recoverClassData();
		}
		
		/**
		 * 恢复组件的数据--在监听到进入“个人中心”的事件
		 * 仅恢复--不显示
		 */
		public function recoverClassData():void
		{
			var allData : Object = DataOfPublic.getInstance().allDataByRegsiter;
			if(allData){
				if(allData["work"].length==1){
					getDropList1Data();
					clearDropList2();
					clearDropList3();
				}else if(allData["work"].length==2){
					getDropList1Data();
					getDropList2Data();
					clearDropList3();
				}else if(allData["work"].length==3){
					getDropList1Data();
					getDropList2Data();
					getDropList3Data();
				}
			}else{
				trace("allDataByRegsiterd为null--可能未注册");
			}
		}
		
		/**
		 * 根据数据-work字段判断，显示对应组件
		 * 仅做显示
		 * 
		 * ///只有在DropList的visible==true的情况下，其中的list的选中索引情况classDroplist1.list.selectedIndices赋值才有显示，所以此处再次执行getDropList_Data()
		 */
		public function showDropList():void
		{
			var allData : Object = DataOfPublic.getInstance().allDataByRegsiter;
			if(allData){
				if(allData["work"].length==1){
					showDropList1();///只有在DropList的visible==true的情况下，其中list的选中索引情况classDroplist1.list.selectedIndices赋值才有显示，所以此处再次执行getDropList_Data()
					getDropList1Data();
					clearDropList2();
					clearDropList3();
				}else if(allData["work"].length==2){
					showDropList1();
					getDropList1Data();
					showDropList2();
					getDropList2Data();
					clearDropList3();
				}else if(allData["work"].length==3){
					showDropList1();
					getDropList1Data();
					showDropList2();
					getDropList2Data();
					showDropList3();
					getDropList3Data();
				}
			}else{
				trace("可能未注册--allDataByRegsiter为null");
			}
		}
		
		private function getDropList1Data():void
		{
			gradeDroplist1.text = DataToolForDropList.getInstance().recoverDropListTxtByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][0]["grade"]);
			gradeDroplist1.list.selectedIndex = DataToolForDropList.getInstance().recoverDropListSelectedIndexByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][0]["grade"]);
			classDroplist1.text = DataToolForDropList.getInstance().recoverDropListTxtsByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][0]["teachClasses"]);
			classDroplist1.list.selectedIndices = DataToolForDropList.getInstance().recoveDropListSelectedIndicesByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][0]["teachClasses"]);
		}
		
		private function getDropList2Data():void
		{
			gradeDroplist2.text = DataToolForDropList.getInstance().recoverDropListTxtByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][1]["grade"]);
			gradeDroplist2.list.selectedIndex = DataToolForDropList.getInstance().recoverDropListSelectedIndexByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][1]["grade"]);
			classDroplist2.text = DataToolForDropList.getInstance().recoverDropListTxtsByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][1]["teachClasses"]);
			classDroplist2.list.selectedIndices = DataToolForDropList.getInstance().recoveDropListSelectedIndicesByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][1]["teachClasses"]);
		}
		
		private function getDropList3Data():void
		{
			gradeDroplist3.text = DataToolForDropList.getInstance().recoverDropListTxtByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][2]["grade"]);
			gradeDroplist3.list.selectedIndex = DataToolForDropList.getInstance().recoverDropListSelectedIndexByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][2]["grade"]);
			classDroplist3.text = DataToolForDropList.getInstance().recoverDropListTxtsByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][2]["teachClasses"]);
			classDroplist3.list.selectedIndices = DataToolForDropList.getInstance().recoveDropListSelectedIndicesByValueArray(DataOfPublic.getInstance().allDataByRegsiter["work"][2]["teachClasses"]);
		}
		
		private var gradeLab : Label;
		private var gradeDroplist1 : NewDropList;
		private var classDroplist1 : NewDropList;
		private var gradeDroplist2 : NewDropList;
		private var classDroplist2 : NewDropList;
		private var gradeDroplist3 : NewDropList;
		private var classDroplist3 : NewDropList;
		private var addIcon : Image;
		private var removeIcon : Image;
		public var count : int=1;
		private var okBtn : Button;
		private var cancelBtn : Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
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
				
			okBtn = new Button();
			okBtn.radius = 10;
			okBtn.width = 100;
			okBtn.height = 30;
			okBtn.fontSize = 16;
			okBtn.color = 0xffffff;
			okBtn.backgroundColor = 0x5c9dfd;
			okBtn.label = "保存";
			okBtn.fontFamily = FontFamily.STHEITI;
			okBtn.buttonMode = true;
			okBtn.addEventListener(MouseEvent.CLICK,saveData_handler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.radius = 10;
			cancelBtn.width = 100;
			cancelBtn.height = 30;
			cancelBtn.fontSize = 16;
			cancelBtn.borderColor = 0x5c9dfd;
			cancelBtn.color = 0x5c9dfd;
			cancelBtn.backgroundColor = 0xffffff;
			cancelBtn.label = "取消";
			cancelBtn.fontFamily = FontFamily.STHEITI;
			cancelBtn.buttonMode = true;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtn_handler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			gradeLab.x = 0;
			gradeLab.y = 20;
			gradeDroplist1.x = gradeLab.x+gradeDroplist1.labWidth+80;
			gradeDroplist1.y = gradeLab.y-5;
			
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
			
			okBtn.x = gradeLab.x+80;
			okBtn.y = gradeLab.y+count*50
				
			cancelBtn.x = okBtn.x+okBtn.width+15;
			cancelBtn.y = okBtn.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xff0000,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
		
		protected function addIcon_Handler(event:MouseEvent):void
		{
			if(gradeDroplist1.text!=""&&classDroplist1.text!=""&&gradeDroplist2.text==""&&classDroplist2.text==""&&gradeDroplist3.text==""&&classDroplist3.text==""){
				gradeDroplist2.visible = classDroplist2.visible = true;
				gradeDroplist3.visible = classDroplist3.visible = false;
				removeIcon.visible = true;
				count=2;
				height = 120+50;
				invalidateDisplayList();
				invalidateSkin();
				toldNewSizeTofather();
			}
			else if(gradeDroplist1.text!=""&&classDroplist1.text!=""&&gradeDroplist2.text!=""&&classDroplist2.text!=""&&gradeDroplist3.text==""&&classDroplist3.text==""){
				gradeDroplist3.visible = classDroplist3.visible = true;
				count=3;
				height = 120+50+50;
				invalidateDisplayList();
				invalidateSkin();
				toldNewSizeTofather();
			}
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
				height = 120;
			}else if(count==2){
				clearDropList3()
				height = 120+50;
			}
			invalidateDisplayList();
			toldNewSizeTofather();
		}
		
		private function toldNewSizeTofather():void
		{
			EventManager.getInstance().dispatchEventQuick("BlockOfClassNewSize");
		}
		
		private function clearDropList3():void
		{
			gradeDroplist3.text = "";
			gradeDroplist3.list.selectedIndex = -1;
			
			classDroplist3.text = "";
			classDroplist3.mySelectedItems = [];
			classDroplist3.list.selectedIndex = -1;
			classDroplist3.list.selectedIndices = new Vector.<int>();
			
			gradeDroplist3.visible = classDroplist3.visible = false;
		}
		
		private function clearDropList2():void
		{
			gradeDroplist2.text = "";
			gradeDroplist2.list.selectedIndex = -1;
			
			classDroplist2.text = "";
			classDroplist2.mySelectedItems = [];
			classDroplist2.list.selectedIndex = -1;
			classDroplist2.list.selectedIndices = new Vector.<int>();
			
			gradeDroplist2.visible = classDroplist2.visible = false;
		}
		
		private function showDropList1():void
		{
			gradeDroplist1.visible = classDroplist1.visible = true;
			height = 120;
			removeIcon.visible = false;
			count = 1;
			invalidateDisplayList();
		}
		
		private function showDropList2():void
		{
			gradeDroplist2.visible = classDroplist2.visible = true;
			height = 170;
			removeIcon.visible = true;
			count = 2;
			invalidateDisplayList();
		}
		
		private function showDropList3():void
		{
			gradeDroplist3.visible = classDroplist3.visible = true;
			height = 220;
			removeIcon.visible = true;
			count = 3;
			invalidateDisplayList();
		}
		
		/**
		 * 点击保存按钮 - 保存新的数据  通知其他几个 BlockOf_xxxx 整理数据
		 * 最主要是 整理DropList的选中状态  整合成一个 work 和 duty 字段存储在 UserFormInfo 中
		 * 自身在此类中整理 教学年级和班级数据构成 work 字段 
		 * 通知 BlockOfPosition  整理  班主任负责的年级和班级  duty 字段
		 */		
		protected function saveData_handler(event:MouseEvent):void
		{
			checkWorkData();
			///通知其他几个 BlockOf_xxxx 整理数据
			EventManager.getInstance().dispatchEventQuick("checkFormInfoToSave");
		}
		
		/**
		 * 整理 三个 年级班级的DropList 选中状态 
		 * 生成 work 字段数据
		 */		
		private function checkWorkData():void
		{
			//////work字段获取数值  用户作为某课老师教学的年级和班级对象 的数组
			if(gradeDroplist1.text!=""&&classDroplist1.text!=""){
				var obj1 : Object =new Object();
				obj1.grade = DataToolForDropList.getInstance().transDropListTxtToValueArray(gradeDroplist1.text);
				obj1.teachClasses = DataToolForDropList.getInstance().transDropListTxtsToValueArray(classDroplist1.text);
				obj1.subject = DataOfPublic.getInstance().subjectData[UserFormInfo.userProjectIndex];   ///课目
				var workArray : Array = [];
				workArray.push(obj1);
			}else
			{
				Alert.show("没选年级和班级");
				return;
			}
			
			if(gradeDroplist2.text!=""&&classDroplist2.text!=""&&classDroplist2.mySelectedItems!=[]){
				var obj2 : Object =new Object();
				obj2.grade = DataToolForDropList.getInstance().transDropListTxtToValueArray(gradeDroplist2.text);
				obj2.teachClasses = DataToolForDropList.getInstance().transDropListTxtsToValueArray(classDroplist2.text);
				obj2.subject = DataOfPublic.getInstance().subjectData[UserFormInfo.userProjectIndex];  ///课目
				workArray.push(obj2);
			}
			
			if(gradeDroplist3.text!=""&&classDroplist3.text!=""&&classDroplist3.mySelectedItems!=[]){
				var obj3 : Object =new Object();
				obj3.grade = DataToolForDropList.getInstance().transDropListTxtToValueArray(gradeDroplist3.text);
				obj3.teachClasses = DataToolForDropList.getInstance().transDropListTxtsToValueArray(classDroplist3.text);
				obj3.subject = DataOfPublic.getInstance().subjectData[UserFormInfo.userProjectIndex];  ///课目
				workArray.push(obj3);
			}
			
			///将workArray 存入 UserFormInfo 的对应字段中
			UserFormInfo.work = workArray;
//			trace("表单中的教学work数据："+JSON.stringify(UserFormInfo.work));
			
			///100ms延时是为了让其他block将数据都有时间存放进UserFormInfo这个类中
			setTimeout(getAllFormData,100);
		}
		
		private function getAllFormData():void
		{
			///整理数据
			var finalUserFormInfo : Object = new Object();
			finalUserFormInfo.userId = UserFormInfo.userId;
			finalUserFormInfo.duty = UserFormInfo.duty;
			finalUserFormInfo.work = UserFormInfo.work;
			finalUserFormInfo.school = UserFormInfo.school;
			finalUserFormInfo.userName = UserFormInfo.userName;
			finalUserFormInfo.userFace= UserFormInfo.userFace;
			finalUserFormInfo.gender = UserFormInfo.userGender;
			finalUserFormInfo.userBirthday = UserFormInfo.userBirthday;
			finalUserFormInfo.userAddress = UserFormInfo.userAddress;
			finalUserFormInfo.userNativePlace = UserFormInfo.userNativePlace;
			trace("最终生成的表单数据为:");
			trace(JSON.stringify(finalUserFormInfo));
			trace("===============");
		}
		
		/**点击取消按钮*/
		protected function cancelBtn_handler(event:MouseEvent):void
		{
			trace("点击取消按钮");
		}
	}
}