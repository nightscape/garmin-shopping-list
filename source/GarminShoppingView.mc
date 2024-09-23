import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;

class GarminShoppingView extends WatchUi.View {
    hidden var _text;

    function initialize() {
        View.initialize();
        _text = "Starting";
        Application.Storage.setValue("jsonResponse", "[]");
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() as Void {
        // Laden der JSON-Antwort beim Anzeigen der View
        var jsonResponse = Storage.getValue("jsonResponse");
        if (jsonResponse != null) {
            var data = JsonParser.parse(jsonResponse);
            if (data instanceof Dictionary && data.hasKey("items")) {
                var items = data["items"] as Array<Dictionary>;
                _text = "Items: " + items.size();
            } else {
                _text = "Invalid data format";
            }
        } else {
            _text = "No data available";
        }
        WatchUi.requestUpdate();
    }

    function setText(texts) as Void {
        _text = texts.toString();
        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);

        // Anzeigen der Anzahl der Items oder einer Statusnachricht
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, _text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function onHide() as Void {
    }
}
