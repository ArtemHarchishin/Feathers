package {
public class DictionaryTreeVertex {
    public function toJSON(k):* {
        return {"_str": _str, "_word": _word, "_next": _next};
    }

    public var _str:String;
    public var _word:String;
    public var _next:Object;

    public function DictionaryTreeVertex(str:String = "") {
        _str = str;
        _word = null;
        _next = {};
    }

    public function setNext(w:String):DictionaryTreeVertex {
        if (_next[w] == null) {
            _next[w] = Factory.createDictionaryTreeVertex();
        }
        setStr(w);
        return _next[w];
    }

    public function setStr(char:String):void {
        if (_str.indexOf(char) == -1) {
            _str = _str.concat(char);
        }
    }

    public function set word(value:String):void {
        _word = value;
    }
}
}
