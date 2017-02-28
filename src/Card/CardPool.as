package Card 
{
	/**
	 * 卡池
	 * 用于表示一系列卡片的集合
	 * 分为有重复（表示个体）和无重复（表示种类）的两种卡池
	 * @author OMaster
	 */
	public class CardPool 
	{
		
		public function CardPool(isRepeat:Boolean = true) 
		{
			this._is_repeat = isRepeat;
			this._pool = new Array();
		}
		
		private var _is_repeat:Boolean;
		
		private var _pool:Array;
		
		/**
		 * 向卡池中添加卡片
		 * @param	card
		 */
		public function add(card:CardBase):void
		{
			this._pool.push(card);
		}
		
		/**
		 * 获得卡池中的随机卡片
		 * @return 随机卡片
		 */
		public function random():CardBase
		{
			if (this._pool.length == 0)
				return;
			
			var i:int = Math.floor(Math.random() * (this._pool.length as Number));
			return this._pool[i];
		}
		
	}

}