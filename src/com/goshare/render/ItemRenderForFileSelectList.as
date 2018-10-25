package com.goshare.render
{
	import com.goshare.event.TestEvent;
	import com.goshare.manager.EventManager;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.util.FontFamily;
	
	public class ItemRenderForFileSelectList extends DefaultItemRenderer
	{
		public function ItemRenderForFileSelectList()
		{
			super();
			mouseChildren = true;
		}
		
		override public function set data(value:Object):void
		{
			if (super.data == value) return;
			super.data = value;
			invalidateSkin();
			invalidateProperties();
		}
		
		private var fileIcon : Image;
		private var fileTime : Label;
		private var removeBtn : Image;
		private var iconSource:String;
		override protected function createChildren():void
		{
			super.createChildren();
			
			fileIcon = new Image();
//			fileIcon.source = "assets/test/file.png";
			addChild(fileIcon);
			
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.x = 45;
			labelDisplay.fontFamily =  FontFamily.STXIHEI;
//			labelDisplay.bold = true;
			labelDisplay.fontSize = 16;
			labelDisplay.color = 0x919192;
			
			
			fileTime = new Label();
			fileTime.fontFamily = "Microsoft YaHei";
			fileTime.fontSize = 16;
			fileTime.color = 0x919192;
			addChild(fileTime);
			
			removeBtn = new Image();
			removeBtn.buttonMode = true;
			removeBtn.source = "assets/interactive/file_close.png";
			removeBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(removeBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data)
			{
				fileTime.text = data["time"];
				iconSource = "assets/file/"+data["fileType"];
				fileIcon.source = iconSource+"_unSelected.png";
				//			labelDisplay.text = filterWordLengthHandler("课件1: 龟兔赛跑，蚂蚁过河。呵呵");
				labelDisplay.text = filterWordLengthHandler(labelDisplay.text);
			}
		}
		
		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			fileIcon.width = fileIcon.height = 30;
			fileIcon.x = 10;
			fileIcon.y = (height-fileIcon.height)/2;
			
			fileTime.x = width/2+45;
			fileTime.y = (height-fileTime.fontSize)/2;
			
			removeBtn.width = removeBtn.height = 20;
			removeBtn.x = width-removeBtn.width-15;
			removeBtn.y = (height-removeBtn.height)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(selected?0x5c9dfd:0xf0f5fe);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
			///根据选择的不同
			labelDisplay.color = labelDisplay.color= selected?0xffffff:0x919192;
			fileTime.color = labelDisplay.color= selected?0xffffff:0x919192;
			fileIcon.source = selected?iconSource+"_selected.png":iconSource+"_unSelected.png"
			removeBtn.visible = selected;
		}
		
		private function filterWordLengthHandler(words:String):String
		{
			if(words.length>=7)
			{
				words = words.substr(0,7)+"..."
			}
			return words;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			trace("点击remove");
			event.stopImmediatePropagation();
			trace(data.id);
			var removeFileItemEvent : TestEvent = new TestEvent(TestEvent.REMOVE_FILE);
			removeFileItemEvent.data = data;
			EventManager.getInstance().dispatchEvent(removeFileItemEvent);
		}
	}
}