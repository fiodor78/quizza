package net.fiodordev.quizza.app.event {
	import flash.events.Event;

	/**
	 * @author fiodor
	 */
	public class FacebookServiceEvent extends Event {
		public static const FB_IDENTITY_COLLECTED : String = "FB_IDENTITY_COLLECTED";
		public var uid : String;
		public var name : String;

		public function FacebookServiceEvent(type : String) {
			super(type);
		}
	}
}
