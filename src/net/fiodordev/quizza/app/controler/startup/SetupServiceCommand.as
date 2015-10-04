package net.fiodordev.quizza.app.controler.startup {
	import com.freshplanet.ane.AirCrashlytics.AirCrashlytics;
	import eu.ganymede.common.util.logger.ILogger;
	import eu.ganymede.common.util.logger.Logger;
	import eu.ganymede.common.util.logger.TraceChannel;

	import net.fiodordev.quizza.app.service.FacebookService;
	import net.fiodordev.quizza.app.service.YahooGamesService;
	import net.fiodordev.quizza.app.service.localdata.LocalDataStorageService;

	import com.freshplanet.ane.AirAlert.AirAlert;

	import org.robotlegs.mvcs.StarlingCommand;

	/**
	 * @author fiodor
	 */
	public class SetupServiceCommand extends StarlingCommand {
		private var _logger : Logger;

		override public function execute() : void {
			
			AirAlert.getInstance();

			// Setup logger
			var logger : Logger = new Logger;
			logger.add_channel(new TraceChannel);
			_logger = logger;
			injector.mapValue(ILogger, logger);
			logger.current_level = Logger.DEBUG;

			var local : LocalDataStorageService = new LocalDataStorageService();
			injector.injectInto(local);
			injector.mapValue(LocalDataStorageService, local);
			local.update_run_count();

			AirCrashlytics.start();
			trace("Crashlytics:"+AirCrashlytics.apiKey);

			injector.mapSingleton(FacebookService);
			injector.mapSingleton(YahooGamesService);

			logger.debug("Services initialized...", this);
		}
	}
}
