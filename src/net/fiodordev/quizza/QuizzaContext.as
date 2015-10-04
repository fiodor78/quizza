package net.fiodordev.quizza {
	import flash.display.LoaderInfo;
	import net.fiodordev.quizza.app.controler.QuickStartCommand;
	import net.fiodordev.quizza.app.controler.startup.SetupServiceCommand;
	import net.fiodordev.quizza.app.controler.startup.SetupViewCommand;
	import net.fiodordev.quizza.app.event.AppCommandEvent;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	import org.robotlegs.mvcs.StarlingContext;

	import flash.events.UncaughtErrorEvent;

	/**
	 * @author fiodor
	 */
	public class QuizzaContext extends StarlingContext {
		
		public function QuizzaContext(contextView : DisplayObjectContainer, loaderInfo: LoaderInfo) {
			
			super(contextView, false);
			
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, on_uncaught_error);

			// commandMap.mapEvent(AppCommandEvent.SETUP, SetupPrerequsitesCommand, AppCommandEvent);
			commandMap.mapEvent(AppCommandEvent.SETUP, SetupServiceCommand, AppCommandEvent);
			// commandMap.mapEvent(AppCommandEvent.SETUP, SetupModelCommand, AppCommandEvent);
			// commandMap.mapEvent(AppCommandEvent.SETUP, SetupControllerCommand, AppCommandEvent);
			commandMap.mapEvent(AppCommandEvent.SETUP, SetupViewCommand, AppCommandEvent, true);

			commandMap.mapEvent(AppCommandEvent.INITIALIZE, QuickStartCommand, AppCommandEvent, true);

			dispatchEvent(new AppCommandEvent(AppCommandEvent.SETUP));
			dispatchEvent(new AppCommandEvent(AppCommandEvent.INITIALIZE));

			contextView.addEventListener(Event.ENTER_FRAME, on_enter_frame);
		}

		private function on_uncaught_error(event : UncaughtErrorEvent) : void {
			trace("Error: {0}", this, [event]);
			event.preventDefault();
		}

		private function on_enter_frame(e : Event) : void {
			// commandMap.execute();
		}
	}
}
