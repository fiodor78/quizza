package net.fiodordev.quizza.app.event {
	import flash.events.Event;

	/**
	 * @author fiodor
	 */
	public class AppCommandEvent extends Event {
		
		public static const SETUP : String = "SETUP";
		public static const INITIALIZE : String = "INITIALIZE";

		public function AppCommandEvent(type : String) {
			super(type);
		}
	}
}
