package com.goshare.components
{

	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class InfoBar extends UIComponent
	{
		public function InfoBar()
		{
			super();
		}
		
		private var roleIcon : Image;
		private var coverIcon : Image;
		private var nameLab : Label;
		private var messageBar : TextArea;
		private var defaultMaxWidth : int = 200;
		public var oneLineWord : uint = 12; //每行默认多少个字符
		
		
		private var _talkInfo : InfoType;
		public var heighValue : int;
		private var messageColorValue : uint = 0x535353;
		private var roleValueImg : String;
		private var roleValueLab : String;
		private var labColor : uint= 0x535353;
		
		public function get talkInfo():InfoType
		{
			return _talkInfo;
		}

		public function set talkInfo(value:InfoType):void
		{
			_talkInfo = value;
			analysisHandler(_talkInfo);
		}
		
		private function analysisHandler(data:InfoType):void
		{
			roleValueImg = data.role;
			switch(data.role)
			{
				case "teacher":
				{
					roleValueLab = "老师说：";
					labColor = 0x00c680;
					break;
				}
					
				case "student":
				{
					roleValueLab = "学生说：";
					labColor = 0x888888;
					break;
				}
					
				case "robot":
				{
					roleValueLab = "机器人说：";
					labColor= 0xff2d53;
					break;
				}
					
				default:
				{
					break;
				}
			}
			switch(data.type)
			{
				/*case "answer": //回答
				{
					messageColorValue = 0xB03060;
					break;
				}*/
				case "question": //提问
				{
					if(data.role=="robot")
					{
						roleValueLab = "机器人问：";
						labColor = 0xff2d53;
					}
					messageColorValue = 0xFF8C00;
					break;
				}	
				default:
				{
					messageColorValue = 0x535353;
					break;
				}
			}
		}
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			roleIcon = new Image();
			roleIcon.width = roleIcon.height = 30;
			roleIcon.source = '/assets/interactive/'+roleValueImg+'.png';
			addChild(roleIcon);
			
			coverIcon = new Image();
			coverIcon.width = coverIcon.height = 30;
			coverIcon.source = 'assets/interactive/cover.png';
			addChild(coverIcon);
			
			nameLab = new Label();
			nameLab.fontFamily = "Microsoft YaHei";
			nameLab.text = roleValueLab;
			nameLab.fontSize = 14;
			nameLab.color = labColor;
			addChild(nameLab);
			
			messageBar = new TextArea();
//			messageBar.fontFamily = "Microsoft YaHei";
			messageBar.fontFamily = FontFamily.STXIHEI;
			messageBar.wordWrap = true;
			messageBar.editable = false;
			messageBar.text = talkInfo.message;
			messageBar.width = messageBar.text.length*20;
			messageBar.fontSize = 15;
			messageBar.height = (messageBar.fontSize) *1+20-1;
			messageBar.backgroundColor = 0xf0f5fe;
			messageBar.color = messageColorValue;
			addChild(messageBar);
		}
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			roleIcon.x = 0;
			roleIcon.y = 0;
			
			coverIcon.x = roleIcon.x;
			coverIcon.y = roleIcon.y;
			
			nameLab.x = roleIcon.width + roleIcon.x + 4;
			nameLab.y = roleIcon.y;
			
			messageBar.x = roleIcon.width + roleIcon.x + 10;
			messageBar.y = roleIcon.y+18;
			
			renderHandler();
		}
		
		override protected function drawSkin():void
		{
		    super.drawSkin();
			
//			graphics.clear();
//			graphics.beginFill(0xFF0000,0.1);
//			graphics.drawRect(0,0,width,height);
//			graphics.endFill()
		}
		
		public function renderHandler():void
		{
			var wordCount : int = talkInfo.message.length;
			var LineCount : uint = Math.ceil(wordCount/oneLineWord);
			if(LineCount==0) LineCount = 1;
			
			if(wordCount>oneLineWord) //大于一行
			{
				messageBar.width = defaultMaxWidth;
			}
			else if(wordCount<=oneLineWord) //一行
			{
				messageBar.width = (wordCount+1)*messageBar.fontSize
			}
			
			messageBar.height = (messageBar.fontSize)*LineCount+20-LineCount;
			
			width =  messageBar.width+roleIcon.width+20;
			height = messageBar.height+14;
		}
	}
}