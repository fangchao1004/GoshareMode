
package com.goshare.view.robot
{
	import com.goshare.components.IconLabButton;
	import com.goshare.components.LabColorBtnWithChange;
	import com.goshare.components.TxtInputIconPlcHold;
	import com.goshare.data.DataOfPublic;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.render.ItemRenderForAllRbtList;
	import com.goshare.util.FuzzyQuery_new;
	import com.goshare.view.file.FileAddView;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.DropDownList;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	public class RobotAddView extends UIComponent
	{
		public function RobotAddView()
		{
			super();
			width = 680;
			height = 510;
			///监听到listchange
			AppRCManager.getInstance().addEventListener(AppRCManagerEvent.RC_LIST_CHAGNED,rcListChagned_Handler);
		}
		
		protected function rcListChagned_Handler(event:AppRCManagerEvent):void
		{
			///重新赋值
			getAllRobotList.dataProvider = AppRCManager.getInstance().clients;
//			trace(JSON.stringify(AppRCManager.getInstance().clients));
		}
		
		private static var instance:RobotAddView;
		
		public static function getInstance():RobotAddView
		{
			if (!instance)
				instance = new RobotAddView();
			
			return instance;
		}
		
		private var notFoundImg : Image;
		
		private var titleLab : Label;
		private var closeBtn : Image;
		private var searchBtn : IconLabButton;
		private var searchInput : TxtInputIconPlcHold;
		private var getAllRobotList : List;
		private var okBtn : LabColorBtnWithChange;
		private var cancelBtn : LabColorBtnWithChange;
		private var selectedRobotVector :Vector.<Object> ;
		
		private var statusLab : Label;
		private var classLab : Label;
		private var nameLab : Label;
		private var idLab : Label;
		private var selectLab : Label;
		
		private var keyWord : String;
		private var time : uint;
		
		private var shadow : DropShadowFilter;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.text = "添加机器人";
			titleLab.fontFamily = FontFamily.STXIHEI;
			titleLab.bold = true;
			titleLab.fontSize = 26;
			titleLab.bold = true;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			closeBtn = new Image();
			closeBtn.source = "assets/interactive/closeBtn.png";
			closeBtn.width = closeBtn.height = 19;
			closeBtn.buttonMode = true;
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_Handler);
			addChild(closeBtn);
			
			searchInput = new TxtInputIconPlcHold();
			searchInput.radius = 15;
			searchInput.height = 35;
			searchInput.maxChars = 10;
			searchInput.fontFamily = "Microsoft YaHei";
			searchInput.fontSize = 18;
			searchInput.color = 0x888888;
			searchInput.backgroundColor = 0xf0f5fe;
			searchInput.placeHold = "输入机器人编号、昵称、班级搜索机器人";
			searchInput.addEventListener(UIEvent.CHANGE,searchInput_changeHandler);
			addChild(searchInput);
			
			searchBtn = new IconLabButton();
			searchBtn.sourceArray = ["search_1.png","search_2.png"];
			searchBtn.labText = "搜索";
			searchBtn.width = 100;
			searchBtn.height = 38;
			addChild(searchBtn);
			searchBtn.visible = false;
			
			
			getAllRobotList = new List();
//			getAllRobotList.allowMultipleSelection = true;
			getAllRobotList.itemRendererHeight = 42;
			getAllRobotList.width = width-40;
			getAllRobotList.height = 330;
			getAllRobotList.dataProvider = AppRCManager.getInstance().clients;
//			trace(AppRCManager.getInstance().clients);
			getAllRobotList.labelField = "name";
			getAllRobotList.itemRendererClass = ItemRenderForAllRbtList;
			getAllRobotList.addEventListener(UIEvent.CHANGE,getAllRobotList_SelectHandler);
			addChild(getAllRobotList);
			
			okBtn = new LabColorBtnWithChange();
			okBtn.width = 120;
			okBtn.height = 35;
			okBtn.fontSize = 18;
			okBtn.color = 0x5c9dfd;
			okBtn.radius = 35;
			okBtn.label = "添加";
			okBtn.fontFamily = "Microsoft  YaHei";
			okBtn.buttonMode = true;
			okBtn.addEventListener(MouseEvent.CLICK,okBtn_handler);
			addChild(okBtn);
			
			cancelBtn =new LabColorBtnWithChange();
			cancelBtn.width = 120;
			cancelBtn.height = 35;
			cancelBtn.fontSize = 18;
			cancelBtn.color = 0x5c9dfd;
			cancelBtn.radius = 35;
			cancelBtn.label = "取消";
			cancelBtn.fontFamily = "Microsoft  YaHei";
			cancelBtn.buttonMode = true;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtn_handler);
			addChild(cancelBtn);
			
			statusLab = new Label();
			statusLab.text = "信号";
			statusLab.fontFamily = "Microsoft YaHei";
			statusLab.fontSize = 16;
			addChild(statusLab);
			
			classLab = new Label();
			classLab.text = "班级";
			classLab.fontFamily = "Microsoft YaHei";
			classLab.fontSize = 16;
			addChild(classLab);
			
			nameLab = new Label();
			nameLab.text = "昵称";
			nameLab.fontFamily = "Microsoft YaHei";
			nameLab.fontSize = 16;
			addChild(nameLab);
			
			idLab = new Label();
			idLab.text = "机器人编号";
			idLab.fontFamily = "Microsoft YaHei";
			idLab.fontSize = 16;
			addChild(idLab);
			
			selectLab = new Label();
			selectLab.text = "选择";
			selectLab.fontFamily = "Microsoft YaHei";
			selectLab.fontSize = 16;
			addChild(selectLab);
			
			notFoundImg = new Image();
			notFoundImg.width = notFoundImg.height = 200;
			notFoundImg.source = "assets/interactive/not_found.png";
			addChild(notFoundImg);
			notFoundImg.visible = false;
			
			shadow= new DropShadowFilter();
			with (shadow) {
				distance = 5;
				angle = 45;
				alpha = .25;
				blurX = 6;
				blurY = 6;
				color = 0x999999;
				hideObject = false;
				inner = false;
				knockout = false;
				quality = 1;
				strength = 1;
			}
			
			okBtn.filters = cancelBtn.filters = [shadow];
		}
		
		protected function closeBtn_Handler(event:MouseEvent):void
		{
			resetListSelected();
			resetSearchInput();
		}		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.x = 30;
			titleLab.y = (65-titleLab.fontSize)/2;
			
			closeBtn.x = width-closeBtn.width-19;
			closeBtn.y = (65-closeBtn.height)/2;
			
			getAllRobotList.x = (width-getAllRobotList.width)/2;
			getAllRobotList.y = 120;
			
			statusLab.x = getAllRobotList.x+50;
			statusLab.y = getAllRobotList.y-statusLab.fontSize-12;
			
			searchBtn.x = getAllRobotList.x+getAllRobotList.width-searchBtn.width;
			searchBtn.y = statusLab.y-searchBtn.height-6;
			
			searchInput.x = 270;
			searchInput.y = (65-searchInput.height)/2;
			searchInput.width = 350;
			searchInput.height = searchBtn.height;
			
			classLab.x = statusLab.x+120;
			classLab.y = statusLab.y;
			
			nameLab.x = classLab.x+130;
			nameLab.y = statusLab.y;
			
			idLab.x =  nameLab.x+130;
			idLab.y = statusLab.y;
			
			
			selectLab.x =  idLab.x+160;
			selectLab.y = statusLab.y;
			
			okBtn.x = width/2-okBtn.width-15;
			cancelBtn.x = width/2+15;
			
			okBtn.y =cancelBtn.y =  height-okBtn.height-10;
			
			notFoundImg.x = (width-notFoundImg.width)/2;
			notFoundImg.y = getAllRobotList.y+10;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xedeaea);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(20,80,width-40,getAllRobotList.height+40)
			graphics.endFill();
			
			graphics.beginFill(0x5c9dfd);
			graphics.drawRect(0,0,width,65);
			graphics.endFill();
		}
		
		/**
		 * 确定添加
		 */
		protected function okBtn_handler(event:MouseEvent):void
		{
			/*trace("items 数组："+JSON.stringify(getAllRobotList.selectedItems));
			trace("index数组："+JSON.stringify(getAllRobotList.selectedIndices));
			trace("准备添加的数据包含：",JSON.stringify(selectedRobotVector));*/
			
			///将数据进行过滤 去除online==false的对象数据
			if(selectedRobotVector!=null)
			{
				filterHandler(selectedRobotVector);
//				trace("过滤后的数据是："+JSON.stringify(selectedRobotVector));
				//要将数据传递到 当前机器人控制列表中
				//派发自定义事件
				var addRobotEvent : TestEvent = new TestEvent(TestEvent.ADD_ROBOT);
				addRobotEvent.data = selectedRobotVector;
				EventManager.getInstance().dispatchEvent(addRobotEvent)
			}else
			{
				trace("可能未选择数据添加");
			}
			
			resetListSelected();
			resetSearchInput();
		}
		
		/*private function deleteDefineIndex():void
		{
		for (var i:int = 0; i < selectedRobotVector.length; i++) 
		{
		testData[getAllRobotList.selectedIndices[i]]=null
		}
		
		for (var j:int = 0; j < testData.length; j++) 
		{
		if(testData[j]==null)
		{
		testData.splice(j,1);
		j--;
		DataRefreshHandler();
		}
		}
		}*/
		
		/*private function DataRefreshHandler():void
		{
		getAllRobotList.selectedIndex = -1;
		invalidateProperties();
		getAllRobotList.dataProvider = testData;
		}*/
		
		/**
		 * 过滤数据  obj数据 数组  过滤离线对象
		 * @param selectedRobotVector
		 */
		private function filterHandler(selectedRbtVector:Vector.<Object>):void
		{
			for (var i:int = 0; i < selectedRbtVector.length; i++) 
			{
				if(selectedRbtVector[i]["online"]==false)
				{
					selectedRbtVector[i] = null;
				}
			}
			for (var j:int = 0; j < selectedRbtVector.length; j++) 
			{
				if(selectedRbtVector[j]==null)
				{
					selectedRbtVector.splice(j,1);
					j--;
				}
			}
		}
		
		/**
		 * 重置list选择状态
		 * @param exit  是否为离开
		 */
		private function resetListSelected(exit:Boolean=true):void
		{
			//清除list中 选中的对象
			var selectedInices:Vector.<int> = new Vector.<int>();
			getAllRobotList.selectedIndex = -1;
			getAllRobotList.selectedIndices = selectedInices;
			selectedRobotVector = null;
			
			if(exit)
				PopUpManager.removePopUp(this);
		}
		
		private function resetSearchInput():void
		{
			///清空搜索框中的数据
			searchInput.text ="";
			searchInput.HandChange = true;
			getAllRobotList.dataProvider = AppRCManager.getInstance().clients;
			notFoundImg.visible = false;			
		}		
		
		
		protected function getAllRobotList_SelectHandler(e:UIEvent):void
		{
			//			trace(String(e.currentTarget.selectedIndex));
			//			trace(JSON.stringify(e.currentTarget.selectedIndices));
			//			trace(JSON.stringify(e.currentTarget.selectedItems));
			//			trace("选中的对象包含："+JSON.stringify(e.currentTarget.selectedItems));
			
			///每次选择变换后 将所有选中的数据（selectedItems）进行重新赋值
			selectedRobotVector = e.currentTarget.selectedItems;
		}
		
		protected function cancelBtn_handler(event:MouseEvent):void
		{
			resetListSelected();
			resetSearchInput();
		}
		
		protected function searchInput_changeHandler(event:UIEvent):void
		{
			keyWord = event.currentTarget.text;
			if(time)
				clearTimeout(time);
			time = setTimeout(searchHandler,500);
		}
		
		private function searchHandler():void
		{
			///当开始搜索时，原先被选中的对象都被清空
			resetListSelected(false);
			var result : Array =FuzzyQuery_new.getInstance().searchHandler(keyWord,AppRCManager.getInstance().clients,"id","name","classInfo");
			if(result.length==0)
			{
//				notFoundImg.visible = true;
			}else
			{
				notFoundImg.visible = false;
			}
			getAllRobotList.dataProvider = result;
		}
	}
}