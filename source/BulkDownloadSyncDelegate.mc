import Toybox.Lang;
using Toybox.Communications;
using Toybox.Application.Storage;

class BulkDownloadDelegate extends Communications.SyncDelegate
{

    // Initialize
    function initialize() {
        SyncDelegate.initialize();
    }

    // Called by the system to determine if a sync is needed.
    function isSyncNeeded() {
        return true;
    }

    // Called by the system when starting a bulk sync.
    function onStartSync() {
        sendRequest(3);
    }

    // Called by the system when finishing a bulk sync.
    function onStopSync() {
        Communications.cancelAllRequests();
        Communications.notifySyncComplete(null);
    }

    // Initiate a request to download an image of the given color
    function sendRequest(retries as Number) {
        var params = {
        };

        var options = {
        };

        var downloadUrl = "https://app-thatshoppinglist-dot-servemarkenapps.appspot.com/!q4ChRZiH_noxF02UYGJ-Mt76RcjoU2/api/list/DEAAHZVDYNRRMHDKGA";

        // create a request delegate so we can associate parameter with the
        // downloaded image
        var requestDelegate = new BulkDownloadRequestDelegate(self.method(:onRequestComplete), retries);
        requestDelegate.makeWebRequest(downloadUrl, params, options);
    }

    // Handle download completion
    function onRequestComplete(code, data, retries as Number) {
        if (code == 200) {
            // Speichern der JSON-Antwort
            Application.Storage.setValue("jsonResponse", data);
            Communications.notifySyncProgress(100);
            Communications.notifySyncComplete(null);
        } else if (retries > 0) {
            sendRequest(retries - 1);
        } else {
            Communications.notifySyncComplete(Lang.format("Error: $1$\nParameter: $2$", [ code, data ]));
        }
    }
}
