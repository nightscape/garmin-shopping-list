import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;

class GarminShoppingView extends WatchUi.View {
    hidden var _menu as WatchUi.CheckboxMenu?;

    function initialize() {
        View.initialize();
        _menu = null;
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() as Void {
        _menu = new WatchUi.CheckboxMenu({:title=>"Shopping List"});
        var jsonResponse = Storage.getValue("jsonResponse");
        if (jsonResponse != null) {
            var data = jsonResponse as Dictionary;
            if (data instanceof Dictionary && data.hasKey("items")) {
                var items = data["items"] as Array<Dictionary>;
                items.sort(method(:compareItems));
                var currentCategory = "";
                for (var i = 0; i < items.size(); i++) {
                    var item = items[i];
                    if (item["cat"] != currentCategory) {
                        currentCategory = item["cat"];
                        _menu.addItem(new WatchUi.MenuItem(currentCategory, null, "cat_" + i, {}));
                    }
                    _menu.addItem(new WatchUi.CheckboxMenuItem(item["name"], null, "item_" + i, false, {}));
                }
            } else {
                _menu.addItem(new WatchUi.CheckboxMenuItem("Invalid data format", null, null, false, {}));
            }
        } else {
            _menu.addItem(new WatchUi.CheckboxMenuItem("No data available", null, null, false, {}));
        }
        WatchUi.pushView(_menu, new GarminShoppingMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
    }

    function onHide() as Void {
    }

    static function compareItems(a as Dictionary, b as Dictionary) as Number {
        return a["cat"].compare(b["cat"]);
    }
}
