package com.goshare.render
{
	import com.goshare.components.ToggleIcon;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.util.FontFamily;
	
	public class ItemRenderForAllFileList extends DefaultItemRenderer
	{
		public function ItemRenderForAllFileList()
		{
			super();
			mouseChildren = true
			//			borderAlpha = 0
		}
		
		override public function set data(value:Object):void
		{
			if (super.data == value) return;
			super.data = value;
			invalidateSkin();
			invalidateProperties();
		}
		
		
		private var flieTypeIcon:Image;
		private var timeLab : Label;
		private var updateTimeLab:Label;
		private var togIconBtn : ToggleIcon;
		private var newFlagLab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			///添加文件icon
			flieTypeIcon = new Image();
			flieTypeIcon.width = 27;
			flieTypeIcon.height = 22;
			flieTypeIcon.buttonMode = true;
			addChild(flieTypeIcon);
			
			newFlagLab = new Label();
			newFlagLab.text = "new";
			newFlagLab.fontFamily = FontFamily.STXIHEI;
			newFlagLab.fontSize = 15;
			newFlagLab.color = 0xff0224;
			addChild(newFlagLab);
			
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.fontSize = 16;
//			labelDisplay.bold = true;
			labelDisplay.fontFamily = FontFamily.STXIHEI;
			
			timeLab = new Label();
			timeLab.fontSize = 15;
			timeLab.fontFamily = FontFamily.STXIHEI;
			addChild(timeLab);
			
			updateTimeLab = new Label();
			updateTimeLab.fontSize = 15;
			updateTimeLab.fontFamily = FontFamily.STXIHEI;
			addChild(updateTimeLab);
			
			togIconBtn = new ToggleIcon();
			togIconBtn.iconArray = ["unselected.png","selected.png"];
			togIconBtn.width = togIconBtn.height = 20;
			addChild(togIconBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties()
			//			trace(JSON.stringify(data));
			if (data) {
				
				updateTimeLab.text = data["updateTime"];
				timeLab.text = data["time"];
				labelDisplay.text = filterWordLengthHandler(labelDisplay.text)+"."+data["fileType"]
//				flieTypeIcon.source = "assets/file/"+data["fileType"]+"_unSelected.png"
				flieTypeIcon.source = "assets/file/fileUnify.png"
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			flieTypeIcon.x = 30;
			flieTypeIcon.y = (height-flieTypeIcon.height)/2;
			
			newFlagLab.x = 75;
			newFlagLab.y = (height-newFlagLab.fontSize)/2;
				
			labelDisplay.x = 120;
			
			timeLab.x = width-100;
			timeLab.y = (height-timeLab.fontSize)/2;
			
			updateTimeLab.x = width-togIconBtn.width-190;
			updateTimeLab.y = (height-updateTimeLab.fontSize)/2;
			
			togIconBtn.x = width-togIconBtn.width-20;
			togIconBtn.y = (height-togIconBtn.height)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			if(index%2==0)
			{
				graphics.beginFill(selected?0xf0f5fe:0xf7f7f7);
			}else
			{
				graphics.beginFill(selected?0xf0f5fe:0xffffff);
			}
			
			graphics.drawRoundRect(0, 0, width, height,6,6);
			graphics.endFill();
			
			labelDisplay.color = timeLab.color = updateTimeLab.color = selected?0x5c9dfd:0x1a1a1a
			
			togIconBtn.selected = this.selected
		}
		
		private function filterWordLengthHandler(words:String):String
		{
			if(words.length>=14)
			{
				words = words.substr(0,14)+"~"
			}
			return words;
		}
		
	}
}

