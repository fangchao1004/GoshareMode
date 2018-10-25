package com.goshare.components
{
	import flash.events.Event;
	
	import coco.component.Slider;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class MicSlider extends UIComponent
	{
		public function MicSlider()
		{
			super();
		}
		
		private var slider : Slider;
		override protected function createChildren():void
		{
		    super.createChildren();
			
			slider = new Slider();
			slider.maxValue = 100;
			slider.minValue = 0;
			slider.addEventListener(Event.CHANGE,changHandler);
			addChild(slider);
		}
		
		protected function changHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace();
		}
	}
}