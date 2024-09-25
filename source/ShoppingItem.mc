import Toybox.Lang;

class Item {
    private var _cat as String;
    private var _name as String;
    private var _count as String?;
    private var _done as Boolean;

    function initialize(cat as String, name as String, count as String?, done as Boolean) {
        _cat = cat;
        _name = name;
        _count = count;
        _done = done;
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
    function isDone() as Boolean {
        return _done;
    }
    function setDone(done as Boolean) as Void {
        _done = done;
    }
}
