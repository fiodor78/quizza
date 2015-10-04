package net.fiodordev.quizza.app.service {
	import eu.ganymede.common.util.logger.ILogger;

	import net.fiodordev.quizza.app.event.FacebookServiceEvent;

	import com.freshplanet.ane.AirAlert.AirAlert;
	import com.milkmangames.nativeextensions.GVFacebookFriend;
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fiodor
	 */
	public class FacebookService extends Actor {
		private static const FACEBOOK_PERMISSIONS : String = 'public_profile,user_friends,publish_actions';
		[Inject]
		public var logger : ILogger;
		private var _name : String;
		private var _id : String;

		public function FacebookService() {
			GoViral.create();
			GoViral.goViral.logCallback = null;

			GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_IN, onFacebookEvent);
			GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_OUT, onFacebookEvent);
			GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_CANCELED, onFacebookEvent);
			GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_FAILED, onFacebookEvent);
		}

		public function initialize() : void {
			GoViral.goViral.initFacebook('576621835708192');

			logger.debug("Initializing service...", this);

			if (!GoViral.goViral.isFacebookAuthenticated())
				AirAlert.getInstance().showAlert("No Facebook authorisation", "Say hello now or later...", "Login by Facebook", open_authentication, "Go on!", on_authenticated);
		}

		private function onFacebookEvent(event : GVFacebookEvent) : void {
			logger.warning("FB Event: {0}", GoViral.goViral, [event.type]);
			switch(event.type) {
				case GVFacebookEvent.FB_LOGGED_IN:
					get_profile();
					break;
				case GVFacebookEvent.FB_LOGGED_OUT:
				case GVFacebookEvent.FB_LOGIN_FAILED:
					initialize();
					break;
			}
		}

		private function get_profile() : void {
			GoViral.goViral.requestMyFacebookProfile().addRequestListener(on_profile_collected);
		}

		private function on_profile_collected(e : GVFacebookEvent) : void {
			// AirAlert.getInstance().showAlert(e.type, "");

			if (e.type == GVFacebookEvent.FB_REQUEST_RESPONSE) {
				var myProfile : GVFacebookFriend = e.friends[0];

				_name = myProfile.name;
				_id = myProfile.id;

				AirAlert.getInstance().showAlert("Hi " + myProfile.name + "!", myProfile.id, "OK", on_authenticated);

				var event : FacebookServiceEvent = new FacebookServiceEvent(FacebookServiceEvent.FB_IDENTITY_COLLECTED);
				event.uid = _id;
				event.name = _name;
				dispatch(event);

				// var pictureURL = "http://graph.facebook.com/" + myProfile.id + "/picture?type=square";
			}
		}

		private function on_authenticated() : void {
			// "Like us!", advertise
			AirAlert.getInstance().showAlert("Quizza!", "What do you want to do?", "Share on my wall", share, "Facebook logout", logout);
		}

		private function open_authentication() : void {
			GoViral.goViral.authenticateWithFacebook(FACEBOOK_PERMISSIONS);
		}

		private function share() : void {
			GoViral.goViral.showFacebookFeedDialog(_name, _id, "This is a quiz..zzza!", "");
			// .addDialogListener(listener);
			initialize();
		}

		private function advertise() : void {
			GoViral.goViral.presentFacebookPageOrProfile("215322531827565");
			initialize();
		}

		private function logout() : void {
			GoViral.goViral.logoutFacebook();
		}
	}
}
