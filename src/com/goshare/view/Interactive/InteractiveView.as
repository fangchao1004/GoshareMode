package com.goshare.view.Interactive
{
	import com.goshare.view.home.SB2StageVIew;
	
	import coco.component.Button;
	import coco.component.List;
	import coco.core.UIComponent;
	
	public class InteractiveView extends UIComponent
	{
		public function InteractiveView()
		{
			super();
		}
		
		private var mediaPreviewList : List;
		private var interactiveBar : InteractiveBar;
		private var preBtn : Button;
		private var nextBtn : Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			mediaPreviewList = new List();
			mediaPreviewList.gap = 15;
			mediaPreviewList.horizontalScrollEnabled = true;
			mediaPreviewList.verticalScrollEnabled = false;
			mediaPreviewList.itemRendererRowCount = 1;
			mediaPreviewList.dataProvider = [1,2,3,4,5,6];
			addChild(mediaPreviewList);
			mediaPreviewList.visible = false;
			
			
			preBtn = new Button();
			preBtn.label = "pre";
			addChild(preBtn);
			preBtn.visible = false;
			
			nextBtn = new Button();
			nextBtn.label = "next";
			addChild(nextBtn);
			nextBtn.visible = false;
			
			interactiveBar = new InteractiveBar();
			addChild(interactiveBar);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			mediaPreviewList.x = 50*(width/765);
//			mediaPreviewList.y = bgImg.y+bgImg.height+20;
			mediaPreviewList.y = 20;
			mediaPreviewList.width = width-2*50*(width/765);
			mediaPreviewList.itemRendererWidth = (width-2*50*(width/765))/3;
			mediaPreviewList.itemRendererHeight = mediaPreviewList.itemRendererWidth*9/16;
			mediaPreviewList.height = mediaPreviewList.itemRendererHeight;
			
			
			preBtn.width = 38*(width/765)
			preBtn.height = preBtn.width;
			preBtn.x = 0;
			preBtn.y = mediaPreviewList.y+(mediaPreviewList.height-preBtn.height)/2;
			
			nextBtn.width = 38*(width/765)
			nextBtn.height = nextBtn.width;
			//			nextBtn.x = mediaPreviewList.x+mediaPreviewList.width+10;
			nextBtn.x = width-nextBtn.width;
			nextBtn.y = mediaPreviewList.y+(mediaPreviewList.height-preBtn.height)/2;
			
			interactiveBar.width = width-20;
			interactiveBar.height = 60;
			interactiveBar.x = 10;
//			interactiveBar.y = mediaPreviewList.y+mediaPreviewList.height+20;
			interactiveBar.y = this.height-interactiveBar.height-5;
			
			
//			trace("mediaPreviewList.y : "+mediaPreviewList.y);
//			trace("MediaList W_H: "+mediaPreviewList.width+"___"+mediaPreviewList.height);
//			trace("mediaPreviewList.itemRendererWidth: "+mediaPreviewList.itemRendererWidth);
//			trace("mediaPreviewList.itemRendererHeight: "+mediaPreviewList.itemRendererHeight);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xeeeeee);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}