import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.System;

class GarminShoppingDelegate extends WatchUi.BehaviorDelegate {
    var BASE_URL = "https://app-thatshoppinglist-dot-servemarkenapps.appspot.com/!q4ChRZiH_noxF02UYGJ-Mt76RcjoU2/api/list/DEAAHZVDYNRRMHDKGA";
    private var _items as Array<Item> = [];

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        System.println("onSelect called");
        // Starten Sie den Sync-Vorgang
        Communications.startSync();
        return true;
    }

    function sendHttpPost() as Void {
        var url = BASE_URL + "";
        var params = {};
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        System.println("Sending HTTP request to: " + url);
        Communications.makeWebRequest(url, params, options, method(:onReceive));
    }

    function onReceive(responseCode as Number, data as Dictionary or String or Null) as Void {
        if (responseCode == 200) {
            System.println("HTTP GET request successful");
            if (data instanceof Dictionary) {
                parseItems(data);
                WatchUi.requestUpdate();
            } else {
                System.println("Unexpected data format");
            }
        } else {
            System.println("HTTP GET request failed with code: " + responseCode);
            if (data instanceof String) {
                System.println("Error: " + data);
            } else if (data instanceof Dictionary) {
                System.println("Response data: " + data.toString());
            } else {
                System.println("No response data");
            }
        }
    }

    function parseItems(data as Dictionary) as Void {
        _items = [];
        if (data.hasKey("items") && data["items"] instanceof Array) {
            var itemsArray = data["items"] as Array<Dictionary>;
            for (var i = 0; i < itemsArray.size(); i++) {
                var itemData = itemsArray[i];
                if (itemData.hasKey("cat") && itemData.hasKey("name")) {
                    var cat = itemData["cat"] as String;
                    var name = itemData["name"] as String;
                    var count = itemData.hasKey("count") ? itemData["count"] as String : null;
                    _items.add(new Item(cat, name, count));
                }
            }
        }
        System.println("Parsed " + _items.size() + " items");
    }

    function getItems() as Array<Item> {
        return _items;
    }
}
