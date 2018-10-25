package com.goshare.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class ToggleBtnForPlayAndStop extends UIComponent
	{
		public function ToggleBtnForPlayAndStop()
		{
			super();
			width = 100;
			height = 30;
			addEventListener(MouseEvent.CLICK,click_Handler);
		}
		private var _selected : Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateProperties();
			invalidateSkin();
		}

		protected function click_Handler(event:MouseEvent):void
		{
			selected = !selected;
		}
		
		private var lab : Label;
		public var textForSelected : String;
		public var textForUnselected : String;
		public var fontSize : int=12;
		public var colorForSelected : uint;
		public var colorForUnselected : uint ;
		public var bgColorForSelected : uint ;
		public var bgColorForUnselected : uint ;
		public var radius : int = 0;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.fontSize = this.fontSize;
			lab.fontFamily = FontFamily.STXIHEI;
			addChild(lab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.text = selected?textForSelected:textForUnselected;
			lab.color = selected?colorForSelected:colorForUnselected;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.y = (height-lab.fontSize)/2;
			lab.x = (width-lab.text.length*fontSize)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(selected?bgColorForSelected:bgColorForUnselected);
			graphics.drawRoundRect(0,0,width,height,radius,radius);
			graphics.endFill();
		}
		
		
	}
}