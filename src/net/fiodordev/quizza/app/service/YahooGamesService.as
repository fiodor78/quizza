package net.fiodordev.quizza.app.service {
	import eu.ganymede.common.util.logger.ILogger;

	import playerio.Client;
	import playerio.DatabaseObject;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;

	import starling.core.Starling;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fiodor
	 */
	public class YahooGamesService extends Actor {
		[Inject]
		public var logger : ILogger;
		private var _client : Client;
		private var _name : String;

		public function YahooGamesService() {
		}

		public function initialize(uid : String, name : String) : void {
			_name = name;
			PlayerIO.connect(Starling.current.nativeStage, "quizza-8vivw1p0chvp7ksilka", "public", uid, "", handleConnect, handleError);
		}

		private function handleConnect(client : Client) : void {
			_client = client;
			logger.info("Connected...{0}", this, [client.connectUserId]);

			_client.bigDB.createObject("PlayerObjects", client.connectUserId, {name:_name, coins:300}, on_object_created, handleError);
		}

		private function on_object_created(o : DatabaseObject) : void {
			// o.save(useOptimisticLock, fullOverwrite, callback, errorHandler)
			logger.info("Object created: {0} in {1}", this, [o.key, o.table]);
		}

		private function handleError(e : PlayerIOError) : void {
			logger.error("Error, {0}, {1}", this, [e.type, e.message]);
		}
	}
}
