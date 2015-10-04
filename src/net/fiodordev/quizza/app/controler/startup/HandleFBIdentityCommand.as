package net.fiodordev.quizza.app.controler.startup {
	import eu.ganymede.common.util.logger.ILogger;

	import net.fiodordev.quizza.app.event.FacebookServiceEvent;
	import net.fiodordev.quizza.app.service.YahooGamesService;

	import org.robotlegs.mvcs.StarlingCommand;

	/**
	 * @author fiodor
	 */
	public class HandleFBIdentityCommand extends StarlingCommand {
		[Inject]
		public var event : FacebookServiceEvent;
		[Inject]
		public var service : YahooGamesService;
		[Inject]
		public var logger : ILogger;

		override public function execute() : void {
			logger.info("Entering yahoo with id: {0}", this, [event.uid]);
			service.initialize(event.uid, event.name);
		}
	}
}
