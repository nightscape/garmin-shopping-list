import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;

class GarminShoppingView extends WatchUi.View {
    hidden var _text;

    function initialize() {
        View.initialize();
        _text = "Starting";
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() as Void {
    }
    function setText(texts) as Void {
        _text = texts.toString();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        //var settings = Sys.getDeviceSettings();

        var wifiText = "Shopping list is " ;//+ (settings[:wifiEnabled] ? "enabled" : "disabled");
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2 - 30, Graphics.FONT_MEDIUM, wifiText, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide() as Void {
    }
}
