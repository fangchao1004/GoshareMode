package com.goshare.view.personalCenter
{
	import com.goshare.manager.EventManager;
	import com.goshare.view.personalCenter.normalSetMode.RecordPlayDropSubMode;
	
	import flash.events.Event;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.Scroller;
	import coco.component.VGroup;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 基本设置界面
	 */	
	public class NormalSetView extends UIComponent
	{
		public function NormalSetView()
		{
			super();
			EventManager.getInstance().addEventListener("refreshHightShow_NormalMode",refreshHightShow);
		}
		
		protected function refreshHightShow(event:Event):void
		{
			invalidateDisplayList();
		}
		
		private var titleIcon : Image;
		private var lab : Label;
		private var vg : VGroup;
		private var scroller : Scroller;
		private var recordPlayDropSubMode : RecordPlayDropSubMode;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleIcon = new Image();
			titleIcon.source = "assets/personalCenter/normalSet_selected.png";
			titleIcon.width = 20;
			titleIcon.height = 20;
			addChild(titleIcon);
			
			lab = new Label();
			lab.text = "基本设置";
			lab.color = 0x5c9dfd;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.bold = true;
			lab.fontSize = 20;
			addChild(lab);
			
			scroller = new Scroller();
			scroller.autoDrawSkin = true;
			scroller.verticalScrollEnabled = true;
			scroller.horizontalScrollEnabled = false;
			addChild(scroller);
			
			vg = new VGroup();
			vg.gap = 10;
			scroller.addChild(vg);
			
			recordPlayDropSubMode = new RecordPlayDropSubMode();
			vg.addChild(recordPlayDropSubMode);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleIcon.width = titleIcon.height = 24;
			titleIcon.x = 35;
			titleIcon.y = 13;
			
			lab.x = 80;
			lab.y = 13;
			
			scroller.x =0;
			scroller.y = 40;
			scroller.width = width-10;
			scroller.height = height-scroller.y;
			vg.width = scroller.width;
			recordPlayDropSubMode.width = scroller.width-10;
			
			vg.height = recordPlayDropSubMode.height+15;
//			trace("基本设置模块中Vg的高度："+vg.height);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xa9a9a9,0.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
	}
}