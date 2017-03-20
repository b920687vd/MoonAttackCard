package Data 
{
	import MoonA.Card.CardBase;
	import MoonA.Card.CardPool;
	import ExEvent.AsyncFileEvent;
	import ResourceMgr;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * 卡组加载器
	 * @author Adam White
	 */
	public class DeckReader 
	{
		
		public function DeckReader() 
		{
			//静态类。不实例化。
		}
		
		private static var _loading_dict:Dictionary = new Dictionary();
		private static var _loader_dict:Dictionary = new Dictionary();
		private static var _status_dict:Dictionary = new Dictionary();
		
		/**
		 * 查询某路径文件的加载情况
		 * @param	bath
		 * @return
		 */
		static public function status(bath:String):String
		{
			return _status_dict[bath]?_status_dict[bath]:"null";
		}
		
		/**
		 * 按路径加载卡组文件，并返回其容器
		 * @param	bath
		 * @return
		 */
		static public function read(bath:String):CardPool
		{
			//若此卡组已经下载并分析完毕，则直接返回；
			if (_loading_dict[bath])
				return _loading_dict[bath];
			
			//若此文件已经下载，则进行分析后，直接返回；
			if (ResourceMgr.Map[bath])
			{
				var _loading_deck = new CardPool();
				_AnalizeLoadedData(ResourceMgr.Map[bath], _loading_deck);
				_status_dict[_loader_dict[e.target]] = "loaded";
				return _loading_deck;
			}
			
			//否则，先进行文件下载
			var _loading_deck = new CardPool();
			_loading_dict[bath] = _loading_deck;
			
			var file_loader:URLLoader = new URLLoader();
			var file_request:URLRequest = new URLRequest(bath);
			
			file_loader.load(file_request);
			file_loader.addEventListener(Event.COMPLETE, _FileLoadComplete);
			_loader_dict[file_loader] = bath;
			
			_status_dict[bath] = "loading";
			
			return _loading_deck;
		}
		
		/**
		 * 文件加载完毕后进行解析
		 * @param	e
		 */
		static private function _FileLoadComplete(e:Event):void
		{
			var loading_deck:CardPool = _loading_dict[_loader_dict[e.target]];
			_AnalizeLoadedData(JSON.parse(e.target.data), loading_deck);
			
			_status_dict[_loader_dict[e.target]] = "loaded";
			
			//通过资源管理器发送消息
			var tips:AsyncFileEvent = new AsyncFileEvent(AsyncFileEvent.FILE_LOADED, _loader_dict[e.target]);
			ResourceMgr.Event_Tube.dispatchEvent(tips);
			
			ResourceMgr.Map[_loader_dict[e.target]] = e.target.data;
		}
		
		static private function _AnalizeLoadedData(data:Object,pool:CardPool):void
		{
			var data_deck:Array = data.deck;
			for each(var i:Object in data_deck)
			{
				var c:CardBase = new CardBase(i);
				pool.add(c);
			}
		}
		
	}

}