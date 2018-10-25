package com.goshare.components
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.ToggleButton;
	import coco.util.FontFamily;
	
	public class ToggleIconLabBtn extends ToggleButton
	{
		public function ToggleIconLabBtn()
		{
			super();
		}
		
		private var _selected : Boolean;

		override public function get selected():Boolean
		{
			return _selected;
		}

		override public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateSkin();
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
			
			statusIcon.source = "assets/interactive/"+iconArray[1];
			addChild(statusIcon);
			
			lab = new Label();
			lab.text = txtLab;
//			lab.fontFamily = "Microsoft YaHei";
			lab.fontFamily = FontFamily.STXIHEI;
			lab.bold = true;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.fontSize = int((22/133)*width)
				
			statusIcon.width = int((19/133)*width)
			statusIcon.height = int((26/133)*width)
			
			statusIcon.x = 15;
			statusIcon.y = (height-statusIcon.height)/2;
			
//			trace("w: "+width+"距离："+20*(width/133));
			
			lab.x = statusIcon.x+statusIcon.width+(14/133)*(width);
			lab.y = (height-lab.fontSize)/2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(iconArray.length==2)
			{
				statusIcon.source = selected?("assets/interactive/"+iconArray[1]):("assets/interactive/"+iconArray[0]);
				lab.color = selected?0xFFFFFF:0x5c9dfd;
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0x5c9dfd);
			graphics.beginFill(selected?0x5c9dfd:0xFFFFFF);
			graphics.drawRoundRect(0,0,width,height,this.radius,this.radius);
			graphics.endFill();
		}
	}
}