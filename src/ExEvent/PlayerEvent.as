package ExEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerEvent extends Event 
	{
		
		public function PlayerEvent(type:String, param:Object, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.param = param;
		}
		
		public var param:Object;
		
		static public const CHOOSE_AIM_OVER:String = "choose_aim_over";
		static public const CHOOSE_HAND_OVER:String = "choose_hand_over";
	}

}