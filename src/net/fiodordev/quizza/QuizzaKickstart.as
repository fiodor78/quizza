package net.fiodordev.quizza {
	import starling.core.Starling;
	import starling.events.Event;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;

	/**
	 * @author fiodor
	 */
	[SWF(frameRate="60", backgroundColor="#ff4121")]
	public class QuizzaKickstart extends Sprite {
		private var _starling : Starling;

		public function QuizzaKickstart() {
			addEventListener(flash.events.Event.ADDED_TO_STAGE, initialize_starling);
		}

		private function initialize_starling(e : flash.events.Event) : void {
			trace("I have a question!");
			trace("Screen is:" + Capabilities.screenResolutionX + ":" + Capabilities.screenResolutionY);

			removeEventListener(flash.events.Event.ADDED_TO_STAGE, initialize_starling);

			_starling = new Starling(QuizzaApplication, stage);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, run_application);
			_starling.showStats = true;

			trace("Starling assets scale:" + _starling.contentScaleFactor);
		}

		private function run_application(e : * = null) : void {
			trace("Starling started...");
			_starling.start();
			(_starling.root as QuizzaApplication).initialize_context(loaderInfo);
		}
	}
}
