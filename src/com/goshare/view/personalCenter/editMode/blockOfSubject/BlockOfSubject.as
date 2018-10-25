package com.goshare.view.personalCenter.editMode.blockOfSubject
{
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserFormInfo;
	import com.goshare.data.UserInfo;
	import com.goshare.manager.EventManager;
	import com.goshare.render.itemRenderForProjectList;
	
	import flash.events.Event;
	
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	/**
	 * 课目-块
	 */
	public class BlockOfSubject extends UIComponent
	{
		public function BlockOfSubject()
		{
			super();
			EventManager.getInstance().addEventListener("getUserInfoFromServer",getUserInfoFromServer_Handler);///进入“个人中心”触发
		}
		
		private var projectLab : Label;
		private	 var subjectList : List;
		override protected function createChildren():void
		{
			super.createChildren();
			
			projectLab = new Label();
			projectLab.fontSize = 16;
			projectLab.text = "科    目：";
			projectLab.bold = true;
			projectLab.fontFamily = FontFamily.STXIHEI;
			addChild(projectLab);
			
			subjectList = new List();
			subjectList.height = 80;
			subjectList.width = 290;
			subjectList.itemRendererColumnCount = 4;
			subjectList.gap = 15;
			subjectList.itemRendererClass = itemRenderForProjectList;
			subjectList.dataProvider = DataOfPublic.getInstance().subjectData;
			//			subjectList.allowMultipleSelection = true;
			subjectList.selectedIndex = 0;  ///默认选中第一个
			subjectList.addEventListener(UIEvent.CHANGE,subjectList_ChangeHandler);
			addChild(subjectList);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			projectLab.x = 0;
			projectLab.y = 10;
			
			subjectList.x = projectLab.x+80;
			subjectList.y = projectLab.y-7;
		}
		
		///课目列表进行选择
		protected function subjectList_ChangeHandler(event:UIEvent):void
		{
			///一旦发生重新选择 课目列表 进行表单信息的重新赋值
			 UserFormInfo.userProjectIndex=subjectList.selectedIndex;
			 UserFormInfo.userProject = String(subjectList.selectedItem);  ///以字符串为元素的数组
		}
		
		protected function getUserInfoFromServer_Handler(event:Event):void
		{
			recoverSubjectData();///恢复数据
		}
		
		/**
		 * 恢复数据-恢复选中状态
		 * 根据allDataByRegsiter
		 */
		private function recoverSubjectData():void
		{
			if(!DataOfPublic.getInstance().allDataByRegsiter){
				return;
			}
			var selectedSubject : String = DataOfPublic.getInstance().allDataByRegsiter["work"][0]["subject"];
			if(selectedSubject){
				for (var i:int = 0; i < DataOfPublic.getInstance().subjectData.length; i++) 
				{
					if(DataOfPublic.getInstance().subjectData[i]==selectedSubject){
						subjectList.selectedIndex = i;
						UserFormInfo.userProjectIndex = i;
					}
				}
			}
		}
		
		/**
		 * 显示课目列表
		 */
		public function showSubjectList():void
		{
			recoverSubjectData();
		}
	}
}