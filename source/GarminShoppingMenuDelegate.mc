import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class GarminShoppingMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        if (item instanceof CheckboxMenuItem) {
            item.setChecked(!item.isChecked());
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
import Toybox.WatchUi;
import Toybox.System;

class GarminShoppingMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var itemId = item.getId();
        if (itemId != null && itemId.find("item_") == 0) {
            // Toggle the checkbox state
            item.setChecked(!item.isChecked());
            WatchUi.requestUpdate();
        }
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
