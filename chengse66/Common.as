package chengse66 
{
	import chengse66.module.InfoObject;
	import chengse66.module.MenuObject;
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class Common 
	{
		public static var URL:String = "http://221.6.86.251:9112/";
		public static var URL1:String = "";
		public static var getMenuURL:String = URL + "ServerTest/AllClassFirstFlash";
		public static var getDocMenuURL:String = URL + "ServerTest/ClassSecondInfoFlash";
		public static var getTypeListURL:String = URL + "ServerTest/ClassTypeFlash";
		public static var getInfoListURL:String = URL + "ServerTest/FileDetailListFlash";
		public static var getInfoURL:String = URL + "ServerTest/FileDetailInfoFlash";
		public static var updatePostiveCount:String = URL + "ServerTest/PositiveCountServlet";
		public static var updateCount:String = URL + "ServerTest/PlayCountServlet";  //阅读和访问量更新
		
		
		//选择的主类别
		public static var SelectMainMenu:MenuObject;
		public static var InfoData:InfoObject;
		
	}

}