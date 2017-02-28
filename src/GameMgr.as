package 
{
	/**
	 * 游戏管理器
	 * @author OMaster
	 */
	public class GameMgr 
	{
		
		public function GameMgr() 
		{
			
		}
		
		public function NewGame():void
		{
			
		}
		
		private function _Update():void
		{
			_CheckDeadUnit();
		}
		
		/**
		 * 检查当前场上是否有死亡单位
		 * 如有，将其破坏，触发其死亡效果，之后移入墓地
		 */
		private function _CheckDeadUnit():void
		{
			
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
			
		}
		
		/**
		 * 将控制权交于玩家，用于选择手卡
		 */
		private function _ControlChooseHand():void
		{
			
		}
		
	}

}