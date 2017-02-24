package
{
	import Card.Character;
	/**
	 * 队伍管理器
	 * 管理双方的角色队伍
	 * 负责在队伍中查找，插入，删除角色
	 */
	public class CharMgr
	{
		public function CharMgr()
		{
			_init();
			Group_List.push(this);
			if (!CharMgr.One)
				CharMgr.One = this;
		}
		
		static public var One:CharMgr;
		static public var Enemy:CharMgr;
		
		static public var Group_List:Array = new Array();;
		
		private var _party_list:Array;
		private var _enemy:CharMgr;
		
		public function set enemy(e:CharMgr):void
		{
			this._enemy = e;
			if(!e.enemy)
				e.enemy = this;
		}
		
		public function get enemy():CharMgr
		{
			return this._enemy;
		}
		
		public function _init():void
		{
			_party_list = new Array();
		}
		
		static public function getGroup(one:Character):CharMgr
		{
			for each(var group:CharMgr in CharMgr.Group_List)
			{
				if (group.hasItem(one))
					return group;
			}
			return null;
		}
		
		public function hasItem(one:Character):Boolean
		{
			if (this._party_list.indexOf(one) == -1)
				return false;
			else
				return true;
		}
		
		public function getRandom(list:Object):Character
		{
			var returnchar:Character;
			var randomlist:Array;
			if(list is String)
			{
				if(list == "self")
					randomlist = this._party_list;
				else if(list == "enemy")
					randomlist = this._enemy._party_list;
				else if(list == "all")
					randomlist = this._enemy._party_list.concat(One._party_list);
			}else if(list is Array)
			{
				randomlist == list;
			}
			var random:int = Math.random()*randomlist.length;
			returnchar = randomlist[random];
			return returnchar;
		}
		
		public function addOneParty(add:Character):void
		{
			One._party_list.push(add);
		}
		
		public function addOneEnemy(add:Character):void
		{
			One._enemy._party_list.push(add);
		}
	}
}