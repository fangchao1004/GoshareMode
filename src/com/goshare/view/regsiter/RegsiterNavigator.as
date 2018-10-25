package com.goshare.view.regsiter
{
	import coco.component.ViewNavigator;
	
	public class RegsiterNavigator extends ViewNavigator
	{
		public function RegsiterNavigator()
		{
			super();
		}
		
		private static var instance:RegsiterNavigator;
		
		public static function getInstance():RegsiterNavigator
		{
			if(!instance) instance = new RegsiterNavigator();
			
			return instance;
		}
	}
}