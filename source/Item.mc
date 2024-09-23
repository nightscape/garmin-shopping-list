import Toybox.Lang;

class Item {
    private var _cat as String;
    private var _name as String;
    private var _count as String?;

    function initialize(cat as String, name as String, count as String?) {
        _cat = cat;
        _name = name;
        _count = count;
    }

    function getCat() as String {
        return _cat;
    }

    function getName() as String {
        return _name;
    }

    function getCount() as String? {
        return _count;
    }
}
