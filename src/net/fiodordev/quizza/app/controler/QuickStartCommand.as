package net.fiodordev.quizza.app.controler {
	import net.fiodordev.quizza.app.controler.startup.HandleFBIdentityCommand;
	import eu.ganymede.common.util.logger.ILogger;

	import net.fiodordev.quizza.app.event.FacebookServiceEvent;
	import net.fiodordev.quizza.app.service.FacebookService;
	import net.fiodordev.quizza.app.service.YahooGamesService;

	import org.robotlegs.mvcs.StarlingCommand;

	/**
	 * @author fiodor
	 */
	public class QuickStartCommand extends StarlingCommand {
		[Inject]
		public var logger : ILogger;
		[Inject]
		public var facebook : FacebookService;
		[Inject]
		public var yahoo : YahooGamesService;

		override public function execute() : void {
			commandMap.mapEvent(FacebookServiceEvent.FB_IDENTITY_COLLECTED, HandleFBIdentityCommand, FacebookServiceEvent);

			facebook.initialize();
		}
	}
}
