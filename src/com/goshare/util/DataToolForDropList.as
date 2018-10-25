package com.goshare.util
{
	/**
	 * 数据工具--
	 * 用于恢复下拉列表的选中情况
	 * 和根据列表显示框中的字符串生成规定数据
	 * @author fangchao
	 */
	public class DataToolForDropList
	{
		public function DataToolForDropList()
		{
		}
		
		private static var instance : DataToolForDropList;
		
		public static function getInstance():DataToolForDropList
		{
			if(!instance){
				instance = new DataToolForDropList;
			}
			return instance;
		}
		
		/**
		 * 下拉列表--要支持多选  用作班级列表
		 * 通过后台获取的值数组，来恢复下拉列表的选中状态
		 * @param valueArray  传入["002", "003","011"]
		 * @return  返回[1,2,10]
		 */
		public function recoveDropListSelectedIndicesByValueArray(valueArray : Array):Vector.<int>{
			var newVector :Vector.<int> = new Vector.<int>();
			for each (var i:String in valueArray) 
			{
				newVector.push((parseInt(i)-1))
			}
			return newVector;
		}
		
		/**
		 * 下拉列表--要支持多选 用作班级列表
		 * 通过后台获取的值数组，来恢复下拉列表的文本框内容
		 * @param valueArray 传入 ["002", "003","011"]
		 * @return 返回 "2,3,11"
		 */
		public function recoverDropListTxtsByValueArray(valueArray : Array):String{
			var newStr : String = "";
			for (var i:int = 0; i < valueArray.length; i++) 
			{
				if(i<valueArray.length-1){
					newStr = newStr+String(parseInt(valueArray[i]))+","
				}
				else{
					newStr = newStr+String(parseInt(valueArray[i]))
				}
			}
			return newStr;
		}
		
		/**
		 * 下拉列表--单选
		 * 通过后台获取的值字符串，来恢复下拉列表的选中状态
		 * @param ValueStr 传入"005"
		 * @return 返回 4
		 */
		public function recoverDropListSelectedIndexByValueArray(ValueStr : String):int{
			var indexInt : int = 0;
			indexInt = parseInt(ValueStr)-1;
			return indexInt;
		}
		
		/**
		 * 下拉列表--单选
		 * 通过后台获取的值字符串，来恢复下拉列表的文本框内容
		 * @param ValueStr 传入"005"
		 * @return 返回 "5"
		 */
		public function recoverDropListTxtByValueArray(ValueStr : String):String{
			var newStr : String = "";
			newStr = String(parseInt(ValueStr));
			return newStr;
		}
		
		/**
		 *下拉列表--多选  用作班级列表
		 * 根据列表的显示框的字符串，生成值数组
		 * @param listTxts  该下拉列表的显示框中的字符串  "1,3,5,10"
		 * @return 生成的数组 ["001","003","005","010"]
		 */
		public function transDropListTxtsToValueArray(listTxts:String):Array{
			var tempvalueArray : Array = [];
			var finalValueArray : Array = [];
			tempvalueArray = listTxts.split(",");
			for each (var i:String in tempvalueArray) 
			{
				while(i.length<3){
					i = "0"+i
				}
				finalValueArray.push(i);
			}
			return finalValueArray;
		}
		
		/**
		 * 下拉列表--单选
		 * 根据列表的显示框的单个字符串，生成规定字符串
		 * @param listTxt  传入 "3"
		 * @return  返回 "003"
		 */
		public function transDropListTxtToValueArray(listTxt:String):String{
			while(listTxt.length<3){
				listTxt = "0"+listTxt;
			}
			return listTxt;
		}
	}
}