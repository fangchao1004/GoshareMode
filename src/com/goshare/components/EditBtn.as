package com.goshare.components
{
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 个人中心-编辑按钮
	 */	
	public class EditBtn extends UIComponent
	{
		public function EditBtn()
		{
			super();
			width = 80;
			height = 30;
			buttonMode = true;
//			addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			selected = !selected;			
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

		private var lab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = "编辑";
			lab.fontSize = 16;
			lab.fontFamily = FontFamily.STXIHEI;
			lab.color = 0x5c9dfd;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.x = 0;
			lab.y = (30-lab.fontSize)/2-2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			graphics.clear();
//			graphics.lineStyle(1,0);
			graphics.beginFill(0xffffff,0.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			
			graphics.lineStyle(1,0x5c9dfd);
			if(selected){
				graphics.moveTo(50,12);
				graphics.lineTo(60,7);
				graphics.lineTo(70,12);
				graphics.moveTo(50,22);
				graphics.lineTo(60,17);
				graphics.lineTo(70,22);
			}else{
				graphics.moveTo(50,7);
				graphics.lineTo(60,12);
				graphics.lineTo(70,7);
				graphics.moveTo(50,17);
				graphics.lineTo(60,22);
				graphics.lineTo(70,17);
			
			}
			
			
		}
	}
}