package net.fiodordev.starling.containers {
	import eu.ganymede.common.util.logger.ILogger;

	import starling.events.Event;

	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.StarlingMediator;

	/**
	 * @author fiodor
	 */
	public class UMediator extends StarlingMediator {
		[Inject]
		public var logger : ILogger;
		[Inject]
		public var injector : IInjector;
		private var _view : USprite;

		public function UMediator() {
		}

		override public function preRegister() : void {
			trace("VIeW:" + getViewComponent());

			var view : USprite = this["view"] as USprite;
			injector.injectInto(view);

			view.create();

			super.preRegister();
		}

		override public function onRegister() : void {
			super.onRemove();
		}

		override public function preRemove() : void {
			(this["view"] as USprite).destroy();
		}

		override protected function onInitialize(e : Event) : void {
			super.onInitialize(e);
		}
	}
}
