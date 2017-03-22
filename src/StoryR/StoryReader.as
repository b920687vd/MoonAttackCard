package StoryR 
{
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	/**
	 * 故事阅读器
	 * @author ...
	 */
	public class StoryReader 
	{
		
		public function StoryReader() 
		{
			
		}
		
		public function load(bath:String):void
		{
			if (ResourceMgr.Map[bath]||ResourceMgr.Map["story_file"])
			{
				this._curr_story = ResourceMgr.Map[bath];
				return;
			}
			var story_loader:URLLoader = new URLLoader();
			var story_request:URLRequest = new URLRequest(bath);
			story_loader.load(story_request);
			story_loader.addEventListener(Event.COMPLETE,_StoryFileLoadComplete);
		}
		
		private function _StoryFileLoadComplete(e:Event):void
		{
			var loaded_data:Object = JSON.parse(e.target.data);
			ResourceMgr.Map["story_file"] = loaded_data;
			
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