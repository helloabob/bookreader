package chengse66.module 
{
	/**
	 * ...
	 * @author chengse66@sina.com
	 */
	public class InfoObject 
	{
		/*<item>
			<file_id><![CDATA[201411141543101003201830000]]></file_id>
			<file_name><![CDATA[50元一公斤的怀山药]]></file_name>
			<file_class_third><![CDATA[101]]></file_class_third>
			<file_path><![CDATA[民族文化\民族产业\50元一公斤的怀山药]]></file_path>
			<file_positivecount><![CDATA[0]]></file_positivecount>
		  </item>*/

		public var file_id:String;
		public var file_name:String;
		public var file_class_third:String;
		public var file_path:String;
		public var file_positivecount:String;
		
		public var file_group_type:String;
		public var file_setnum:String;
		public var file_class_first:String;
		public var file_class_second:String;
		public var file_uploader:String;
		public var file_upload_date:String;
		public var file_desc:String;
		public var file_remarks:String;
		public var file_small:String;
		public var file_dlcount:String;
		public var file_playcount:String;
		public var file_group_name:String;
		public var file_group_mall:String;
		public var file_wenjian_name:String;
		
		public function InfoObject() 
		{
			
		}
		
		public static function create(item:XML):InfoObject {
			
			var io:InfoObject = new InfoObject();
			io.file_id = String(item.file_id);
			io.file_name = String(item.file_name);
			io.file_class_third = String(item.file_class_third);
			io.file_path = String(item.file_path);
			io.file_positivecount = String(item.file_positivecount);
			io.file_wenjian_name = String(item.name);
			
			
			io.file_group_type = String(item.file_group_type);
			io.file_setnum = String(item.file_setnum);
			io.file_class_first = String(item.file_class_first);
			io.file_class_second = String(item.file_class_second);

			io.file_uploader = String(item.file_uploader);
			io.file_upload_date = String(item.file_upload_date);
			io.file_desc = String(item.file_desc);
			io.file_remarks = String(item.file_remarks);
			io.file_small = String(item.file_small);
			io.file_dlcount = String(item.file_dlcount);
			io.file_playcount = String(item.file_playcount);
			io.file_group_name = String(item.file_group_name);
			io.file_group_mall = String(item.file_group_mall);
			return io;
		}
	}

}