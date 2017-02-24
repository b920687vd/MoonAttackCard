package
{
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Console
	{
		public function Console()
		{
		}
		
		public static var messageField:TextField;
		
		/**
		 * func:初始化
		 * 初始化控制台，并返回输出文本框的引用。
		 * <p>
		 * <li>设置messageFiled文本框的基本属性。</li>
		 * </p>
		 * @return 输出文本框
		 */
		public static function inst():TextField
		{
			messageField = new TextField();
			messageField.width = 1024;
			messageField.height = 200;
			messageField.background = true;
			messageField.backgroundColor = 0xDDDDDD;
			messageField.wordWrap = true;
			messageField.doubleClickEnabled = true;
			
			messageField.addEventListener(MouseEvent.DOUBLE_CLICK,fieldShow);
			
			return messageField;
		}
		
		/**
		 * func:打印
		 * 输出调试信息到屏幕
		 */
		public static function print(e:String):void
		{
			messageField.appendText(" --> " + e +"\n");
		}
		
		/**
		 * func:块打印
		 * 输出以“====”隔开的重要的、简短的信息。
		 */
		public static function printBlock(e:String):void
		{
			var blocktext:String = "======= "+e+" =======\n";
			messageField.appendText(blocktext)
			//messageField.setTextFormat(UIFormatConst.CONSOLE_BLOCK,(messageField.text.length-blocktext.length-1),messageField.text.length);
		}
		
		/**
		 * func:调试打印
		 * 输出目标的toString形式。
		 */
		public static function printDebug(e:*):void
		{
			messageField.appendText(" - "+e.toString()+"\n");
		}
		
		public static function printError(e:String):void
		{
			var errortext:String = "!!!! "+e+" !!!!\n";
			messageField.appendText(errortext);
			//messageField.setTextFormat(UIFormatConst.CONSOLE_ERROR,(messageField.text.length-errortext.length-1),messageField.text.length);
		}
		
		public static function get isShow():Boolean
		{
			return (messageField.visible)
		}
		
		public static function set isShow(b:Boolean):void
		{
			messageField.visible = b;
		}
		
		private static function fieldShow(e:MouseEvent):void
		{
			if(messageField.width>200)
				messageField.width = 200;
			else
				messageField.width = 1024;
		}
	}
}