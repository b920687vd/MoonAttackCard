package ExEvent 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class AsyncFileEvent extends flash.events.Event
	{
		
		public function AsyncFileEvent(type:String, bath:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.bath = bath;
		}
		
		public var bath:String;
		
		static public const FILE_LOADED:String = "file_loaded";
		
	}

}