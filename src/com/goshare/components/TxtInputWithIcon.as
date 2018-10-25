package com.goshare.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	public class TxtInputWithIcon extends TextInput
	{
		public function TxtInputWithIcon()
		{
			super();
			autoDrawSkin = false;
			textAlign = TextAlign.CENTER;
			addEventListener(UIEvent.CHANGE,changeHandler);
		}
		
		protected function changeHandler(event:Event):void
		{
			Handler();
		}
		
		private function Handler():void
		{
			if(this.text=="")
			{
				if(lab)
				lab.visible = true;
			}else
			{
				if(lab)
				lab.visible =false;
			}
		}		
		
		private var headIcon : Image;
		public var iconHeight : Number;
		public var iconWidth : Number;
		public var iconSource : String;
		public var iconX : Number;
		public var placeHold : String;
		private var lab : Label;
		public var labX : Number;
		private var clearBtn : Image;
		public var flag : Boolean; ///是否为报错样式
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			headIcon = new Image();
			headIcon.source = iconSource;
			headIcon.height = iconHeight;
			headIcon.width = iconWidth;
			addChild(headIcon);
			
			lab = new Label();
			lab.text = placeHold;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.color = 0x626262;
			lab.fontSize = 20;
			addChild(lab);
			
			clearBtn = new Image();
			clearBtn.source = "assets/login/clear.png";
			clearBtn.width = clearBtn.height = 20;
			clearBtn.addEventListener(MouseEvent.CLICK,clearBtn_Handler);
			addChild(clearBtn);
			clearBtn.visible = false;
		}
		
		protected function clearBtn_Handler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.text = "";
			this.Handler();
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			headIcon.x = iconX;
			headIcon.y = (height-headIcon.height)/2;
			
			lab.x = headIcon.x + headIcon.width+labX;
			lab.y = (height-lab.fontSize)/2;
			
			clearBtn.x = width-clearBtn.width-30;
			clearBtn.y =(height-clearBtn.height)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,30,30);
			graphics.endFill();
			
			
			if(flag){
				graphics.beginFill(0xffe2e2);
				graphics.drawRoundRect(0,0,width,height,30,30);
				graphics.endFill();
				
				clearBtn.visible = true;
				
				this.color = 0xff0000;
			}
			
		
		}
	}
}