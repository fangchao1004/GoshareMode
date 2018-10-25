package com.goshare.util
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeStyle;
	import flash.globalization.LocaleID;

	/**
	 * <p>时间操作工具类</p>
	 * @author Wulingbiao
	 * @langversion 1.0
	 */
	public class DateTimeUtil
	{
		/**
		 * 默认日期格式 
		 */
		public static const DEFAULT_DATE_FORMAT:String="yyyy-MM-dd";  
		/**
		 * 默认日期时间格式 
		 */
		public static const DEFAULT_DATETIME_FORMAT:String="yyyy-MM-dd HH:mm:ss";
		
		public function DateTimeUtil()
		{
		}
		
		/** 
		 * <p>格式化时间, 默认格式为yyyy-MM-dd HH:mm:ss</p> 
		 * @param date 待格式化时间
		 * @param formatString 格式字符串
		 * @return 格式化后字符串
		 */ 
		public static function formatDateTime(date:Date, formatString:String=DEFAULT_DATETIME_FORMAT):String  
		{
			var dateFormater:DateTimeFormatter=new DateTimeFormatter(LocaleID.DEFAULT, DateTimeStyle.SHORT, DateTimeStyle.LONG);
			dateFormater.setDateTimePattern(formatString); 
			return dateFormater.format(date);  
		}
		
	}
}