package
{
	import Card.Character;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import Card.CardBase;
	import Anime.AnimeModel;
	
	public class MoonAttack extends Sprite
	{
		public function MoonAttack()
		{
			this.stage.stageWidth = 1024;
			this.stage.stageHeight = 576;
			this.stage.align = StageAlign.TOP_LEFT;
			this.addChild(Console.inst());
			Console.printBlock("游戏开始！");
			var card1:Character = new Character(
				{
					discribe:"这是一张新卡",
					name:"怪物A",
					action:[
						{point:"attack_after",list:[{name:"aoe_fire",param:["enemy",1]}]}
					]
				}
			)
			var card2:Character = new Character(
				{
					discribe:"这是一张新卡",
					name:"怪物B",
					action:[
						{point:"play",list:[{name:"aoe_fire",param:["enemy",2]}]}
					]
				}
			)
			var party1:CharMgr = new CharMgr();
			var party2:CharMgr = new CharMgr();
			party1.enemy = party2;
			party1.addOneParty(card2);
			party2.addOneEnemy(card1);
			ActionMgr.Attack(card1, card2);
		}
	}
}