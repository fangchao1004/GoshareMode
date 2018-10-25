package com.goshare.components
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class IconLabButton extends UIComponent
	{
		public function IconLabButton()
		{
			super();
			addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			addEventListener(MouseEvent.MOUSE_UP,upHandler);
		}
		
		protected function upHandler(event:MouseEvent):void
		{
			downFlag = false;
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			downFlag  = true;
		}
		
		private var _downFlag : Boolean;

		public function get downFlag():Boolean
		{
			return _downFlag;
		}

		public function set downFlag(value:Boolean):void
		{
			_downFlag = value;
			invalidateProperties();
			invalidateSkin();
		}

		private var icon : Image;
		public var sourceArray : Array=[];
		public var labText : String;
		public var lab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			icon = new Image();
			icon.height = icon.width = this.height-6;
			addChild(icon);
			
			lab = new Label();
			lab.text = labText;
			lab.fontFamily = "Microsoft YaHei";
			lab.fontSize = 18;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			icon.x = 5;
			icon.y = (height-icon.height)/2;
			
			lab.x = icon.x+icon.width+10;
			lab.y = icon.y+6;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(sourceArray.length>=2)
			icon.source = downFlag?"assets/interactive/"+sourceArray[0]:"assets/interactive/"+sourceArray[1];
			lab.color = downFlag?0x888888:0xffffff;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(downFlag?0xebf2fc:0x6699FF);
			graphics.drawRoundRect(0,0,width,height,6,6);
			graphics.endFill();
		}
	}
}