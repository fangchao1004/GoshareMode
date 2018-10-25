package com.goshare.data
{
	import flash.display.BitmapData;

	/**
	 * 注册时的数据保存
	 * 
	 * 用于数据在不同类之间传递公用
	 */	
	public class UserInfo
	{
		public function UserInfo()
		{
		}
		
		/**用户账号ID*/
		public static var userId :String; 
		
		/**用户照片转base64*/
		public static var userFace :String; 
		
		/**用户照片位图*/
		public static var userFaceBitmapData : BitmapData;
		
		/**用户姓名*/
		public static var userName :String; 
	
		/**用户性别  “男”/“女”*/
		public static var gender :String; 
		
		/**用户学校代号*/
		public static var school :String;
		
		
		/** 用户作为某课老师教学的年级和班级对象 的数组*/
		public static var work : Array;
		
		/** 用户作为班主任负责的年级和班级对象 的数组*/
		public static var duty : Array;
		
	}
}