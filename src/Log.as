package {
import feathers.controls.Label;

public class Log {
    static private var _instance:Log;
    static private var _label:Label;
    private static var _count:int;
    private static const _available:Boolean = false;

    public function Log(label:Label) {
        if (_instance) {
            throw new Error("It's singleton !!!");
        }
        _instance = this;
        _label = label;
        _count = 0;
    }

    public static function print(...args:Array):void {
        if (!_available) return;

        _count++;
        if (_count >= 3) {
            var split:Array = _label.text.split("\n");
            _label.text = " trace -> " + args.join(" // ") + "\n" + split[0] + "\n" + split[1] + "\n" + split[2];
            _count = 1;
        } else {
            _label.text = " trace -> " + args.join(" // ") + "\n" + _label.text;
        }
    }
}
}
