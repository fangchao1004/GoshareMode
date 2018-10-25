package com.goshare.components
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	public class TxtInputPlcHold extends TextInput
	{
		public function TxtInputPlcHold()
		{
			super();
			addEventListener(UIEvent.CHANGE,changeHandler);
		}
		
		protected function changeHandler(event:UIEvent):void
		{
			Handler();
		}
		
		private function Handler():void
		{
			if(this.text=="")
			{
				lab.visible = true;
			}else
			{
				lab.visible =false;
			}
		}		
		
		
		private var lab : Label;
		public var placeHold : String = "";
		private var _HandChange : Boolean;

		public function get HandChange():Boolean
		{
			return _HandChange;
		}
		///手动强制触发UIchange
		public function set HandChange(value:Boolean):void
		{
			_HandChange = value;
			Handler();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = placeHold;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.fontSize = 16;
			lab.color = 0x8c8c8c;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.x = 20;
			lab.y = (height-lab.fontSize)/2-2;
		}
		
		
	}
}