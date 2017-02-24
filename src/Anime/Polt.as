package Anime
{
	/**
	 * ...
	 * @author OMaster
	 */
	public class Polt 
	{
		
		public function Polt(line:int, area:int) 
		{
			this.line = line;
			this.area = area;
		}
		
		static public const Scale_Dis:Array = [0, 0, 2, 3];
		
		public var line:int;
		public var area:int;
		
		public function dis(p:Polt):Number
		{
			var distense:int = 0;
			
			var area_1:int = Math.abs(this.area);
			var area_2:int = Math.abs(p.area);
			
			if ((p.area * this.area) < 0)
			{
				//表示两卡在不同方
				trace("两卡在不同方");
				distense++;
				distense+= (Polt.Scale_Dis[3] - Polt.Scale_Dis[area_1]);
				distense+= (Polt.Scale_Dis[3] - Polt.Scale_Dis[area_2]);
			}else
			{
				//表示两卡在相同方
				trace("两卡在相同方");
				distense+= (Polt.Scale_Dis[Math.max(area_1,area_2) as int]-Polt.Scale_Dis[Math.min(area_1,area_2)])
			}
			
			if ((p.line * this.line) < 0)
			{
				//表示两卡在不同侧
				distense++;
			}else
			{
				//表示两卡在相同侧
			}
			
			return distense;
		}
		
	}

}