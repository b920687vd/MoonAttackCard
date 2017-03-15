package 
{
	import Anime.CardPolt;
	import Card.Character;
	import Event.PlayerEvent;
	import flash.events.EventDispatcher;
	/**
	 * 游戏管理器
	 * @author OMaster
	 */
	public class GameMgr 
	{
		
		public function GameMgr() 
		{
			if (!GameMgr.One)
				GameMgr.One = this;
		}
		
		static public var One:GameMgr;
		
		public var event_cube:EventDispatcher;
		
		private var _player_list:Array;
		
		private var _model_card_polt:CardPolt;
		
		/**
		 * 开始新游戏
		 */
		public function NewGame():void
		{
			_InitGame();
			//进入先攻方回合
			_EnterTurn();
		}
		
		/**
		 * 初始化游戏
		 */
		private function _InitGame():void
		{
			_player_list = new Array();
			var _player_1:PlayerMgr = new PlayerMgr();
			var _player_2:PlayerMgr = new PlayerMgr();
			_player_1.enemy = _player_2;
			_player_list.push(_player_1, _player_2);
			
			//加载双方卡组
			_LoadDeck();
			//决定先攻
			_FirstCache();
			//先攻方抽取起始卡牌
			//后攻方抽取起始卡牌
			_InitHand();
			//先攻方布置阵地
			//后攻方布置阵地
			_LoadParty();
		}
		
		/**
		 * 加载双方卡组
		 */
		private function _LoadDeck():void
		{
			
		}
		
		/**
		 * 决定先攻权
		 */
		private function _FirstCache():void
		{
			
		}
		
		/**
		 * 抽取起始手牌
		 */
		private function _InitHand():void
		{
			
		}
		
		/**
		 * 加载双方起始阵地
		 */
		private function _LoadParty():void
		{
			
		}
		
		/**
		 * 进入指定玩家回合
		 */
		private function _EnterTurn(index:int = null):void
		{
			
		}
		
		/**
		 * 结束当前对局
		 */
		public function EndGame():void
		{
			
		}
		
		/**
		 * 更新当前状态
		 */
		public function Update():void
		{
			_CheckDeadUnit();
		}
		
		/**
		 * 检查当前场上是否有死亡单位
		 * 如有，将其破坏，触发其死亡效果，之后移入墓地
		 */
		private function _CheckDeadUnit():void
		{
			for each(var char:Character in _player_list[0].party.list)
			{
				if (char.hp <= 0)
					ActionMgr.Death(char);
			}
		}
		
		/**
		 * 检查当前场上存在的延时效果
		 * 发动其效果，调整计时器，丢弃计时结束的效果
		 */
		private function _CheckRoundEffect():void
		{
			
		}
		
		/**
		 * 将控制权交于玩家，用于选择效果目标
		 */
		private function _ControlChooseAim():void
		{
			this.event_cube.addEventListener(PlayerEvent.CHOOSE_AIM_OVER, _ChooseAimEnd);
			_model_card_polt;
		}
		
		/**
		 * 将控制权交于玩家，用于选择手卡
		 */
		private function _ControlChooseHand():void
		{
			this.event_cube.addEventListener(PlayerEvent.CHOOSE_HAND_OVER, _ChooseHandEnd);
		}
		
		private function _ChooseAimEnd(e:PlayerEvent):void
		{
			this.event_cube.removeEventListener(PlayerEvent.CHOOSE_AIM_OVER, _ChooseAimEnd);
			ActionMgr.setContext("effect_aim", e.param.aim);
		}
		
		private function _ChooseHandEnd(e:PlayerEvent):void
		{
			this.event_cube.removeEventListener(PlayerEvent.CHOOSE_HAND_OVER, _ChooseHandEnd);
			ActionMgr.setContext("hand_cost", e.param.hand);
		}
	}

}