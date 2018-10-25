package com.goshare.components
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.event.UIEvent;

	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	public class ToggleIcon extends UIComponent
	{
		public function ToggleIcon()
		{
			super();
			mouseChildren = false;
			addEventListener(UIEvent.CHANGE,changeHandler);
		}
		
		
		protected function changeHandler(event:UIEvent):void
		{
			invalidateProperties();
		}
		
		private var _selected:Boolean = false;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if (_selected == value) return;
			_selected = value;
			invalidateProperties();
		}
		
		
		
		public var iconArray : Array;
		public var labArray : Array;
		
		private var statusIcon : Image;
		public var lab : Label;
		public var txtLab : String;
		override protected function createChildren():void
		{
			super.createChildren();
			
			statusIcon = new Image();
			statusIcon.width = width;
			statusIcon.height = height;
			statusIcon.source = "assets/interactive/"+iconArray[1];
			addChild(statusIcon);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			statusIcon.x = (width-statusIcon.width)/2;
			statusIcon.y = (height-statusIcon.height)/2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
//			trace("开始切换状态icon");
			if(iconArray.length==2)
			statusIcon.source = selected?("assets/interactive/"+iconArray[1]):("assets/interactive/"+iconArray[0]);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF,0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}