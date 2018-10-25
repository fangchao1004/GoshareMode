package com.goshare.util
{
	/**
	 * 模糊查询+ID排序
	 */
	public class FuzzyQuery_new
	{
		public function FuzzyQuery_new()
		{
		}
		
		private static var fuzzyQuery : FuzzyQuery_new
		
		public static function getInstance():FuzzyQuery_new
		{
			if(!fuzzyQuery) fuzzyQuery = new FuzzyQuery_new();
			
			return fuzzyQuery;
		}
		
		private var tempArray : Array=[];
		private var searchCount : int=0;
		private var sortKey : String = "";
		
		/**
		 * @param keyWord  查询关键字
		 * @param targetArray  查询对象
		 * @param args  搜索哪些字段（优先级逐步降低）
		 * @return 返回查询后且根据 匹配的字段 排序后的结果
		 */
		public function searchHandler(keyWord:String,targetArray:Array,...args):Array
		{
			if(!args)
			{
				trace("搜寻字段不存在");
				return [];
			}
			
			
			tempArray.length =0;
			searchCount=0;
			
			if(keyWord=="")
			{
				return targetArray;
			}
			
			trace("开始查询："+keyWord);
			
			///遍历原先的Data数据
			for each (var area:String in args) 
			{
				searchCount++;
				if(searchCount==1)
				{
					for each (var i:Object in targetArray) 
					{
						if(String(i[area]).substr(0,keyWord.length)==keyWord)
						{
							//							trace("最高优先级的字段，已经找到："+JSON.stringify(i));
							tempArray.push(i);
							sortKey = area;
						}
					}
				}else
				{
					if(tempArray.length==0)
					{
						for each (var k:Object in targetArray) 
						{
							if(String(k[area]).substr(0,keyWord.length)==keyWord)
							{
								//					trace("找到：",i["id"]);
								//								trace("最高字段没找到，后续找到："+JSON.stringify(i));
								tempArray.push(k);
								sortKey = area;
							}
						}
					}
				}
			}
			
			if(tempArray.length>0)
			{
				
				///最后把筛选过后的数据  再按id值的大小 升序排列 
//				var sortArr : Array = tempArray.sortOn(args[0]);
				var sortArr : Array = tempArray.sortOn(sortKey);
				return sortArr;
			}else
			{
				trace("未找到匹配选");
				return [];
			}
		}
	}
}