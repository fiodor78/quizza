package net.fiodordev.quizza.app.view.layout {
	import net.fiodordev.starling.containers.UMediator;

	/**
	 * @author fiodor
	 */
	public class MainContainerMediator extends UMediator {
		[Inject]
		public var view : MainContainer;

		override public function onRegister() : void {
			logger.info("Registered for view:{0}", this, [view]);
		}
	}
}
