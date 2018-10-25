package com.goshare.data
{
	/**
	 * 用户信息表单提交时
	 * 与UserInfo类分开
	 * 防止用户在个人中心模块处改变个人信息后，取消提交。造成无法恢复，污染原有信息
	 */	
	public class UserFormInfo
	{
		public function UserFormInfo()
		{
		}
		
		/**表单 用户id账号 手机号     “13000000000”*/
		public static var userId :String;
		/**表单 位图base64转字符串  */		
		public static var userFace :String;  
		/**表单 用户姓名       “张老师”*/
		public static var userName :String;
		/**表单 用户性别       “男”*/
		public static var userGender :String;  
		/**表单 用户生日     "2000-1-1"*/
		public static var userBirthday :String;  
		/**表单 用户住址    "xx省-xx市-xx区"*/
		public static var userAddress :String;
		/**表单 用户籍贯     “xx省-xx市-xx区”*/
		public static var userNativePlace :String;  
		/**表单 用户科目 单选   "语文"*/
		public static var userProject :String;
		/**表单 用户科目 单选   索引*/
		public static var userProjectIndex :int;
		/**表单 用户角色 --是否是班主任  “班主任”*/
		public static var userRole :String;        
		
		/**用户学校代号*/
		public static var school :String;
		
		/** 用户作为某课老师教学的年级和班级对象 的数组*/
		public static var work : Array;
		
		/** 用户作为班主任负责的年级和班级对象 的数组*/
		public static var duty : Array;
	}
}