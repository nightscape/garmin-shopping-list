import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Application.Properties;
import ItemSync;

class GarminShoppingView extends Ui.ItemView {
  function initialize() {
    var categoryOrder = Properties.getValue("CategoryOrder");
    Ui.ItemView.initialize("Shopping List", new CategoryComparator(categoryOrder));
  }
  function getItems(data as Object) as Array<Dictionary> {
    return (data as Dictionary)["data"]["items"];
  }
  function getItemName(item as Dictionary) as String {
    return item["name"];
  }
  function getItemCategory(item as Dictionary) as String {
    return item["cat"];
  }
}

class CategoryComparator {
    var mCategoryOrder as String;
    function initialize(categoryOrder as String) {
        mCategoryOrder = categoryOrder;
    }
    function categoryOrderFor(a as Object) as Number {
        var cat = (a as Dictionary)["cat"];
        var index = mCategoryOrder.find(cat);
        if (index == null) {
            return mCategoryOrder.length();
        }
        return index;
    }
  function compare(a as Object, b as Object) as Number {
    return categoryOrderFor(a).compareTo(categoryOrderFor(b));
  }
}
