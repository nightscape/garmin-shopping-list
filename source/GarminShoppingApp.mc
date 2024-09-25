import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
using Toybox.Communications;
import ItemSync;

class GarminShoppingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        System.println("GarminShoppingApp initialized");
    }

    function onStart(state as Dictionary?) as Void {
        System.println("GarminShoppingApp started");
    }

    function onStop(state as Dictionary?) as Void {
        System.println("GarminShoppingApp stopped");
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        System.println("Getting initial view");
        var view = new GarminShoppingView();
        return [ view, new Ui.ItemSyncBehaviorDelegate() ];
    }

    //! getSyncDelegate is called by the system when a request is made
    //! to start a bulk data sync via Communications.startSync()
    //! @return The sync delegate to use
    public function getSyncDelegate() as Communications.SyncDelegate? {
        return new ShoppingItemSyncDelegate();
    }
    function onSettingsChanged() as Void {
        var viewAndDelegate = getInitialView() as [Views, InputDelegates];
        WatchUi.switchToView(viewAndDelegate[0], viewAndDelegate[1], WatchUi.SLIDE_UP);
    }
}

function getApp() as GarminShoppingApp {
    return Application.getApp() as GarminShoppingApp;
}
