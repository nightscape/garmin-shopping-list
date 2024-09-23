import Toybox.WatchUi;
import Toybox.System;

class GarminShoppingMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) {
        if (item instanceof WatchUi.CheckboxMenuItem) {
            var cbItem = item as WatchUi.CheckboxMenuItem;
            cbItem.setChecked(!cbItem.isChecked());
            WatchUi.requestUpdate();
        } else {
            // Wenn es ein Kategorie-Element ist, machen wir nichts
            System.println("Kategorie ausgewählt: " + item.getLabel());
        }
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onDone() {
        // Hier können Sie die Logik implementieren, die ausgeführt werden soll, 
        // wenn der Benutzer mit der Einkaufsliste fertig ist
        // Zum Beispiel: Speichern des aktuellen Zustands der Einkaufsliste
        saveShoppingListState();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function saveShoppingListState() {
        // Implementieren Sie hier die Logik zum Speichern des Zustands der Einkaufsliste
        System.println("Einkaufslisten-Zustand wird gespeichert...");
        // TODO: Implementieren Sie die tatsächliche Speicherlogik
    }
}
