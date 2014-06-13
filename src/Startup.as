package {
import flash.display.Sprite;
import flash.events.Event;

import starling.core.Starling;

[SWF(width="400", height="300", frameRate="60", backgroundColor="#ffffff")]
public class Startup extends Sprite {
    private var _starling:Starling;
    public function Startup() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void {
        _starling = new Starling(Game, this.stage);
        _starling.start();
    }
}
}
