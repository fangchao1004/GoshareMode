package com.goshare.components
{
	import com.goshare.view.MainView;
	
	import coco.core.UIComponent;
	
	
	/**
	 *
	 * 进度条
	 *  
	 * @author coco
	 * 
	 */	
	public class Loading extends UIComponent
	{
		public function Loading()
		{
			super();
			
			width = 300;
			height = 10;
		}
		
		
		private var _value:Number = 0;

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
			invalidateSkin();
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x7da9f2);
			graphics.drawRect(-1920/2,-1080/2,1920,1080); ///背景 整体
			graphics.endFill();
			
			graphics.beginFill(0x000000, .3);
			graphics.drawRoundRectComplex(0, 0, width, height, 5, 5, 5, 5);///进度条
			graphics.endFill();
			
			graphics.beginFill(0x8bd1f7);
			graphics.drawRoundRectComplex(0, 0, width * value, height, 5, 5, 5, 5); ///进度条值
			graphics.endFill();
		}
		
	}
}