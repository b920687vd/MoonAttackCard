package MoonA.Card 
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
			this.pool = new Array();
		}
		
		private var _is_repeat:Boolean;
		
		/**
		 * 卡池的数组格式数据源
		 */
		public var pool:Array;
		
		/**
		 * 向卡池中添加卡片
		 * @param	card
		 */
		public function add(card:CardBase):void
		{
			this.pool.push(card);
		}
		
		/**
		 * 获得卡池中的随机卡片
		 * @return 随机卡片
		 */
		public function random():CardBase
		{
			if (this.pool.length == 0)
				return null;
			
			var i:int = Math.floor(Math.random() * (this.pool.length as Number));
			return this.pool[i];
		}
		
		/**
		 * 取出卡池最上方的卡片
		 */
		public function pop():CardBase
		{
			if (this.pool.length == 0)
				return null;
			
			return this.pool.pop();
		}
		
	}

}