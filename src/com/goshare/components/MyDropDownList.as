/**
 * Copyright (c) 2014-present, ErZhuan(coco) Xie
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
package com.goshare.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.HorizontalAlign;
	import coco.component.List;
	import coco.component.TextInput;
	import coco.component.VerticalAlign;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	
	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	
	/**
	 * DropDownList Component
	 * 
	 * @author Coco
	 * 
	 */	
	public class MyDropDownList extends TextInput
	{
		public function MyDropDownList()
		{
			super();
			
			autoDrawSkin = false;
			editable = false;
			selectable = false;
			addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
		}
		
		
		//---------------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------------------------------------------------------
		private var _MytextAlign : String;

		public function get MytextAlign():String
		{
			return _MytextAlign;
		}

		public function set MytextAlign(value:String):void
		{
			_MytextAlign = value;
			invalidateProperties();
		}

		
		private var _isOpened:Boolean = false;
		
		public function get isOpened():Boolean
		{
			return _isOpened;
		}
		
		public function set isOpened(value:Boolean):void
		{
			_isOpened = value;
		}
		
		
		public var list:List;
		
		//---------------------
		//	dataProvider
		//---------------------
		
		private var _dataProvider:Array;
		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			
			invalidateList();
		}
		
		
		//--------------------------------
		// request selection
		//--------------------------------
		
		private var _requestSelection:Boolean = true;
		
		public function get requestSelection():Boolean
		{
			return _requestSelection;
		}
		
		public function set requestSelection(value:Boolean):void
		{
			if (_requestSelection == value) return;
			_requestSelection = value;
			invalidateList();
		}
		
		public var allowMultipleSelection : Boolean=false;

		
		//--------------------------------
		// 选中的索引
		//--------------------------------
		private var _selectedIndex:int = -1;
		
		/**
		 * 选中的索引 
		 */	
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			if (_selectedIndex == value)
				return;
			_selectedIndex = value;
			
//			invalidateList();
		}
		
		////选中的索引数组
		/*private var _selectedIndexs : Vector.<int> = new Vector.<int>();

		public function get selectedIndexs():Vector.<int>
		{
			return _selectedIndexs;
		}

		public function set selectedIndexs(value:Vector.<int>):void
		{
			_selectedIndexs = value;
			invalidateList();
		}*/
		
		//--------------------------------
		// 渲染器
		//--------------------------------
		
		private var _itemRendererClass:Class = DefaultItemRenderer;
		
		public function get itemRendererClass():Class
		{
			return _itemRendererClass;
		}
		
		public function set itemRendererClass(value:Class):void
		{
			if (_itemRendererClass == value) return;
			_itemRendererClass = value;
			invalidateList();
		}
		
		
		//--------------------------------
		// 选中的对象
		//--------------------------------
		
		/**
		 * 选中的对象
		 */	
		public function get selectedItem():Object
		{
			if (!dataProvider || 
				dataProvider.length == 0 ||
				selectedIndex < 0 ||
				selectedIndex >= dataProvider.length)
				return null;
			else
				return dataProvider[selectedIndex];
		}
		
		
		
		private var _labelField:String;
		
		public function get labelField():String
		{
			return _labelField;
		}
		
		public function set labelField(value:String):void
		{
			if (_labelField == value) return;
			_labelField = value;
			invalidateList();
		}
		
		
		//---------------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			list = new List();
			list.height = height *2.5;
			list.allowMultipleSelection = allowMultipleSelection;
			list.addEventListener(UIEvent.CHANGE, list_changeHandler);
			invalidateList();
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			list.width = width;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			textAlign = MytextAlign;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(0xf6f5f5);
			graphics.drawRoundRectComplex(0,0,width,height,0,12,0,12);
			graphics.endFill();
		}
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			if (isOpened)
				close()
			else
				open();
		}
		
		/**
		 *选中的对象集合数组 
		 */
		public var mySelectedItems :Array = [];
		
		protected function list_changeHandler(event:UIEvent):void
		{
			_selectedIndex = list.selectedIndex;
			
			if(!list.allowMultipleSelection)
				close();
			
			mySelectedItems = [];
			var tempTxt : String = "";
			
			for (var j:int = 0; j <  list.selectedItems.length; j++) 
			{
				if(list.selectedItem.hasOwnProperty(labelField))
				{
					if(j<list.selectedItems.length-1)
						tempTxt = tempTxt + list.selectedItems[j][labelField]+","
					else
						tempTxt = tempTxt + list.selectedItems[j][labelField]
				}else
				{
					if(j<list.selectedItems.length-1)
						tempTxt = tempTxt+list.selectedItems[j].toString()+","
					else
						tempTxt = tempTxt + list.selectedItems[j].toString()
				}
				
				mySelectedItems.push(list.selectedItems[j]);
			}
			
			text = tempTxt;
			
			dispatchEvent(event);
		}
		
		public function open():void
		{
			application.stage.addEventListener(MouseEvent.MOUSE_DOWN, application_mouseDownHandler, true);
			
			list.x = 0;
			list.y = height;
			PopUpManager.addPopUp(list, this);
			
			isOpened = true;
		}
		
		public function close():void
		{
			application.stage.removeEventListener(MouseEvent.MOUSE_DOWN, application_mouseDownHandler, true);
			
			PopUpManager.removePopUp(list);
			
			isOpened = false;
		}
		
		protected function application_mouseDownHandler(event:MouseEvent):void
		{
			var item:DisplayObject = event.target as DisplayObject;
			if (!contains(item) && !list.contains(item))  // mouse down outside
				close();
		}
		
		//---------------------------------------------------------------------------------------------------------------------
		//
		// List Component Invalidate
		//
		//---------------------------------------------------------------------------------------------------------------------
		
		private var invalidateListFlag:Boolean = false;
		
		private function invalidateList():void
		{
			if (!invalidateListFlag)
			{
				invalidateListFlag = true;
				callLater(validateList);
			}
		}
		
		private function validateList():void
		{
			if (invalidateListFlag)
			{
				invalidateListFlag = false;
				updateList();
			}
		}
		
		private function updateList():void
		{
			list.dataProvider = dataProvider;
			list.selectedIndex = selectedIndex;
			list.itemRendererClass = itemRendererClass;
			list.labelField = labelField;
			list.horizontalAlign = HorizontalAlign.JUSTIFY;
			list.verticalAlign = VerticalAlign.TOP;
		}
		
	}
}