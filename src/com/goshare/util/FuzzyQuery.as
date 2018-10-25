package com.goshare.util
{
	/**
	 * 模糊查询+ID排序
	 */
	public class FuzzyQuery
	{
		public function FuzzyQuery()
		{
		}
		
		private static var fuzzyQuery : FuzzyQuery
		
		public static function getInstance():FuzzyQuery
		{
			if(!fuzzyQuery) fuzzyQuery = new FuzzyQuery();
			
			return fuzzyQuery;
		}
		
		private var tempArray : Array=[];
		
		/**
		 * @param keyWord  查询关键字
		 * @param targetArray  查询对象
		 * @return 返回查询后且根据ID排序后的结果
		 */
		public function searchHandler(keyWord:String,targetArray:Array,...args):Array
		{
			tempArray.length =0;
			
			if(keyWord=="")
			{
				return targetArray;
			}
			
//			trace("开始查询："+keyWord);
			
			///遍历原先的Data数据
			
			for each (var i:Object in targetArray) 
			{
				if(String(i["id"]).substr(0,keyWord.length)==keyWord)
				{
					//					trace("找到：",i["id"]);
					tempArray.push(i);
				}
			}
			
			///如果 id 中没有 和 keyWord 匹配的话 再尝试 name
			if(tempArray.length==0)
			{
				for each (var j:Object in targetArray) 
				{
					if(String(j["name"]).substr(0,keyWord.length)==keyWord)
					{
						//					trace("找到：",j["name"]);
						tempArray.push(j);
					}
				}
			}
			
			///最后再在class字段中查找
			if(tempArray.length==0)
			{
				for each (var k:Object in targetArray) 
				{
					if(String(k["class"]).substr(0,keyWord.length)==keyWord)
					{
						//					trace("找到：",k["class"]);
						tempArray.push(k);
					}
				}
			}
			
			if(tempArray.length>0)
			{
				///最后把筛选过后的数据  再按id值的大小 升序排列 
				var sortArr : Array = tempArray.sortOn("id",Array.NUMERIC);
				return sortArr;
			}else
			{
				trace("未找到匹配选");
				return [];
			}
		}
	}
}