package com.goshare.view.personalCenter.editMode.blockOfPosition
{
	import com.goshare.components.NewDropList;
	import com.goshare.components.ToggleBtnForGender;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserFormInfo;
	import com.goshare.data.UserInfo;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.render.itemRenderForDropList;
	import com.goshare.util.DataToolForDropList;
	import com.goshare.view.home.LogView;
	import com.goshare.view.regsiter.RegsiterPanelOfInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/*
	注册后 正式发送至服务端的数据格式如下: 
	{
	"gender": "男",
	"duty": [{
	"role": "班主任",
	"teachClasses": ["002", "003"],
	"grade": "001"
	}, {
	"role": "班主任",
	"teachClasses": ["005"],
	"grade": "002"
	}],
	"userFace": "/9POz//Szc7/z83N/8/Nzf/Ozs7/0NDQ/9LQ0P/Qzs7/0c3L/9",
	"userName": "asd",
	"work": [{
	"subject": "数学",
	"teachClasses": ["001", "002"],
	"grade": "001"
	}, {
	"subject": "数学",
	"teachClasses": ["002", "003"],
	"grade": "002"
	}],
	"userId": "13000000000",
	"school": "000000002"
	}
	*/
	
	/**
	 * 班主任负责班级-子块
	 */	
	public class BlockOfPosition extends UIComponent
	{
		public function BlockOfPosition()
		{
			super();
			height = 50;
			EventManager.getInstance().addEventListener("getUserInfoFromServer",getUserInfoFromServer_Handler);///进入“个人中心”触发
			EventManager.getInstance().addEventListener("checkFormInfoToSave",checkFormInfoToSave_Handler);///点击“保存”按钮触发
		}
		
		/**
		 * 进入个人中心，恢复下拉列表组件的选中状态（仅恢复，不包含显示该组件）
		 * @param event
		 */
		protected function getUserInfoFromServer_Handler(event:Event):void
		{
			recoverUserData();
		}
		
		/**
		 * 仅恢复，不包含显示该组件
		 */
		public function recoverUserData():void{
			if(DataOfPublic.getInstance().allDataByRegsiter){
				if(DataOfPublic.getInstance().allDataByRegsiter["duty"]){   ///	duty 字段不为空 则是班主任
					toggleForTrue.selected = true;
					toggleForFalse.selected = false;
					if(DataOfPublic.getInstance().allDataByRegsiter["duty"].length==1){
						pushDataToList1();
						clearLeadDropList2();
					}else if(DataOfPublic.getInstance().allDataByRegsiter["duty"].length==2){
						pushDataToList1(); 
						pushDataToList2();
					}else if(DataOfPublic.getInstance().allDataByRegsiter["duty"].length==0||DataOfPublic.getInstance().allDataByRegsiter["duty"]==null){
						Alert.show("不是班主任");
					}
				}else{
					toggleForTrue.selected = false;
					toggleForFalse.selected = true;
					clearAllLeadDropList();
				}
			}
		}
		
		/**
		 * 显示组件
		 */
		public function showDropList():void{
			if(DataOfPublic.getInstance().allDataByRegsiter==null){
				trace("可能未注册--allDataByRegsiter为null");
				return;
			}
			if(DataOfPublic.getInstance().allDataByRegsiter["duty"]){
				if(DataOfPublic.getInstance().allDataByRegsiter["duty"].length==1){
					showLeadList1();
					pushDataToList1();
					clearLeadDropList2();
				}else if(DataOfPublic.getInstance().allDataByRegsiter["duty"].length==2){
					showLeadList1();
					pushDataToList1();
					showLeadList2();
					pushDataToList2();
				}
			}else{
				Alert.show("不是班主任");
			}
		}
		
		
		/**
		 * 数据恢复至 第一组 年级-班级
		 */
		private function pushDataToList1():void
		{
			///年级 单选
			leadGradeDroplist1.text = DataToolForDropList.getInstance().recoverDropListTxtByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][0]["grade"]);
			leadGradeDroplist1.list.selectedIndex = DataToolForDropList.getInstance().recoverDropListSelectedIndexByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][0]["grade"]);
			///班级 多选
			leadClassDroplist1.text  = DataToolForDropList.getInstance().recoverDropListTxtsByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][0]["teachClasses"]);
			leadClassDroplist1.list.selectedIndices = DataToolForDropList.getInstance().recoveDropListSelectedIndicesByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][0]["teachClasses"]);
		}
		
		/**
		 * 数据恢复至 第二组 年级-班级
		 */
		private function pushDataToList2():void
		{
			///年级 单选
			leadGradeDroplist2.text = DataToolForDropList.getInstance().recoverDropListTxtByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][1]["grade"]);
			leadGradeDroplist2.list.selectedIndex = DataToolForDropList.getInstance().recoverDropListSelectedIndexByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][1]["grade"]);
			///班级 多选
			leadClassDroplist2.text  = DataToolForDropList.getInstance().recoverDropListTxtsByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][1]["teachClasses"]);
			leadClassDroplist2.list.selectedIndices = DataToolForDropList.getInstance().recoveDropListSelectedIndicesByValueArray(DataOfPublic.getInstance().allDataByRegsiter["duty"][1]["teachClasses"]);
		}
		
		/**
		 * 显示第一组  年级-班级
		 */
		private function showLeadList1():void
		{
			leadGradeDroplist1.visible = leadClassDroplist1.visible = true;
			leadGradeDroplist2.visible = leadClassDroplist2.visible = false;
			addIcon2.visible = true;
			removeIcon2.visible = false;
			leadCount=1;
			height = 100;
			invalidateDisplayList();
			invalidateSkin();
			toldNewSizeTofather();
		}
		
		/**
		 * 显示第二组  年级-班级
		 */
		private function showLeadList2():void
		{
			leadGradeDroplist1.visible = leadClassDroplist1.visible = true;
			leadGradeDroplist2.visible = leadClassDroplist2.visible = true;
			addIcon2.visible = removeIcon2.visible = true;
			leadCount=2;
			height = 150;
			invalidateDisplayList();
			invalidateSkin();
			toldNewSizeTofather();
		}
		
		private var saveDataDid : Boolean;
		private var iconLab : Label;
		private var toggleForTrue : ToggleBtnForGender;
		private var toggleForFalse : ToggleBtnForGender;
		private var leadGradeDroplist1 : NewDropList;
		private var leadClassDroplist1 : NewDropList;
		private var leadGradeDroplist2 : NewDropList;
		private var leadClassDroplist2 : NewDropList;
		private var addIcon2 : Image;
		private var removeIcon2 : Image;
		private var leadCount : int = 1;
		override protected function createChildren():void
		{
			super.createChildren();
			
			iconLab = new Label();
			iconLab.fontSize = 16;
			iconLab.text = "班主任：";
			iconLab.bold = true;
			iconLab.fontFamily = FontFamily.STXIHEI;
			addChild(iconLab);
			
			toggleForTrue  = new ToggleBtnForGender();
			toggleForTrue.buttonMode = true;
			toggleForTrue.txtLab = "是";
			toggleForTrue.selected = false;
			//			toggleForTrue.selected = UserInfo.isHeadTeacher;
			toggleForTrue.drawRadius = 5;
			toggleForTrue.height = 24;
			toggleForTrue.width = 100;
			toggleForTrue.labX = 40;
			toggleForTrue.labY = 0;
			toggleForTrue.addEventListener(MouseEvent.CLICK,toggleForTrueHandler);
			addChild(toggleForTrue);
			
			toggleForFalse  = new ToggleBtnForGender();
			toggleForFalse.buttonMode = true;
			toggleForFalse.txtLab = "否";
			toggleForFalse.selected = !toggleForTrue.selected;
			toggleForFalse.drawRadius = 5;
			toggleForFalse.height = 24;
			toggleForFalse.width = 100;
			toggleForFalse.labX = 40;
			toggleForFalse.labY = 0;
			toggleForFalse.addEventListener(MouseEvent.CLICK,toggleForFalseHandler);
			addChild(toggleForFalse);
			
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
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			iconLab.x = 0;
			iconLab.y = 10;
			
			toggleForTrue.x = iconLab.x+80;
			toggleForTrue.y = iconLab.y;
			toggleForFalse.x = toggleForTrue.x+200;
			toggleForFalse.y = toggleForTrue.y;
			
			leadGradeDroplist1.x = iconLab.x+80+leadClassDroplist1.labWidth;
			leadGradeDroplist1.y = toggleForTrue.y+40;
			
			leadClassDroplist1.x = leadGradeDroplist1.x+leadGradeDroplist1.width+leadClassDroplist1.labWidth+15;
			leadClassDroplist1.y = leadGradeDroplist1.y;
			
			leadGradeDroplist2.x = iconLab.x+80+leadClassDroplist2.labWidth;
			leadGradeDroplist2.y = leadClassDroplist1.y+50;
			
			leadClassDroplist2.x = leadGradeDroplist2.x+leadGradeDroplist2.width+leadClassDroplist2.labWidth+15;
			leadClassDroplist2.y = leadGradeDroplist2.y;
			
			addIcon2.y = leadClassDroplist1.y+8;
			addIcon2.x = leadClassDroplist1.x+leadClassDroplist1.width+15;
			removeIcon2.x = addIcon2.x;
			removeIcon2.y = addIcon2.y+36;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xff0000,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
		
		private function toldNewSizeTofather():void
		{
			EventManager.getInstance().dispatchEventQuick("BlockOfPositionNewSize");
		}
		
		private function clearAllLeadDropList():void
		{
			clearLeadDropList1();
			clearLeadDropList2();
			addIcon2.visible = removeIcon2.visible = false;
			leadCount=1;
		}
		
		protected function toggleForFalseHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForTrue.selected = false;
				clearAllLeadDropList();
			}
			height =  50;
			invalidateSkin();
			invalidateDisplayList();
			toldNewSizeTofather();
		}
		
		protected function toggleForTrueHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForFalse.selected = false;
				addIcon2.visible =leadClassDroplist1.visible = leadGradeDroplist1.visible = true
			}
			height = 100;
			invalidateDisplayList();
			invalidateSkin();
			toldNewSizeTofather();
		}
		
		
		protected function addIcon2_Handler(event:MouseEvent):void
		{
			if(leadGradeDroplist1.text!=""&&leadClassDroplist1.text!=""&&leadGradeDroplist2.text==""&&leadClassDroplist2.text==""){
				leadGradeDroplist2.visible = leadClassDroplist2.visible = true;
				removeIcon2.visible = true;
				leadCount=2;
				height = 100+50;
				invalidateDisplayList();
				invalidateSkin();
				toldNewSizeTofather();
			}
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
				height = 100;
			}
			invalidateDisplayList();
			invalidateSkin();
			toldNewSizeTofather();
		}
		
		private function clearLeadDropList1():void
		{
			leadGradeDroplist1.text = "";
			leadGradeDroplist1.list.selectedIndex = -1;
			
			leadClassDroplist1.text = "";
			leadClassDroplist1.mySelectedItems = [];
			leadClassDroplist1.list.selectedIndex = -1;
			leadClassDroplist1.list.selectedIndices = new Vector.<int>();
			
			leadGradeDroplist1.visible = leadClassDroplist1.visible = false;
		}
		
		private function clearLeadDropList2():void
		{
			leadGradeDroplist2.text = "";
			leadGradeDroplist2.list.selectedIndex = -1;
			
			leadClassDroplist2.text = "";
			leadClassDroplist2.mySelectedItems = [];
			leadClassDroplist2.list.selectedIndex = -1;
			leadClassDroplist2.list.selectedIndices = new Vector.<int>();
			
			leadGradeDroplist2.visible = leadClassDroplist2.visible = false;
		}
		
		/**
		 * 监听到要保存上传 最新的表单数据 至服务端
		 */
		protected function checkFormInfoToSave_Handler(e:TestEvent):void
		{
			getNewDutyDataToFrom();
		}
		
		/**
		 * 整理 两个 年级班级的DropList 选中状态 
		 * 生成 duty 字段数据  发往后台
		 */	
		private function getNewDutyDataToFrom():void
		{
			if(toggleForTrue.selected&&leadGradeDroplist1.text!=""&&leadClassDroplist1.text!=""){
				var tempArray1 : Array = [];
				var dutyArray : Array = [];
				tempArray1.push(toggleForTrue.selected?"班主任":"");
				
				var leadObj1 : Object = new Object();
				leadObj1.role = tempArray1[0]
				leadObj1.grade = DataToolForDropList.getInstance().transDropListTxtToValueArray(leadGradeDroplist1.text);
				leadObj1.teachClasses = DataToolForDropList.getInstance().transDropListTxtsToValueArray(leadClassDroplist1.text);
				dutyArray.push(leadObj1);
			}else{
				UserInfo.duty = null;
				UserFormInfo.duty = null;
			}
			
			if(toggleForTrue.selected&&leadGradeDroplist2.text!=""&&leadClassDroplist2.text!=""&&leadClassDroplist2.mySelectedItems!=[]){
				var leadObj2 : Object =new Object();
				leadObj2.role = tempArray1[0]
				leadObj2.grade = DataToolForDropList.getInstance().transDropListTxtToValueArray(leadGradeDroplist2.text);
				leadObj2.teachClasses = DataToolForDropList.getInstance().transDropListTxtsToValueArray(leadClassDroplist2.text);
				dutyArray.push(leadObj2);
			}
			
			UserFormInfo.duty = dutyArray;
		}
		
	}
}