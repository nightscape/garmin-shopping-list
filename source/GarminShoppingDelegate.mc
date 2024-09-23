import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.System;

class GarminShoppingDelegate extends WatchUi.BehaviorDelegate {
    var BASE_URL = "https://app-thatshoppinglist-dot-servemarkenapps.appspot.com/!q4ChRZiH_noxF02UYGJ-Mt76RcjoU2/api/list/DEAAHZVDYNRRMHDKGA";

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        System.println("onMenu called");
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
                Storage.setValue("jsonResponse", data);
                WatchUi.switchToView(new GarminShoppingView(), new GarminShoppingDelegate(), WatchUi.SLIDE_IMMEDIATE);
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
}
