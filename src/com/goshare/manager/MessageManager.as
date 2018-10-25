package com.goshare.manager
{
	import com.goshare.data.Message;
	import com.goshare.data.MessageType;
	

	public class MessageManager
	{
		public function MessageManager()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:AppAssetsManager;
		
		public static function getInstance():AppAssetsManager
		{
			if (!instance)
				instance = new AppAssetsManager();
			
			return instance;
		}
		
		/**
		 * 发送消息给C1端
		 */		
		public function sendMessageToC1(message:Message):void
		{
//			var sendmessage:Message = new Message();
//			sendmessage.messageType = isSeatClient ? MessageType.Z003 : MessageType.C004;
//			sendmessage.messageContent = message;
//			sendmessage.messageTarget = message.messageTarget;
//			sendmessage.messageSource = message.messageSource;
//			sendMessage(sendmessage);
		}
	}
}