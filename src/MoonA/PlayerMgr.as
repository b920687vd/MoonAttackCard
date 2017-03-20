package MoonA 
{
	import MoonA.Card.CardPool;
	import MoonA.CharMgr;
	/**
	 * ...
	 * @author OMaster
	 */
	public class PlayerMgr 
	{
		
		public function PlayerMgr() 
		{
			
		}
		
		private function _Init()
		{
			this._deck = new CardPool(true);
			this._hand_card = new CardPool(true);
			this._party = new MoonA.CharMgr();
		}
		
		public var deck:CardPool;
		public var hand_card:CardPool;
		public var party:MoonA.CharMgr;
		public var grave:CardPool;
		
		private var _enemy:PlayerMgr;
		
		public function get enemy():void
		{
			return this._enemy;
		}
		
		public function set enemy(e:PlayerMgr):void
		{
			this._enemy = e;
			this._party.enemy = e._party;
		}
		
	}

}