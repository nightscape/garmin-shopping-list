import Toybox.Lang;
using Toybox.Communications;
import ItemSync.Model;
using Toybox.Application.Properties;

class ShoppingItemSyncDelegate extends ItemSyncDelegate
{
    var baseUrl = "https://app-thatshoppinglist-dot-servemarkenapps.appspot.com/!q4ChRZiH_noxF02UYGJ-Mt76RcjoU2/api";
    var listId as String = Properties.getValue("ListId");
    function initialize() {
        ItemSyncDelegate.initialize();
    }

    // Initiate a request to download an image of the given color
    function sendRequest(retries as Number) as Void {
        var params = {
        };

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :context => retries
        };

        var downloadUrl = self.baseUrl + "/list/" + self.listId;
        Communications.makeWebRequest(downloadUrl, params, options, method(:onRequestComplete));
    }

    function onRequestComplete(responseCode as Number, data as Dictionary?, context as Object) as Void {
        self.onSyncComplete(context as Number, {"code" => responseCode, "data" => data});
    }
    function isSyncSuccessfull(syncResult as Object) as Boolean {
        return (syncResult as Dictionary)["code"] == 200;
    }
}
