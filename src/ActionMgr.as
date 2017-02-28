package
{
	import flash.events.EventDispatcher;
	
	import Card.CardBase;
	import Card.Character;
	
	import Event.GameEvent;
	
	public class ActionMgr
	{
		public function ActionMgr()
		{
			inst();
			Console.print("游戏管理器初始化完成");
		}
		
		private function inst():void
		{
			_action_list = new Array();
		}
		
		static public var One:ActionMgr = new ActionMgr();
		
		private var _event_cube:EventDispatcher = new EventDispatcher();
		
		private var _action_list:Array = new Array();
		private var _curr_aciton:Function;
		
		/**事件处理时的上下文*/
		private var _context:Object = new Object;
		
		/**添加事件（在队列末尾）*/
		static public function PushAction(action:Object):void
		{
			if(action is Function)
			{
				Console.print("动作列表中添加处理动作")
				One._action_list.push(action);
			}else if (action is Array)
			{
				for each(var a:Function in action)
				{
					PushAction(a);
				}
			}
		}
		
		static public function get Context():Object
		{
			return One._context;
		}
		
		static public function set Context(c:Object):void
		{
			One._context = c;
		}
		
		static public function setContext(key:String,value:*):void
		{
			One._context[key] = value;
		}
		
		/**插入事件（在队列前端）*/
		static public function InsertAction(action:Object):void
		{
			if(action is Function)
			{
				One._action_list.splice(0,0,action);
			}
		}
		
		static private function get_aim(source:Object,aim:Object):Character
		{
			var hurtchar:Character;
			var sourceChar:Character;
			if (source is Character)
			{
				sourceChar = source as Character;
			}else if(source is CardBase)
			{
				sourceChar = (source as CardBase).owner;
			}
			
			if(aim is Character)
			{
				hurtchar = aim as Character;
			}else if(aim == "random_enemy")
			{
				hurtchar = CharMgr.getGroup(sourceChar).getRandom("enemy");
			}
			return hurtchar;
		}
		
		/**攻击动作*/
		static public function Attack(source:Character,aim:Object):void
		{
			var sourcechar:Character = source;
			var hurtchar:Character = ActionMgr.get_aim(source,aim);
			
			Console.print(sourcechar.name.concat("攻击了", hurtchar.name, "!"));
			
			//设置攻击动作的上下文以响应流程事件
			setContext("attack_point", 0);
			setContext("attack_type", "physic");
			setContext("attack_source", sourcechar);
			setContext("attack_aim", hurtchar);
			PushAction(source.getAction("attack_before"));
			PushAction(hurtchar.getAction("attack_aimed"));
			ActionMgr.Do();
			//处理完攻击源和攻击目标的前置事件后，为避免可能出现的目标转移、类型变更等，使用上下文指定之后的处理
			var attack_point:int = Context["attack_point"] + Context["attack_source"].atk - Context["attack_aim"].def;
			
			//之后执行伤害动作，默认伤害类型为物理伤害("physic")
			Damage(Context["attack_source"], Context["attack_aim"], attack_point, Context["attack_type"]);
			
			//之后执行双方的攻击后置事件
			PushAction(Context["attack_source"].getAction("attack_after"));
			PushAction(Context["attack_aim"].getAction("attacked_after"));
			ActionMgr.Do();
		}
		
		/**
		 * 打出牌
		 */
		static public function Play(source:CardBase):void
		{
			PushAction(source.getAction("play"));
			Do();
		}
		
		/**
		 * 造成伤害
		 */
		static public function Damage(source:CardBase,aim:Object,point:Number,type:String):void
		{
			var sourcechar:CardBase = source;
			var hurtchar:Character = ActionMgr.get_aim(sourcechar,aim);
			
			//设置伤害动作的上下文以响应流程事件
			setContext("damage_point", point);
			setContext("damage_type", type);
			setContext("damage_source", sourcechar);
			setContext("damage_aim", hurtchar);
			PushAction(source.getAction("damage_before"));
			PushAction(hurtchar.getAction("damage_aimed"));
			ActionMgr.Do();
			//处理完伤害源和伤害目标的前置事件后，为避免可能出现的目标转移，使用上下文指定之后的处理
			(Context["damage_aim"] as Character).hp -= Context["damage_point"];
			
			Console.print(Context["damage_source"].name.concat("对", Context["damage_aim"].name, "造成了",Context["damage_point"],"点",Context["damage_type"],"类型的伤害！"));
			
			//之后执行双方的伤害后置事件
			PushAction(Context["damage_source"].getAction("damage_after"));
			PushAction(Context["damage_aim"].getAction("damage_hurted"));
			ActionMgr.Do();
		}
		
		/**
		 * 执行当前队列里的操作
		 */
		static public function Do():void
		{
			if(One._action_list&&One._action_list[0])
				One._curr_aciton = One._action_list.splice(0,1)[0];
			else
			{
				One._event_cube.dispatchEvent(new GameEvent(GameEvent.NO_ACTION_LEFT));
				return;
			}
			One._curr_aciton();
			One._curr_aciton = null;
			One._event_cube.addEventListener(GameEvent.ACION_OVER,doNext);
		}
		
		/**上一项操作完毕，继续下一项*/
		static public function doNext(e:GameEvent):void
		{
			One._event_cube.removeEventListener(GameEvent.ACION_OVER,doNext);
			Do();
		}
	}
}