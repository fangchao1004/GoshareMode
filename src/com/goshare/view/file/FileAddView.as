package com.goshare.view.file
{
	import com.goshare.components.LabColorBtnWithChange;
	import com.goshare.components.TxtInputIconPlcHold;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.EventManager;
	import com.goshare.render.ItemRenderForAllFileList;
	import com.goshare.render.ItemRenderForCategoryList;
	import com.goshare.util.FuzzyQuery_new;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	public class FileAddView extends UIComponent
	{
		public function FileAddView()
		{
			super();
			width = 920;
			height = 580;
		}
		
		private static var instance:FileAddView;
		
		public static function getInstance():FileAddView
		{
			if (!instance)
				instance = new FileAddView();
			
			return instance;
		}
		
		private var titleLab : Label;
		private var closeBtn : Image;
		private var searchInput : TxtInputIconPlcHold;
		private var getAllFileList : List;
		private var categoryList : List;
		private var localUpLoadBtn : Image;
		private var localUpLoadLab : Label;
		private var okBtn : LabColorBtnWithChange;
		private var cancelBtn : LabColorBtnWithChange;
		
		private var testData : Array;
		private var keyWord : String;
		private var time : uint;
		
		private var shadow : DropShadowFilter;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			testData = [{"name":"课件4: 龟兔赛跑，蚂蚁过河。","fileType":"sb2","time":"10:00","source":"课件的服务器地址","updateTime":"2014-8-10","id":"001"},{"name":"课件8","fileType":"word","time":"12:00","source":"课件的服务器地址","updateTime":"2020-8-10","id":"002"},
				{"name":"课件2","fileType":"sb2","time":"5:00","source":"课件的服务器地址","updateTime":"2018-9-10","id":"003"},{"name":"课件4","fileType":"ppt","time":"8:00","source":"课件的服务器地址","updateTime":"2018-8-10","id":"004"},{"name":"课件5","fileType":"ppt","time":"4:00","source":"课件的服务器地址","updateTime":"2011-12-10","id":"005"}
				,{"name":"闰土和猹三味书屋朝花夕拾。藤野先生。三国演义。","fileType":"sb2","time":"8:00","source":"课件的服务器地址","updateTime":"2018-8-10","id":"006"},{"name":"课件1","fileType":"sb2","time":"4:00","source":"课件的服务器地址","updateTime":"2013-6-10","id":"007"}];
			
			titleLab = new Label();
			titleLab.text = "我的课件";
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
			searchInput.fontFamily = FontFamily.STXIHEI;
			searchInput.bold = true;
			searchInput.fontSize = 18;
			searchInput.color = 0x888888;
			searchInput.backgroundColor = 0xf0f5fe;
//			searchInput.placeHold = "搜索";
			searchInput.placeHold = "输入文件名、文件类型、上传时间搜索文件";
			searchInput.addEventListener(UIEvent.CHANGE,searchInput_changeHandler);
			addChild(searchInput);
			
			getAllFileList = new List();
			getAllFileList.allowMultipleSelection = true;
			getAllFileList.itemRendererHeight = 42;
			getAllFileList.width = 605;
			getAllFileList.height = 440;
			getAllFileList.dataProvider = testData;
			getAllFileList.labelField = "name";
			getAllFileList.itemRendererClass = ItemRenderForAllFileList;
//			getAllFileList.addEventListener(UIEvent.CHANGE,getAllFileList_SelectHandler);
			addChild(getAllFileList);
			
			categoryList = new List();
			categoryList.width = 100;
			categoryList.height = 430;
			categoryList.itemRendererHeight = 42;
			categoryList.gap = 10;
			categoryList.verticalScrollEnabled = false;
//			categoryList.dataProvider = [{"name":"全部","fileType":"all"},{"name":"sb2文件","fileType":"sb2"},{"name":"word文件","fileType":"word"}];
			categoryList.dataProvider = [{"name":"全部","fileType":"allFile"},{"name":"分类1","fileType":"category"},{"name":"分类2","fileType":"category"}];
			categoryList.labelField = "name";
			categoryList.itemRendererClass = ItemRenderForCategoryList;
			categoryList.selectedIndex = 0;
			addChild(categoryList);
			
			localUpLoadBtn= new Image();
			localUpLoadBtn.source = "assets/file/localUpLoad.png";
			localUpLoadBtn.buttonMode = true;
			localUpLoadBtn.addEventListener(MouseEvent.CLICK,localUpLoad_Handler);
			addChild(localUpLoadBtn);
			
			localUpLoadLab = new Label();
			localUpLoadLab.text = "本地上传";
			localUpLoadLab.buttonMode = true;
			localUpLoadLab.fontFamily = "Microsoft YaHei";
			localUpLoadLab.fontSize = 20;
			localUpLoadLab.color = 0x1a1a1a;
			localUpLoadLab.addEventListener(MouseEvent.CLICK,localUpLoad_Handler);
			addChild(localUpLoadLab);
			
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
		
		protected function localUpLoad_Handler(event:MouseEvent):void
		{
			trace("本地上传");
		}		
		
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.x = 30;
			titleLab.y = (65-titleLab.fontSize)/2;
			
			closeBtn.x = width-closeBtn.width-19;
			closeBtn.y = (65-closeBtn.height)/2;
			
			searchInput.width = 380;
			searchInput.height = 38;
			searchInput.x = width-searchInput.width-60;
			searchInput.y = (65-searchInput.height)/2;
			
			getAllFileList.x = 145;
			getAllFileList.y = 80;
			
			categoryList.x = 30;
			categoryList.y = 90;
			
			localUpLoadBtn.x = 780;
			localUpLoadBtn.y = 240;
			
			localUpLoadLab.x = 790;
			localUpLoadLab.y = 310;
			
			okBtn.x = width/2-okBtn.width-15;
			cancelBtn.x = width/2+15;
			
			okBtn.y =cancelBtn.y =  height-okBtn.height-10;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xedeaea);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
			
			/*graphics.beginFill(0xffffff);
			graphics.drawRect(20,80,width-40,400+40)
			graphics.endFill();*/
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(20,80,120,400+40)
			graphics.endFill();
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(145,80,getAllFileList.width,400+40)
			graphics.endFill();
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(145+getAllFileList.width+10,80,140,400+40)
			graphics.endFill();
			
			graphics.beginFill(0x5c9dfd);
			graphics.drawRect(0,0,width,65);
			graphics.endFill();
			
			graphics.lineStyle(1,0xedeaea);
			graphics.moveTo(770,90);
			graphics.lineTo(770+120,90);
			graphics.lineTo(770+120,90+420);
			graphics.lineTo(770,90+420);
			graphics.lineTo(770,90);
			graphics.endFill();
		}
		
		protected function closeBtn_Handler(event:MouseEvent):void
		{
			categoryList.selectedIndex = 0;
			PopUpManager.removePopUp(this);
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
			var result : Array = FuzzyQuery_new.getInstance().searchHandler(keyWord,testData,"name","fileType","updateTime");
			getAllFileList.dataProvider = result;
		}
		
		protected function okBtn_handler(event:MouseEvent):void
		{
			var addFileEvent : TestEvent = new TestEvent(TestEvent.ADD_FILE);
			addFileEvent.data = getAllFileList.selectedItems;
			EventManager.getInstance().dispatchEvent(addFileEvent)
				
			resetListSelected();
			resetSearchInput();
		}
		
		protected function cancelBtn_handler(event:MouseEvent):void
		{
			resetListSelected();
			resetSearchInput();
		}
		
		/**
		 * 重置list选择状态
		 * @param exit  是否为离开
		 */
		private function resetListSelected(exit:Boolean=true):void
		{
			//清除list中 选中的对象
			var selectedInices:Vector.<int> = new Vector.<int>();
			getAllFileList.selectedIndex = -1;
			getAllFileList.selectedIndices = selectedInices;
//			selectedRobotVector = null;
			
			if(exit)
				PopUpManager.removePopUp(this);
		}
		
		private function resetSearchInput():void
		{
			///清空搜索框中的数据
			searchInput.text ="";
			searchInput.HandChange = true;
			getAllFileList.dataProvider = testData;
//			notFoundImg.visible = false;			
		}	
	}
}