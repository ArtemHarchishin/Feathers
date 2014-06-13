package {
import feathers.controls.Label;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Cell extends Sprite {
    public static const OLD:int = 0;
    public static const NEW:int = 1;

    public static const CELL_WIDTH:int = 20;
    public static const CELL_HEIGHT:int = 20;
    public static const CELL_COLOR:int = 0x0;

    private var _state:int;
    private var _char:String;
    protected var _label:Label;
    private var _selected:Quad;
    private var _board:IBoard;
    private var _positionOnBoard:String;
    private var _countSelect:int;

    public function Cell(board:IBoard, char:String = "", positionOnBoard:String = "-1") {
        super();
        _positionOnBoard = positionOnBoard;
        _board = board;
        _char = char;
        _countSelect = 0;
        _state = NEW;
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        _selected = Factory.createQuadAndAddTo(CELL_WIDTH + 1, CELL_HEIGHT + 1, 0xff0000, this);
        _selected.visible = false;
        Factory.createQuadAndAddTo(CELL_WIDTH, CELL_HEIGHT, CELL_COLOR, this);
        _label = Factory.createLabelAndAddTo(_char, this);
        if (_char != "") {
            Helper.centeredBy(_label, this);
        }
        addEventListener(TouchEvent.TOUCH, touchHandler);
    }

    private function touchHandler(e:TouchEvent):void {
        var touch:Touch = e.getTouch(stage);
        if (touch == null) {
            if (e.currentTarget is Cell) {
                var cell:Cell = (e.currentTarget as Cell);
                Log.print("[ERROR] touch null ", cell.char, cell.positionOnBoard);
            }
            return;
        }
        if (touch.phase == TouchPhase.ENDED) {
            _selected.visible = true;

            if (_board) {
                _board.cellSelected(this);
            }

            _countSelect++;
            Log.print(_char);
        }
    }

    public function set char(char:String):void {
        if (char != null && char != _char) {
            _char = char;
            _label.text = _char;
            if (_char != "") {
                _label.validate();
                Helper.centeredBy(_label, this);
            }
        }
    }

    public function deselect():void {
        _selected.visible = false;
    }

    public function get char():String {
        return _char;
    }

    public function get positionOnBoard():String {
        return _positionOnBoard;
    }

    public function get countSelect():int {
        return _countSelect;
    }

    public function canAddToWord():Boolean {
        return _countSelect < 1;
    }

    public function setInCanSelect():void {
        _countSelect = 0;
    }

    public function set state(state:int):void {
        if (_state != state) {
            _state = state;
            update();
        }
    }

    private function update():void {

    }

    public function get state():int {
        return _state;
    }

    public function inverseSelect():void {
        _selected.visible = !_selected.visible;
    }

    public function isEmpty():Boolean {
        return _char == "";
    }
}
}
