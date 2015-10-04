package net.fiodordev.quizza {
	import starling.display.Sprite;

	import org.robotlegs.mvcs.StarlingContext;

	import flash.display.LoaderInfo;

	/**
	 * @author fiodor
	 */
	public class QuizzaApplication extends Sprite {
		private var _context : StarlingContext;

		public function QuizzaApplication() {
			super();
		}

		public function initialize_context(loaderInfo : LoaderInfo) : void {
			trace(this);

			_context = new QuizzaContext(this, loaderInfo);
		}
	}
}
