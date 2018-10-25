package com.goshare.view.home
{
	import coco.component.Button;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	import com.goshare.manager.AppManager;
	
	import flash.events.MouseEvent;
	
	public class LogView extends UIComponent
	{
		
		public function LogView()
		{
			super();
			
			width = 1000;
			height = 600;
		}
		
		
		private static var instance:LogView;
		
		public static function getInstance():LogView
		{
			if (!instance)
				instance = new LogView();
			
			return instance;
		}
		
		private var textArea:TextArea;
		private var clearButton:Button;
		private var button:Button;
		
		private var _text:String;

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			invalidateProperties();
		}

		
		override protected function createChildren():void
		{
			super.createChildren();
			
			textArea = new TextArea();
			addChild(textArea);
			
			clearButton = new Button();
			clearButton.label = "清理日志";
			clearButton.height = 30;
			clearButton.addEventListener(MouseEvent.CLICK, clear_clickHandler);
			addChild(clearButton);
			
			button = new Button();
			button.label = "关闭";
			button.height = 30;
			button.addEventListener(MouseEvent.CLICK, button_clickHandler);
			addChild(button);
		}
		
		private function clear_clickHandler(event:MouseEvent):void
		{
			AppManager.getInstance().logClear();
			AppManager.getInstance().copyLogs();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			textArea.text = text;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			textArea.width = width;
			textArea.height = clearButton.y = button.y = height - button.height;
			button.width = clearButton.width = button.x = width / 2;
		}
		
		public function open(msg:String):void
		{
			text = msg;
			
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this));
		}
		
		public function close():void
		{
			if (isPopUp)
				PopUpManager.removePopUp(this);
		}
		
		protected function button_clickHandler(event:MouseEvent):void
		{
			close();
		}
		
	}
}