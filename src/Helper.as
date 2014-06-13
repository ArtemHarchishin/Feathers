package {

import feathers.core.FeathersControl;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Stage;

public class Helper {
    public static function centeredBy(obj:DisplayObject, by:DisplayObjectContainer):void {
        obj.x = by.width - obj.width >> 1;
        obj.y = by.height - obj.height >> 1;
    }

    public static function centeredByStage(obj:DisplayObject, by:Stage):void {
        obj.x = by.stageWidth - obj.width >> 1;
        obj.y = by.stageHeight - obj.height >> 1;
    }

    public static function setControlPosition(control:FeathersControl, aX:Number, aY:Number):void {
        control.x = aX;
        control.y = aY;
    }
}
}
