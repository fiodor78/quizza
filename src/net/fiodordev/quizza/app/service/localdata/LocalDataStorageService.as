package net.fiodordev.quizza.app.service.localdata {
	import eu.ganymede.common.util.logger.ILogger;

	import com.adobe.crypto.MD5;

	import org.robotlegs.mvcs.Actor;

	import flash.crypto.generateRandomBytes;
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;

	/**
	 * @author fiodor
	 */
	public class LocalDataStorageService extends Actor {
		private static const TUTORIAL_STEP : String = "TUTORIAL_STEP";
		private static const RUN_COUNT : String = "RUN_COUNT";
		private static const LAST_PLAYER_ID : String = "LAST_PLAYER_ID";
		private static const UNIQUE_ID : String = "UNIQUE_ID";
		[Inject]
		public var logger : ILogger;
		private var _runs : uint = 0;
		private var _unique_id : String;

		public function update_run_count() : void {
			var bytes : ByteArray = EncryptedLocalStore.getItem(RUN_COUNT);
			var runs : uint;
			runs = bytes ? bytes.readUnsignedInt() : 0;

			_runs = runs++;

			logger.info("Updated runs count {0} -> {1}", this, [_runs, runs]);

			bytes = new ByteArray();
			bytes.writeUnsignedInt(runs);
			EncryptedLocalStore.setItem(RUN_COUNT, bytes);
		}

		public function get unique_id() : String {
			if (!_unique_id) {
				var bytes : ByteArray = EncryptedLocalStore.getItem(UNIQUE_ID);
				bytes = bytes ? bytes : generateRandomBytes(64);
				EncryptedLocalStore.setItem(UNIQUE_ID, bytes);

				_unique_id = MD5.hashBytes(bytes);
			}

			return _unique_id;
		}

		public function get run_count() : uint {
			return _runs;
		}

		public function set last_player_id(value : uint) : void {
			var bytes : ByteArray = new ByteArray();
			bytes.writeUnsignedInt(value);
			EncryptedLocalStore.setItem(LAST_PLAYER_ID, bytes);
		}

		public function get last_player_id() : uint {
			var bytes : ByteArray = EncryptedLocalStore.getItem(LAST_PLAYER_ID);
			return bytes ? bytes.readUnsignedInt() : 0;
		}

		public function set tutorial_step(value : uint) : void {
			var bytes : ByteArray = new ByteArray();
			bytes.writeUnsignedInt(value);
			EncryptedLocalStore.setItem(TUTORIAL_STEP, bytes);
		}

		public function get tutorial_step() : uint {
			var bytes : ByteArray = EncryptedLocalStore.getItem(TUTORIAL_STEP);
			return bytes ? bytes.readUnsignedInt() : 0;
		}

		public static function get runs() : uint {
			var bytes : ByteArray = EncryptedLocalStore.getItem(RUN_COUNT);
			if (bytes)
				return bytes.readUnsignedInt();
			else
				return 0;
		}
	}
}