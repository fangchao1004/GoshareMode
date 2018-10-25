package
{
	import com.goshare.event.AppAssetsManagerEvent;
	import com.goshare.manager.AppAssetsManager;
	import com.goshare.manager.AppManager;
	import com.goshare.manager.AppRCManager;
	import com.goshare.view.MainView;
	import com.goshare.view.home.HomeView;
	import com.goshare.view.login.LoginView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.core.Application;
	
	[SWF(width="1600", height="900")]
//	[SWF(width="1920", height="1080")]
	public class goshareMode extends Application
	{
		public function goshareMode()
		{
			addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler)
		}
		
		private var homeView : HomeView;
		private var mainView : MainView;
		override protected function createChildren():void
		{
			super.createChildren();
			/// 添加主界面
			addChild(MainView.getInstance());
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			MainView.getInstance().width = this.width;
			MainView.getInstance().height = this.height;
		}
		
		protected function this_addedToStageHandler(event:Event):void
		{
			AppManager.getInstance().showLoading(0);
			AppAssetsManager.getInstance().addEventListener(AppAssetsManagerEvent.ASSETS_SUCCESS,
				assetsSuccessHandler);
			AppAssetsManager.getInstance().addEventListener(AppAssetsManagerEvent.ASSETS_PROGRESS,
				assetsProgressHandler);
			AppAssetsManager.getInstance().addEventListener(AppAssetsManagerEvent.ASSETS_FAULT,
				assetsFaultHandler);
			AppAssetsManager.getInstance().loadAssets();
			
			stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);
		}
		
		protected function assetsFaultHandler(event:AppAssetsManagerEvent):void
		{
			AppManager.getInstance().hideLoading();
			Alert.show("资源加载失败");
		}
		
		protected function assetsProgressHandler(event:AppAssetsManagerEvent):void
		{
			AppManager.getInstance().showLoading(event.value);
		}
		
		protected function assetsSuccessHandler(event:AppAssetsManagerEvent):void
		{
			// 管理器初始化
			AppManager.getInstance().init(this);
			AppRCManager.getInstance().init(this);
			AppAssetsManager.getInstance().init(this);
			gotoLoginView();
		}
		
		protected function stage_clickHandler(event:MouseEvent):void
		{
			if (stage.mouseX <= 10 && stage.mouseY <= 10)
				AppManager.getInstance().copyLogs();
		}
		
		private function gotoLoginView():void
		{
			AppManager.getInstance().hideLoading();
			
			MainView.getInstance().pushView(LoginView);
			AppManager.getInstance().initServer();
			AppManager.getInstance().log("[进入登录界面]");
		}
	}
}