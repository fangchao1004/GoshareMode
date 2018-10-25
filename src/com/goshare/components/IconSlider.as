package com.goshare.components
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	import com.goshare.components.NewSlider;
	
	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	public class IconSlider extends UIComponent
	{
		public function IconSlider()
		{
			super();
		}
		
		private var slider : NewSlider;
		private var icon1 : Image;
		private var icon2 : Image;
		private var _sliderIsVertical : Boolean;
		public var iconSourceArray : Array;
		public var sliderNumber : Number = 0;
		
		public function get sliderIsVertical():Boolean
		{
			return _sliderIsVertical;
		}
		
		public function set sliderIsVertical(value:Boolean):void
		{
			_sliderIsVertical = value;
			invalidateProperties();
			invalidateSkin();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			slider = new NewSlider();
			slider.width = 100;
			slider.height = 24;
			slider.maxValue = 100;
			slider.minValue = 0;
			slider.value = 20;
			sliderNumber = slider.value;
			slider.buttonMode = true;
			slider.addEventListener(UIEvent.CHANGE,sliderChang_Handler);
			addChild(slider);
			
			icon1 = new Image();
			icon1.buttonMode = true;
			icon1.source = "assets/interactive/"+iconSourceArray[0];
			icon1.width = 21;
			icon1.height = 21;
			icon1.addEventListener(MouseEvent.CLICK,iconClickHandler);
			addChild(icon1);
			
			icon2 = new Image();
			icon2.buttonMode = true;
			icon2.source = "assets/interactive/"+iconSourceArray[1];
			icon2.width = 21;
			icon2.height = 21;
			icon2.addEventListener(MouseEvent.CLICK,iconClickHandler);
			addChild(icon2);
			icon2.visible = false;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			slider.isVertical = sliderIsVertical;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			if(slider.isVertical)
			{
				slider.x = 0;
				slider.y = 10;
				icon1.x=icon2.x = (slider.height-icon1.width)/2;
				icon1.y =icon2.y= slider.y+slider.width+5;
			}else
			{
				icon1.x = icon2.x =10;
				icon1.y = icon2.y =(slider.height-icon1.height)/2
				slider.x = icon1.x+icon1.width+3;
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xCCCCCC);
			if(sliderIsVertical==true)
			{
				graphics.drawRect(0,0,height,width);
			}else
			{
				graphics.drawRect(0,0,width,height);
			}
			graphics.endFill();
		}
		
		protected function iconClickHandler(event:MouseEvent):void
		{
			if(slider.value!=0)
			{
				slider.value = 0;
				sliderNumber = 0;
				icon1.visible = false;
				icon2.visible = true;
			}else
			{
				if(sliderNumber==0)
				{
				    sliderNumber  +=50;
				}
				slider.value = sliderNumber;
				icon1.visible = true;
				icon2.visible = false;
			}
//			trace(slider.value);
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
		}
		
		protected function sliderChang_Handler(event:UIEvent):void
		{
			
			sliderNumber=Math.ceil(slider.value);
//			trace("内部："+sliderNumber);
			if(slider.value==0)
			{
				icon1.visible = false;
				icon2.visible = true;
			}else
			{
				icon1.visible = true;
				icon2.visible = false;
			}
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
		}
	}
}