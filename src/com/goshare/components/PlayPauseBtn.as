package com.goshare.components
{
	import coco.core.UIComponent;
	
	public class PlayPauseBtn extends UIComponent
	{
		public function PlayPauseBtn()
		{
			super();
		}
		
		private var _playFlag : Boolean;

		public function get playFlag():Boolean
		{
			return _playFlag;
		}

		public function set playFlag(value:Boolean):void
		{
			_playFlag = value;
			invalidateSkin();
		}

		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(4,0x5c9dfd);
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,30,30);
			graphics.endFill();
			
			if(!playFlag)
			{
				
				graphics.moveTo(width/2-5,height/4);
				graphics.lineTo(width/2-5,height*3/4);
				
				graphics.moveTo(width/2+5,height/4);
				graphics.lineTo(width/2+5,height*3/4);
			}else
			{
				graphics.lineStyle(0,0,0);
				var ver:Vector.<Number>=new Vector.<Number>();
				ver.push(width*3/8,height/4-2);
				ver.push(width*3/8,height*3/4+2);
				ver.push(width*5/8+3,height/2);
				graphics.beginFill(0x5c9dfd);
				graphics.drawTriangles(ver);
			}
			
			graphics.endFill();
		}
	}
}