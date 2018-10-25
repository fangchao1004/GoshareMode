package com.goshare.view.home
{
	
	import coco.core.UIComponent;
	
	/**
	 *homeView中 应当包含界面上所有主要元素 
	 * @author fangchao
	 */
	public class HomeView extends UIComponent
	{
		public function HomeView()
		{
			super();
//			width = 1366;
//			height = 768;
		}
		
		private var topBarView : TopBarView;
		private var localVideoView : LocalVideoView;
		private var robotVideoView : RobotVideoView;
		private var rbtCtlListView : RobotCtrlListView;
		private var historyView : HistoryView;
		private var coursewareView : FileView;
		private var sb2StageView : SB2StageVIew;
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			topBarView = new TopBarView();
			addChild(topBarView);
			
			localVideoView = new LocalVideoView();
			addChild(localVideoView);
			
			robotVideoView =  new RobotVideoView();
			addChild(robotVideoView);
//			robotVideoView.visible = false;
			
			rbtCtlListView = new RobotCtrlListView();
			addChild(rbtCtlListView);
			
			coursewareView = new FileView();
			addChild(coursewareView);
			
			historyView = new HistoryView();
			addChild(historyView);
			
			sb2StageView = new SB2StageVIew();
			addChild(sb2StageView);
			
		}
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			topBarView.x = topBarView.y = 0;
			topBarView.width = width;
			topBarView.height = height*(70/768)
			
			localVideoView.width = width*(280/1366);
			localVideoView.height = localVideoView.width*(280/280);
			localVideoView.y = topBarView.height+5;
			localVideoView.x = 5;
			
			robotVideoView.width = width*(280/1366);
			robotVideoView.height = robotVideoView.width*(3/4);
			robotVideoView.y = localVideoView.y+localVideoView.height+5;
			robotVideoView.x = 5;
			
			rbtCtlListView.width = width*(280/1366);
			rbtCtlListView.y = robotVideoView.y+robotVideoView.height+5;
			rbtCtlListView.x = 5;
			rbtCtlListView.height = height-rbtCtlListView.y-5;
			
			coursewareView.width = 280;
			coursewareView.height = 360;
			coursewareView.x = width-coursewareView.width-5;
			coursewareView.y = topBarView.y+topBarView.height+5;
			
			historyView.width = 280;
			historyView.x = width-historyView.width-5;
			historyView.y = coursewareView.y+coursewareView.height+5;
			historyView.height = height-historyView.y-5;
			
			sb2StageView.width = width-localVideoView.width-coursewareView.width-5*4;
			sb2StageView.height = height-topBarView.height-5*2;
			sb2StageView.x = localVideoView.x+localVideoView.width+5;
			sb2StageView.y = topBarView.y+topBarView.height+5;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xf5f5f5);
//			graphics.beginFill(0x888888);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}