package com.goshare.view.home
{
	import com.goshare.data.Message;
	import com.goshare.event.AgentManagerEvent;
	import com.goshare.event.AppRCManagerEvent;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.AppRCManager;
	import com.goshare.manager.EventManager;
	import com.goshare.render.ItemRenderFoRbtCtrlList;
	import com.goshare.view.robot.RobotAddView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	
	public class RobotCtrlListView extends UIComponent
	{
		public function RobotCtrlListView()
		{
			super();
			AppRCManager.getInstance().addEventListener(AgentManagerEvent.CLIENT_LOGOUT,clientLogout_Handler);
			EventManager.getInstance().addEventListener(TestEvent.ADD_ROBOT,addRobot_Handler);
			EventManager.getInstance().addEventListener("toldClientOpenTeacherSteam",toldClientOpenTeacherSteam_Handler);
			EventManager.getInstance().addEventListener("toldClientCloseTeacherSteam",toldClientCloseTeacherSteam_Handler);
		}
		
		protected function clientLogout_Handler(event:AgentManagerEvent):void
		{
//			trace("RobotCtrlListView监听到注销");
			clearRbtCtrlList();
		}
		
		private function clearRbtCtrlList():void
		{
			rbtCtrlList.dataProvider = [];
		}
		
		private var lab : Label;
		private var addBtn : Image;
		private var removeBtn : Image;
		private var rbtCtrlList : List;
		private var shadow : DropShadowFilter;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab= new Label();
			lab.text = "机器人控制区";
			addChild(lab);
			lab.visible = false;
			
			///单选 机器人控制列表
			rbtCtrlList = new List();
			rbtCtrlList.itemRendererHeight = 40;
			rbtCtrlList.gap = 4;
			rbtCtrlList.dataProvider=[];
//			rbtCtrlList.labelField = "classInfo";
			rbtCtrlList.labelField = "id";
			rbtCtrlList.itemRendererClass = ItemRenderFoRbtCtrlList;
			rbtCtrlList.addEventListener(UIEvent.CHANGE,rbtCtrlList_changeHandler);
			addChild(rbtCtrlList);
			
			addBtn = new Image();
			addBtn.width = 26;
			addBtn.height = 26;
			addBtn.buttonMode = true;
			addBtn.source = "assets/interactive/addRbt.png";
			addBtn.addEventListener(MouseEvent.CLICK,addBtn_Handler);
			addChild(addBtn);
			
			removeBtn = new Image();
			removeBtn.width = 26;
			removeBtn.height = 26;
			removeBtn.buttonMode = true;
			removeBtn.source = "assets/interactive/removeRbt.png";
			removeBtn.addEventListener(MouseEvent.CLICK,removeBtn_Handler);
			addChild(removeBtn);
			
			shadow= new DropShadowFilter();
			with (shadow) {
				distance = 3;
				angle = 45;
				alpha = .25;
				blurX = 6;
				blurY = 6;
				color = 0x999999;
				hideObject = false;
				inner = false;
				knockout = false;
				quality = 1;
				strength = 1;
			}
			
			addBtn.filters = removeBtn.filters = [shadow];
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			removeBtn.x = width-removeBtn.width-10;
			removeBtn.y = height-removeBtn.height-10;
			
			addBtn.x = removeBtn.x-addBtn.width-10
			addBtn.y = height-addBtn.height-10;
			
			rbtCtrlList.x = 2;
			rbtCtrlList.y=10;
			rbtCtrlList.width = width-4;
			rbtCtrlList.height = addBtn.y-15;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function addBtn_Handler(event:MouseEvent):void
		{
			var rbav:RobotAddView = RobotAddView.getInstance();
			PopUpManager.addPopUp(rbav,null,true,false,0,0.4);
			PopUpManager.centerPopUp(rbav);
		}
		
		private var afterRemoveData : Array = [];
		protected function removeBtn_Handler(event:MouseEvent):void
		{
//			trace("将机器人终端移出控制区");
			for (var i:int = 0; i < rbtCtrlList.selectedIndices.length; i++){
				var removeRbtID : String = rbtCtrlList.dataProvider[rbtCtrlList.selectedIndices[i]].id;
//				trace("移除："+removeRbtID);
				AppRCManager.getInstance().removeClientID = removeRbtID;
//				trace("AppRCManager.getInstance().removeClientID,",AppRCManager.getInstance().removeClientID);
				removeRobotsToControl(removeRbtID) 
				rbtCtrlList.dataProvider[rbtCtrlList.selectedIndices[i]]=null
			}
			
			for (var j:int = 0; j < rbtCtrlList.dataProvider.length; j++){
				if(rbtCtrlList.dataProvider[j]==null)
				{
					rbtCtrlList.dataProvider.splice(j,1);
					j--;
					afterRemoveData = rbtCtrlList.dataProvider;
					DataRefreshHandler();
				}
			}
		}
		
		private function DataRefreshHandler():void
		{
			rbtCtrlList.selectedIndex = -1;
			rbtCtrlList.dataProvider = afterRemoveData;
			if(rbtCtrlList.dataProvider.length==0){
				AppRCManager.getInstance().nowClientID = null;
			}
		}
		
		/** 此前控制区中的所有终端对象 */
		private var lastTimeData : Array = [];
		/** 当前最新要加入的终端对象 */
		private var tempArray : Array = [];
		protected function addRobot_Handler(e:TestEvent):void
		{
			lastTimeData = rbtCtrlList.dataProvider;
			tempArray = [];
			for each (var i:Object in e.data) {
				if(i["online"]){  ///只添加online 在线的机器人  二次过滤
					tempArray.push(i);
				}
			}
			////判断是否重复添加
			if(lastTimeData&&lastTimeData.length>0){
				for (var j:int = 0; j < tempArray.length; j++) {
					for (var k:int = 0; k < lastTimeData.length; k++) {
						if(tempArray[j]["id"]==lastTimeData[k]["id"]){
							Alert.show("有重复元素"+tempArray[j]["id"]+"等。此次操作无效");			
							return;
						}
					}
				}
			}
			
			///将tempData 和 lastTimeData 合并
			if(lastTimeData){
				for each (var x:Object in tempArray){
					lastTimeData.push(x);
				}
			}
			rbtCtrlList.dataProvider = lastTimeData;
			
			////发送消息给最新加入控制区的终端
			makeRobotsToControl(tempArray);
		}
		
		/**
		 * 此情况为：坐席先推流，再将终端加入监控拉流
		 * 发送消息给最新加入控制区的终端  群发
		 */
		private function makeRobotsToControl(newRobotArray:Array):void
		{
			for each (var i:Object in newRobotArray) 
			{
				trace("发送数据的对象：："+i.id);
				
				AppRCManager.getInstance().sendMessageToC1Quick("agentMenChange",{joinFlag:true},
					i.id,AppRCManager.getInstance().userID);
				
				if(AppRCManager.getInstance().isPublishing&&AppRCManager.getInstance().connectedFMS){
//					trace("事先打开摄像头，通知终端-发送流名");
					AppRCManager.getInstance().sendMessageToC1Quick("teacherVideoStreamOpen",{streamName:AppRCManager.getInstance().teacherStreamName},
						i.id,AppRCManager.getInstance().userID);
				}
			}
		}
		
		/**
		 * 此情况为：先将终端加入监控拉流，坐席再推流，
		 * 要向当前控制区的机器人终端 单独发送
		 * 包含坐席视频流的信息
		 */
		protected function toldClientOpenTeacherSteam_Handler(event:Event):void
		{
			for each (var i:Object in lastTimeData) 
			{
				AppRCManager.getInstance().sendMessageToC1Quick("teacherVideoStreamOpen",{streamName:AppRCManager.getInstance().teacherStreamName},
					i.id,AppRCManager.getInstance().userID);
			}
		}
		
		/**
		 * 此情况为：坐席成功推流后，再关闭推流，
		 * 要向当前控制区的机器人终端 单独发送
		 */
		protected function toldClientCloseTeacherSteam_Handler(event:Event):void
		{
			for each (var i:Object in lastTimeData) 
			{
				AppRCManager.getInstance().sendMessageToC1Quick("teacherVideoStreamClose",null,
					i.id,AppRCManager.getInstance().userID);
			}
		}	
		
		////发送消息给移出控制区的终端  rbt
		private function removeRobotsToControl(removeRbtID:String):void
		{
			AppRCManager.getInstance().sendMessageToC1Quick("agentMenChange",{joinFlag:false},
				removeRbtID,AppRCManager.getInstance().userID);
			
			EventManager.getInstance().dispatchEventQuick("removeRbt",removeRbtID);
			EventManager.getInstance().dispatchEventQuick("stopShowDeskStream");
		}
		
		////控制用户点击选择控制列表
		protected function rbtCtrlList_changeHandler(event:UIEvent):void
		{
			
		}
		
	}
}