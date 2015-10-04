package net.fiodordev.quizza.app.controler.startup {
	import net.fiodordev.quizza.app.view.layout.MainContainer;
	import net.fiodordev.quizza.app.view.layout.MainContainerMediator;

	import org.robotlegs.mvcs.StarlingCommand;

	/**
	 * @author fiodor
	 */
	public class SetupViewCommand extends StarlingCommand {
		
		override public function execute() : void {
			mediatorMap.mapView(MainContainer, MainContainerMediator);
		}
	}
}
