import Toybox.WatchUi;
import Toybox.System;

class GarminShoppingMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) {
        var cbItem = item as WatchUi.CheckboxMenuItem;
        cbItem.setChecked(!cbItem.isChecked());
        WatchUi.requestUpdate();
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onDone() {
        // Here you can implement any logic needed when the user is done with the shopping list
        // For now, we'll just go back to the previous view
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
