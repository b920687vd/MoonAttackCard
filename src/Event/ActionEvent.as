package Event 
{
	import flash.events.Event;
	
	public class ActionEvent extends Event
	{
		public function ActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		static public const ACION_OVER:String = "action_over";
		static public const NO_ACTION_LEFT:String = "no_action_left";
		
	}
}