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
