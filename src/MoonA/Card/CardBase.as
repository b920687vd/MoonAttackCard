package MoonA.Card
{
	import MoonA.ActionMgr;
	import Console;
	import flash.utils.Dictionary;
	
	/**卡牌基类*/
	public class CardBase
	{
		public function CardBase(data:Object)
		{
			//...等待继承实现
			this._discribe = data.discribe;
			this._name = data.name;
			this._pic_bath = data.pic_bath;
			_init();
			
			if(data.action)
			{
				for each(var actionlist:Object in data.action)
				{
					for each(var action:Object in actionlist.list as Array)
					{
						this.addAction(actionlist.point,MoonA.ActionLib.Action(action.name,action.param,actionlist.point));
					}
				}
			}
		}
		
		private function _init():void
		{
			_action_list = new Dictionary();
		}
		
		/**
		 * 动作列表
		 */
		private var _action_list:Dictionary;
		/**
		 * 卡面描述
		 */
		private var _discribe:String;
		/**
		 * 卡片标签（分类）
		 */
		private var _label_list:Dictionary;
		/**
		 * 卡名
		 */
		private var _name:String;
		/**
		 * 所有者
		 */
		private var _owner:Character;
		
		private var _pic_bath:String;
		
		public function get pic_bath():String
		{
			return this._pic_bath;
		}
		
		public function get owner():Character
		{
			return this._owner;
		}
		
		public function get name():String
		{
			return this._name;
		}
		/**
		 * 卡面描述
		 */
		public function get discribe():String
		{
			return this._discribe
		}
		
		public function set discribe(d:String):void
		{
			this._discribe = d;
		}
		
		/**
		 * 初始化卡片数据
		 */
		public function inst():void
		{
			_action_list = new Dictionary();
			_label_list = new Dictionary();
		}
		
		/**获得某一动作所有操作*/
		public function getAction(point:String):Array
		{
			var actionlist:Array =  _action_list[point];
			return actionlist;
		}
		
		/**执行某一动作所有操作（添加到末尾）
		 * 此处设计逻辑有缺陷，不建议调用*/
		public function doAction(point:String):void
		{
			if(this._action_list[point])
				MoonA.ActionMgr.PushAction(this._action_list[point]);
		}
		
		/**为某一卡牌添加动作*/
		protected function addAction(point:String,action:Function):void
		{
			Console.print(this._name.concat("添加了", point, "时点的动作"));
			if(!_action_list[point])
				_action_list[point] = new Array();
			
			_action_list[point].push(action);
		}
		
		public function Action_Play():void
		{
			MoonA.ActionMgr.Play(this);
		}
		
		/**检查该卡片是否属于某个分类*/
		public function HasLabel(label:String):Boolean
		{
			return this._label_list[label];
		}
		
	}
}