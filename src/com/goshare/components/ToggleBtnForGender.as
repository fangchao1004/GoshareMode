package com.goshare.components
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.ToggleButton;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	public class ToggleBtnForGender extends UIComponent
	{
		public function ToggleBtnForGender()
		{
			super();
			mouseChildren = false;
		}
		
		private var _selected : Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateSkin();
		}
		
		public var lab : Label;
		public var txtLab : String;
		public var labX : Number = 40;
		public var labY : Number = 5;
		public var drawRadius : Number = 10;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = txtLab;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.fontSize = 18;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.x = labX;
			lab.y = labY;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0xededed);
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(height/2,height/2,height/2);
			if(selected)
			{
				graphics.beginFill(0x5c9dfd);
				graphics.drawCircle(height/2,height/2,drawRadius);
				graphics.endFill();
			}
			
		}
	}
}


