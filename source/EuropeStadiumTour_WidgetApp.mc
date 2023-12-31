import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class EuropeStadiumTour_WidgetApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new EuropeStadiumTour_WidgetView() ] as Array<Views or InputDelegates>;
    }

    function onSettingsChanged() as Void {
        settingsChanged = true;
        WatchUi.requestUpdate();
    }
}