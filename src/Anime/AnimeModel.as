package Anime{
	
	import flash.display.MovieClip;
	import MoonA.Card.CardBase;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public class AnimeModel extends MovieClip {
		
		
		public function AnimeModel() {
			// constructor code
		}
		
		public function preDraw_card(c:CardBase):void
		{
			card_model.text_card_name.text = c.name;
			card_model.text_card_effect.text = c.discribe;
			if(c.pic_bath)
			{
				var pic_loader:Loader = new Loader();
				var pic_request:URLRequest = new URLRequest(c.pic_bath);
				pic_loader.load(pic_request);
				card_model.pic_loader.loader.addChild(pic_loader);
			}
		}
	}
	
}
