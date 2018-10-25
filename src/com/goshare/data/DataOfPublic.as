package com.goshare.data
{
	import com.goshare.manager.AgentManager;
	import com.goshare.manager.AppRCManager;
	
	/**
	 * 公共数据
	 */	
	public class DataOfPublic
	{
		public function DataOfPublic()
		{
			getYearsData();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:DataOfPublic;
		
		public static function getInstance():DataOfPublic
		{
			if (!instance) instance = new DataOfPublic();
			return instance;
		}
		
		public var version : String = "1.0.0";
		
		/**
		 * 年级数据
		 */		
		public var gradeData : Array =[{"name":"1","value":"001"},{"name":"2","value":"002"},{"name":"3","value":"003"},
			{"name":"4","value":"004"},{"name":"5","value":"005"},{"name":"6","value":"006"}];
		
		/**
		 * 班级数据
		 */
		public 	var classData : Array = [{"name":"1","value":"001"},{"name":"2","value":"002"},{"name":"3","value":"003"},
			{"name":"4","value":"004"},{"name":"5","value":"005"},{"name":"6","value":"006"}];
		
		/**
		 * 科目数据
		 */
		public var subjectData : Array = ["语文","数学","英语","品德","体育","音乐","美术","科学"];
		
		
		/**
		 * 机器人列表信息（测试）
		 */
		public var robotInfoListTest : Array = 
			[{"id":"T0000037","status":"01","name":"机器人1","class":"一年1班"},
				{"id":"T0000038","status":"01","name":"机器人2","class":"一年2班"},
				{"id":"T0000039","status":"01","name":"机器人3","class":"一年3班"},
				{"id":"T0000040","status":"01","name":"机器人4","class":"一年4班"}]
		
		/**
		 *年份数组
		 */
		public var yearDataArray : Array = getYearsData();
		
		/**
		 *创建年份数组--当前年份到前100年
		 * @return  ["2018","2017",...,"1919"]  
		 */
		private function getYearsData():Array
		{
			var yearArray : Array = [];
			var date : Date =new Date();
			for (var i:int = 0; i < 100; i++) {
				yearArray.push(date.fullYear-i+"")
			}
			return yearArray;
		}
		
		/**
		 *选中的课件信息 
		 */
		public var fileDataOfSelected : Object = null;
		
		/**
		 *注册成功后的数据 
		 * 用于发往后台，
		 * 或者从后台获取来保存
		 */
		public var allDataByRegsiter : Object = null;
		/*
		注册后 正式发送至服务端的数据格式如下: 
		{
		"gender": "男",
		"duty": [{
		"role": "班主任",
		"TeachClasses": ["002", "003"],
		"grade": "001"
		}, {
		"role": "班主任",
		"TeachClasses": ["005"],
		"grade": "002"
		}],
		"userFace": "/9POz//Szc7/z83N/8/Nzf/Ozs7/0NDQ/9LQ0P/Qzs7/0c3L/9",
		"userName": "asd",
		"work": [{
		"subject": "数学",
		"TeachClasses": ["001", "002"],
		"grade": "001"
		}, {
		"subject": "数学",
		"TeachClasses": ["002", "003"],
		"grade": "002"
		}],
		"userId": "13000000000",
		"school": "000000002"
		}
		*/
	}
}