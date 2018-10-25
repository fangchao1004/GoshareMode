package com.goshare.view.home
{
	import com.goshare.components.LabColorBtnWithChange;
	import com.goshare.data.DataOfPublic;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.EventManager;
	import com.goshare.render.ItemRenderForFileSelectList;
	import com.goshare.view.file.FileAddView;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import coco.component.Alert;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 课件选择区
	 */
	public class FileView extends UIComponent
	{
		public function FileView()
		{
			super();
			//			width = 300;
			//			height = 400;
			EventManager.getInstance().addEventListener(TestEvent.ADD_FILE,addFileEvent_Handler);
			EventManager.getInstance().addEventListener(TestEvent.REMOVE_FILE,removeFileEvent_Handler);
		}
		
		
		
		
		private var addFileBtn:LabColorBtnWithChange;
		private var sortFileBtn:LabColorBtnWithChange;
		private var fileList:List;
		private var shadow:DropShadowFilter;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var lab : Label = new Label();
			lab.text = "课件选择区";
			addChild(lab);
			lab.visible = false;
			
			addFileBtn = new LabColorBtnWithChange();
			addFileBtn.width = (270/2)-10;
			addFileBtn.height = 40;
			addFileBtn.fontSize = 18;
			addFileBtn.radius = 20;
//			addFileBtn.color = 0x5c9dfd;
			addFileBtn.color = 0xffffff;
			addFileBtn.label = "添加课件";
//			addFileBtn.fontFamily = "Microsoft  YaHei";
			addFileBtn.fontFamily = FontFamily.STXIHEI;
			addFileBtn.bold = true;
			addFileBtn.buttonMode = true;
			addFileBtn.statusLock = true;
			addFileBtn.WhichStatus = true;
			addFileBtn.addEventListener(MouseEvent.CLICK,addFileBtn_handler);
			addChild(addFileBtn);
			
			sortFileBtn = new LabColorBtnWithChange();
			sortFileBtn.width = (270/2)-10;
			sortFileBtn.height = 40;
			sortFileBtn.fontSize = 18;
			sortFileBtn.radius = 20;
			sortFileBtn.color = 0x5c9dfd;
			sortFileBtn.label = "排序";
//			sortFileBtn.fontFamily = "Microsoft  YaHei";
			sortFileBtn.fontFamily = FontFamily.STXIHEI;
			sortFileBtn.bold = true;
			sortFileBtn.buttonMode = true;
			sortFileBtn.addEventListener(MouseEvent.CLICK,sortOn_handler);
			addChild(sortFileBtn);
			
			///课件列表
			fileList = new List();
			fileList.width = 270;
			fileList.itemRendererHeight = 40;
			fileList.gap = 10;
			fileList.labelField = "name"
			fileList.dataProvider = [];
			fileList.itemRendererClass = ItemRenderForFileSelectList;
			fileList.addEventListener(UIEvent.CHANGE,fileList_ChangeHandler);
			addChild(fileList);
			
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
			addFileBtn.filters = [shadow];
			sortFileBtn.filters = [shadow];
		}
		
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			addFileBtn.x = 5;
			addFileBtn.y = 20;
			
			sortFileBtn.x = addFileBtn.x+addFileBtn.width+20;
			sortFileBtn.y = addFileBtn.y;
			
			fileList.x = 5;
			fileList.y = addFileBtn.y+addFileBtn.height+15;
			fileList.height = height-fileList.y-5;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			//			graphics.lineStyle(1,0x888888)
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function addFileBtn_handler(event:MouseEvent):void
		{
			var fileav: FileAddView = FileAddView.getInstance();
			PopUpManager.addPopUp(fileav,null,true,false,0,0.4);
			PopUpManager.centerPopUp(fileav);
		}
		
		
		private var count : int = 0;
		/**
		 * 文件排序（by 文件名）
		 */
		protected function sortOn_handler(event:MouseEvent):void
		{
			if(fileList.dataProvider.length>0)
			{
				count++;
				if(count%2==1)
				{
					var tempData : Array = fileList.dataProvider;
					fileList.dataProvider = tempData.sortOn("name")
				}else
				{
					var tempData2 : Array = fileList.dataProvider;
					fileList.dataProvider = tempData2.sortOn("name",Array.DESCENDING)
				}
			}else
			{
				count = 0;
			}
		}	
		
		private var lastTimeData : Array = [];
		/**
		 * 添加文件
		 */
		protected function addFileEvent_Handler(e:TestEvent):void
		{
			lastTimeData = fileList.dataProvider;
			/*trace("控制区已有数据："+JSON.stringify(lastTimeData));
			trace("控制区-已经收到选中的机器人数据："+JSON.stringify(e.data));*/
			var tempArray : Array = [];
			for each (var i:Object in e.data) 
			{
				tempArray.push(i);
			}
			
			if(lastTimeData&&lastTimeData.length>0)
			{
				for (var j:int = 0; j < tempArray.length; j++) 
				{
					for (var k:int = 0; k < lastTimeData.length; k++) 
					{
						if(tempArray[j]["id"]==lastTimeData[k]["id"]){
							Alert.show("有重复元素"+tempArray[j]["name"]+"等。此次操作无效");			
							return;
						}
					}
				}
			}
			///将tempData 和 lastTimeData 合并
			if(lastTimeData)
			{
				for each (var x:Object in tempArray) 
				{
					lastTimeData.push(x);
				}
			}
			//			trace("合并后的数据"+JSON.stringify(lastTimeData));
			fileList.dataProvider = lastTimeData;
		}
		
		/**
		 * 移除文件
		 */
		protected function removeFileEvent_Handler(event:TestEvent):void
		{
			trace("移除："+event.data.name);
			removeFileItemHandler(event.data.id as String);
		}		
		
		private var afterRemoveData : Array = [];
		private function removeFileItemHandler(targetId:String):void
		{
			if(fileList.dataProvider)
			{
				for (var i:int = 0; i < fileList.dataProvider.length; i++) 
				{
					if(fileList.dataProvider[i]["id"]==targetId)
					{
						fileList.dataProvider.splice(i,1)
						i--;
						trace("移除后："+JSON.stringify(fileList.dataProvider));
						afterRemoveData = fileList.dataProvider;
						DataRefreshHandler();
					}
				}
			}
		}
		
		private function DataRefreshHandler():void
		{
			fileList.selectedIndex = -1;
			fileList.dataProvider = afterRemoveData;
		}
		
		protected function fileList_ChangeHandler(event:UIEvent):void
		{
			trace("选中的课件对象"+JSON.stringify(event.currentTarget.selectedItem));
			DataOfPublic.getInstance().fileDataOfSelected = event.currentTarget.selectedItem;
		}
	}
}