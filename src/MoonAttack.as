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
			
		}
	}
}