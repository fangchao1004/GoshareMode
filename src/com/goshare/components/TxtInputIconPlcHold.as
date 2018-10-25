package com.goshare.components
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.event.UIEvent;
	
	public class TxtInputIconPlcHold extends TextInput
	{
		public function TxtInputIconPlcHold()
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
				searchIcon.visible = lab.visible = true;
			}else
			{
				searchIcon.visible =lab.visible =false;
			}
		}		
		
		
		private var searchIcon : Image;
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
			
			searchIcon = new Image();
			searchIcon.source = "assets/interactive/search.png";
			searchIcon.width = searchIcon.height = 21;
			addChild(searchIcon);
			
			lab = new Label();
			lab.text = placeHold;
			lab.fontFamily = "Microsoft YaHei";
			lab.fontSize = 16;
			lab.color = 0x5c9dfd;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			searchIcon.x = 10;
			searchIcon.y = (height-searchIcon.height)/2;
			
			lab.x = searchIcon.x + searchIcon.width+10;
			lab.y = (height-lab.fontSize)/2;
		}
		
		
	}
}