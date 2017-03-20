package MoonA
{
	import Console;
	import MoonA.Card.CardBase;
	import MoonA.Card.Character;
	public class ActionLib
	{
		public function ActionLib()
		{
		
		}
		
		static public function Action(name:String,param:Object,point:String):Function
		{
			var action:Function;
			switch(name)
			{
				case "hurt_both_to":
					action = function():void
					{
						
					}
					break;
				case "damage":
					action = function():void
					{
						Console.print("造成效果伤害！")
					}
				case "aoe_fire":
					action = function():void
					{
						var target:CardBase = ActionMgr.ActionTarget(point);
						var paramater:Array = param as Array;
						Console.print(target.name+"触发效果，对" + param[0] + "全体造成" + param[1] + "点火焰伤害");
						ActionMgr.Damage(target, "random_enemy", 1, "fire");
					}
				default:
					break;
			}
			return action;
		}
		
	}
}