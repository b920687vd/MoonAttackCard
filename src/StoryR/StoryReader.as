package StoryR 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class StoryReader 
	{
		
		public function StoryReader() 
		{
			
		}
		
		public function load(bath:String):void
		{
			
		}
		
		private var _status:Object;
		private var _curr_story:Array;
		
		private var _curr_index:Array;
		
		private var _anime_model:Object;
		
		public function get text():String
		{
			return _status.text;
		}
		
		public function Next():void
		{
			_curr_index++;
			var new_status:Object = _curr_story[_curr_index];
			if (new_status.hasOwnProperty("text"))
			{
				if (new_status.text == "")
				{
					_anime_model.HideText();
				}
				else
					_anime_model.ShowText(new_status.text);
			}
			
			if	(new_status.hasOwnProperty("portrait"))
			{
				if (new_status.portrait == "")
				{
					_anime_model.HidePortrait();
				}else if (new_status.portrait == "|-dark-|")
				{
					_anime_model.DarkPortrait();
				}else
				{
					_anime_model.ShowPortrait(new_status.portrait);
				}
			}
			Update();
		}
		
		public function Update():void
		{
			
		}
		
	}

}