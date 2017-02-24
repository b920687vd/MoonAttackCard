package Anime
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class CardPolt extends MovieClip
	{
		
		public function CardPolt()
		{
			// constructor code
			_init();
		}
		
		private function _init():void
		{
			Card_List = new Array();
			polt_dict = new Dictionary();
			curr_area = 0;
			curr_base_line = 0;
		}
		
		public var Card_List:Array;
		
		public var curr_ctrl_Card:int;
		public var curr_base_line:Number;
		
		public var polt_dict:Dictionary;
		
		static public const Scale_Area_1:Number = 403.3;
		static public const Scale_Area_2:Number = 332.3;
		static public const Scale_Area_3:Number = 297.3;
		
		static public const Scale_Line_1:Number = 299.85;
		static public const Scale_Line_2:Number = 441.7;
		static public const Scale_Line_3:Number = 583.55;
		static public const Scale_Line_4:Number = 725.4;
		static public const Scale_Line_5:Number = 867.25;
		
		public function MoveCard(index:int, area:int):void
		{
			Card_List[index - 1];
		}
		
		public function beginControl():void
		{
			for each(var i:Sprite in Card_List)
			{
				i.addEventListener(MouseEvent.MOUSE_DOWN, begin_check_area);
			}
		}
		
		public function linkPolt(c:Sprite, p:Polt)
		{
			polt_dict[c] = p;
		}
		
		public function getCardDis(c1:Sprite, c2:Sprite):int
		{
			if (!polt_dict[c1])
				return -1;
			if (!polt_dict[c2])
				return -1;
			var p1:Polt = polt_dict[c1];
			var p2:Polt = polt_dict[c2]
			return p1.dis(p2);
		}
		
		public var curr_area:int;
		
		function begin_check_area(e:MouseEvent):void
		{
			curr_ctrl_Card = Card_List.indexOf(e.currentTarget);
			if (curr_ctrl_Card == -1)
			{
				trace("错误：所选卡牌不在数组中");
				return;
			}
			
			curr_base_line = Card_List[curr_ctrl_Card].x;
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, begin_check_area);
			Card_List[curr_ctrl_Card].startDrag();
			this.addEventListener(Event.ENTER_FRAME, check_area);
			Card_List[curr_ctrl_Card].addEventListener(MouseEvent.MOUSE_UP, end_check_area);
		}
		
		function check_area(e:Event):void
		{
			if (Card_List[curr_ctrl_Card].y > (Scale_Area_1 - 20) )
			{
				if (curr_area != 0)
				{
					curr_area = 0;
					shape_0.gotoAndPlay(2);
					shape_1.gotoAndStop(1);
					shape_2.gotoAndStop(1);
				}
			}
			else if (Card_List[curr_ctrl_Card].y > (Scale_Area_2 - 20))
			{
				if (curr_area != 1)
				{
					curr_area = 1;
					shape_1.gotoAndPlay(2);
					shape_0.gotoAndStop(1);
					shape_2.gotoAndStop(2);
				}
			}
			else
			{
				if (curr_area != 2)
				{
					curr_area = 2;
					shape_2.gotoAndPlay(2);
					shape_1.gotoAndStop(1);
					shape_0.gotoAndStop(2);
				}
			}
		}
		
		function end_check_area(e:MouseEvent):void
		{
			Card_List[curr_ctrl_Card].addEventListener(MouseEvent.MOUSE_DOWN, begin_check_area);
			Card_List[curr_ctrl_Card].stopDrag();
			this.removeEventListener(Event.ENTER_FRAME, check_area);
			Card_List[curr_ctrl_Card].removeEventListener(MouseEvent.MOUSE_UP, end_check_area);
			shape_0.gotoAndStop(1);
			shape_1.gotoAndStop(1);
			shape_2.gotoAndStop(1);
			if (curr_area == 0)
				Card_List[curr_ctrl_Card].y = Scale_Area_1;
			else if (curr_area == 1)
				Card_List[curr_ctrl_Card].y = Scale_Area_2;
			else if (curr_area == 2)
				Card_List[curr_ctrl_Card].y = Scale_Area_3;
			
			Card_List[curr_ctrl_Card].x = curr_base_line;
		}
	}

}
