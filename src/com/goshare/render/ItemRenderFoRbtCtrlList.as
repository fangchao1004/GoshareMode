package com.goshare.render
{
	import com.goshare.components.IconSlider;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.EventManager;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	
	public class ItemRenderFoRbtCtrlList extends DefaultItemRenderer
	{
		public function ItemRenderFoRbtCtrlList()
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
		
		private var robotIcon:Image;
		private var voiceToggle: Image;
		private var videoToggle:Image;
		private var speakerSlider:IconSlider;
		override protected function createChildren():void
		{
			super.createChildren();
			
			///添加机器人icon
			robotIcon = new Image();
			robotIcon.width = 21;
			robotIcon.height = 28;
			robotIcon.source = "assets/interactive/robot.png";
			robotIcon.buttonMode = true;
			addChild(robotIcon);
			
			///细胞类中添加扬声器icon
			voiceToggle = new Image();
			voiceToggle.width = 21;
			voiceToggle.height = 18; 
			voiceToggle.buttonMode = true;
			voiceToggle.addEventListener(MouseEvent.CLICK,voiceToggle_clickHandler);
			addChild(voiceToggle);
			
			///添加播放视频icon
			videoToggle = new Image();
			videoToggle.width = 21;
			videoToggle.height = 14;
			videoToggle.buttonMode = true;
			videoToggle.addEventListener(MouseEvent.CLICK,videoToggle_clickHandler);
			addChild(videoToggle);
			videoToggle.visible = false;
			
			speakerSlider = new IconSlider();
			speakerSlider.iconSourceArray = ["mic_open.png","mic_close.png"];
			speakerSlider.x = speakerSlider.y = 40;
			speakerSlider.width = 140;
			speakerSlider.height = 24;
			speakerSlider.sliderIsVertical = true;
//			speakerSlider.addEventListener(UIEvent.CHANGE,uichange_Handler);
			speakerSlider.addEventListener(UIEvent.CHANGE,uichange_Handler);
//			addChild(speakerSlider);
//			speakerSlider.visible = false;
			
			labelDisplay.textAlign = TextAlign.CENTER;
			labelDisplay.fontFamily = FontFamily.STXIHEI;
			labelDisplay.bold = true;
			labelDisplay.color = 0x5c9dfd;
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				voiceToggle.source = "assets/interactive/voice_open.png";
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			labelDisplay.fontSize = int((16/276)*width);
			
			robotIcon.x =35;
			robotIcon.y = (height - robotIcon.height) / 2;
				
			videoToggle.x = width - videoToggle.width - 15;
			videoToggle.y = (height - videoToggle.height) / 2;
				
			voiceToggle.x = videoToggle.x - videoToggle.width - 15;
			voiceToggle.y =(height - voiceToggle.height) / 2;
			
//			speakerSlider.x = voiceToggle.x-70;
//			speakerSlider.y = voiceToggle.y-speakerSlider.width-5;
//			speakerSlider.y = 40;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,selected?0x5c9dfd:0xffffff);
			graphics.beginFill(selected?0xf0f5fe:0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function videoToggle_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			//			trace("点击视频");
		}
		
		protected function voiceToggle_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
//			trace("点击扬声器图标，显示滑块");
			
			if(!speakerSlider.isPopUp){
				///显示slider popUp
				PopUpManager.addPopUp(speakerSlider,this.voiceToggle,false);
				speakerSlider.isPopUp = true;
			}else{
				PopUpManager.removePopUp(speakerSlider);
				speakerSlider.isPopUp = false;
			}
			
			speakerSlider.x = 0;
			speakerSlider.y = -speakerSlider.width-2;
		}
		
		protected function uichange_Handler(event:UIEvent):void
		{
			var sliderNumber : int=Math.ceil(speakerSlider.sliderNumber);
			
			///将音量值 通过自定义事件 派发 在robotVideoView中进行监听，改变netSteam
			EventManager.getInstance().dispatchEventQuick("changeRobotVideoVolume",sliderNumber);
		}
		
	}
}