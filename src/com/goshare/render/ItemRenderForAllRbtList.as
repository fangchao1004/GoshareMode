package com.goshare.render
{
	import com.goshare.components.ToggleIcon;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.manager.AppRCManager;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	public class ItemRenderForAllRbtList extends DefaultItemRenderer
	{
		public function ItemRenderForAllRbtList()
		{
			super();
			mouseChildren = true
			//			borderAlpha = 0
			AppRCManager.getInstance().addEventListener(AppRCManagerEvent.RC_LIST_CHAGNED,rcListChagned_Handler);
		}
		
		protected function rcListChagned_Handler(event:AppRCManagerEvent):void
		{
			invalidateProperties();
			invalidateSkin();
		}
		
		override public function set data(value:Object):void
		{
			if (super.data == value) return;
			super.data = value;
			invalidateSkin();
			invalidateProperties();
		}
		
		
		private var lineStatusIcon: Image;
		private var robotIcon:Image;
		private var classLab : Label;
		private var idLab:Label;
		private var togIconBtn : ToggleIcon;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.x = 295;
			labelDisplay.fontSize = 15;
			labelDisplay.fontFamily = "Microsoft YaHei";
			
			///细胞类中在线情况icon
			lineStatusIcon = new Image();
			lineStatusIcon.width = 21;
			lineStatusIcon.height = 21; 
			addChild(lineStatusIcon);
			
			///添加机器人icon
			robotIcon = new Image();
			robotIcon.width = 21;
			robotIcon.height = 28;
			robotIcon.source = "assets/interactive/robot.png";
			robotIcon.buttonMode = true;
			addChild(robotIcon);
			
			classLab = new Label();
			classLab.fontSize = 15;
			classLab.fontFamily = "Microsoft YaHei";
			addChild(classLab);
			
			idLab = new Label();
			idLab.fontSize = 15;
			idLab.fontFamily = "Microsoft YaHei";
			addChild(idLab);
			
			togIconBtn = new ToggleIcon();
			togIconBtn.iconArray = ["unselected.png","selected.png"];
			togIconBtn.width = togIconBtn.height = 20;
			addChild(togIconBtn);
		}
		
		
		override protected function commitProperties():void {
			super.commitProperties()
			
//			trace(JSON.stringify(data));
			if (data) {
//				trace(JSON.stringify(data));
				lineStatusIcon.source = data["online"]? "assets/interactive/online.png" : "assets/interactive/offline.png" ;
				idLab.text = data["id"];
				classLab.text = data["classInfo"];
			}
			
//			classLab.color = selected?0x5c9dfd:0x555555;
//			idLab.color = selected?0x5c9dfd:0x555555;
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			lineStatusIcon.x = 38;
			lineStatusIcon.y = (height - lineStatusIcon.height) / 2;
			
			robotIcon.x = lineStatusIcon.x+lineStatusIcon.width+15;
			robotIcon.y = (height - robotIcon.height) / 2;
			
			classLab.x = robotIcon.x+robotIcon.width+65;
			classLab.y = 10;
			
			idLab.x = width-togIconBtn.width-190;
			idLab.y = 10;
			
			togIconBtn.x = width-togIconBtn.width-20;
			togIconBtn.y = lineStatusIcon.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			
			if(data["online"]==false)
			{
				this.selected = false;
			}
			
			labelDisplay.color = classLab.color =idLab.color = selected?0x5c9dfd:0x555555;
			
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
			
			togIconBtn.selected = this.selected
		}
		
	}
}