package com.goshare.view
{
	import coco.component.ViewNavigator;
	
	/**
	 * 程序首页 
	 * @author coco
	 * 
	 */	
	public class MainView extends ViewNavigator
	{
		public function MainView()
		{
			super();
		}
		
		private static var instance:MainView;
		
		public static function getInstance():MainView
		{
			if (!instance)
				instance = new MainView();
			
			return instance;
		}
		
	}
	
}