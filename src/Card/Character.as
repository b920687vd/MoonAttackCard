package Card
{
	/**角色卡牌*/
	public class Character extends CardBase
	{
		public function Character(data:Object)
		{
			super(data);
		}
		
		public var hp:int = 10;
		
		public var atk:int = 2;
		
		public var def:int = 1;
	}
}