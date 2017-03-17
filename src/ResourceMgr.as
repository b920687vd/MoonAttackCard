package 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * 资源管理器
	 * @author Adan White
	 */
	public class ResourceMgr 
	{
		
		public function ResourceMgr() 
		{
			
		}
		
		public static var Map:Dictionary = new Dictionary();
		public static var Event_Tube:EventDispatcher = new EventDispatcher();
		
	}

}