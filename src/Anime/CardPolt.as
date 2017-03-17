package Anime
{
	
	import Card.CardBase;
	import Card.Character;
	import ExEvent.PlayerEvent;
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
			char_dict = new Dictionary();
			curr_area = 0;
			curr_base_line = 0;
			ctrl_able = false;
		}
		
		public var Card_List:Array;
		
		public var Hand_List:Vector.<CardBase>;
		
		public var curr_ctrl_Card:int;
		public var curr_base_line:Number;
		
		public var ctrl_able:Boolean;
		
		public var polt_dict:Dictionary;
		public var char_dict:Dictionary;
		
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
		
		public function beginMoveControl():void
		{
			for each(var i:Sprite in Card_List)
			{
				i.addEventListener(MouseEvent.MOUSE_DOWN, _BeginCheckArea);
			}
		}
		
		public function StopMoveControl():void
		{
			for each(var i:Sprite in Card_List)
			{
				try{
					i.removeEventListener(MouseEvent.MOUSE_DOWN, _BeginCheckArea);
				}
				catch (e:Error)
				{
					//
				}
			}
		}
		
		/**
		 * 为卡牌模型绑定槽位对象
		 * @param	c
		 * @param	p
		 */
		public function linkPolt(c:Sprite, p:Polt)
		{
			polt_dict[c] = p;
		}
		
		public function linkData(c:Sprite, d:Character)
		{
			char_dict[c] = d;
		}
		
		public function getCardDis(c1:Sprite, c2:Sprite):int
		{
			if (!polt_dict[c1])
				return -1;
			if (!polt_dict[c2])
				return -1;
			
			var p1:Polt = polt_dict[c1];
			var p2:Polt = polt_dict[c2];
			return p1.dis(p2);
		}
		
		public var curr_area:int;
		
		private function _BeginCheckArea(e:MouseEvent):void
		{
			curr_ctrl_Card = Card_List.indexOf(e.currentTarget);
			if (curr_ctrl_Card == -1)
			{
				trace("错误：所选卡牌不在数组中");
				return;
			}
			
			curr_base_line = Card_List[curr_ctrl_Card].x;
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _BeginCheckArea);
			Card_List[curr_ctrl_Card].startDrag();
			this.addEventListener(Event.ENTER_FRAME, _CheckArea);
			Card_List[curr_ctrl_Card].addEventListener(MouseEvent.MOUSE_UP, _EndCheckArea);
		}
		
		private function _CheckArea(e:Event):void
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
		
		private function _EndCheckArea(e:MouseEvent):void
		{
			Card_List[curr_ctrl_Card].addEventListener(MouseEvent.MOUSE_DOWN, _BeginCheckArea);
			Card_List[curr_ctrl_Card].stopDrag();
			this.removeEventListener(Event.ENTER_FRAME, _CheckArea);
			Card_List[curr_ctrl_Card].removeEventListener(MouseEvent.MOUSE_UP, _EndCheckArea);
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
		
		/**
		 * 开始回合控制
		 */
		public function StartControl():void
		{
			beginMoveControl();
		}
		
		/**
		 * 停止回合控制
		 */
		public function StopControl():void
		{
			StopMoveControl();
		}
		
		/**
		 * 处理点击卡片显示细节的效果
		 * @param	e
		 */
		private function _ClickCardShowDetail(e:MouseEvent):void
		{
			ShowCardDetail(char_dict(e.target));
		}
		
		/**
		 * 处理点击手牌显示细节的效果
		 * @param	e
		 */
		private function _ClickHandShowDetail(e:MouseEvent):void
		{
			
		}
		
		/**
		 * 显示卡片细节
		 * @param	c
		 */
		public function ShowCardDetail(c:CardBase):void
		{
			
		}
		
		/**
		 * 开始选择对象
		 */
		public function StartChooseAim():void
		{
			for each(var card:Sprite in this.Card_List)
			{
				card.addEventListener(MouseEvent.CLICK, _ChooseAim);
			}
		}
		
		/**
		 * 停止选择对象
		 */
		public function StopChooseAim():void
		{
			for each(var card:Sprite in this.Card_List)
			{
				try{
					card.removeEventListener(MouseEvent.CLICK, _ChooseAim);
				}
				catch (e:Error)
				{
					//
				}
			}
		}
		
		/**
		 * 处理选中对象的结果
		 * @param	e
		 */
		private function _ChooseAim(e:MouseEvent):void
		{
			var event_choose_aim:PlayerEvent = new PlayerEvent(PlayerEvent.CHOOSE_AIM_OVER, char_dict[e.target]);
			GameMgr.One.event_cube.dispatchEvent(event_choose_aim);
		}
		
		/**
		 * 开始选择手牌
		 */
		public function StartChooseHand():void
		{
			
		}
		
		/**
		 * 停止选择手牌
		 */
		public function StopChooseHand():void
		{
			
		}
	}

}
