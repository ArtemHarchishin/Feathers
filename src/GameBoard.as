package {
import feathers.controls.LayoutGroup;

import starling.events.Event;

public class GameBoard extends Board {
    private var _initWord:String;

    public function GameBoard(initWord:String, game:Game) {
        super(game);
        _initWord = initWord;
        _cells = {};
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public static const CENTER_ROW_INDEX:int = 2;

    public static const BETWEEN_V:int = 1;
    public static const BETWEEN_H:int = 1;

    public static const NUM_COLUMNS:int = 5;
    public static const NUM_ROWS:int = 5;

    private var _cells:Object;

    private function init(e:Event):void {
        var columns:LayoutGroup = Factory.createLayoutGroup();
        columns.layout = Factory.createVerticalLayout(BETWEEN_V);

        var cells:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>(NUM_COLUMNS, true);
        for (var i:int = 0; i < NUM_COLUMNS; i++) {
            var column:LayoutGroup = Factory.createLayoutGroup();
            column.layout = Factory.createHorizontalLayout(BETWEEN_H);

            cells[i] = new Vector.<Cell>(NUM_ROWS, true);
            for (var j:int = 0; j < NUM_ROWS; j++) {
                _cells[i.toString() + j.toString()] = cells[i][j] = Factory.createCellAndAddTo(column, this, "", i + "" + j);
            }
            columns.addChild(column);
            column.validate();
        }
        addChild(columns);
        columns.validate();

        initBaseWord(_initWord);
    }

    public function initBaseWord(initWord:String):void {
        for (var i:int = 0; i < NUM_COLUMNS; i++) {
            var cell:Cell = _cells[CENTER_ROW_INDEX.toString() + i.toString()];
            cell.char = initWord.charAt(i);
            cell.state = Cell.OLD;
        }
    }

    public function putCharInSelectedCell(cell:Cell):void {
//        tryClearPrevCell();

        if (_selectedCell && _selectedCell.state == Cell.NEW) {
            _selectedCell.char = cell.char;
            _selectedCell.deselect();
        }
    }

    override public function cellSelected(cell:Cell):void {
        switch (_game.state) {
            case Game.ADD_CHAR:
                if (_selectedCell && _selectedCell == cell) return;

                if (cell.state == Cell.OLD) {
                    cell.deselect();
                    _selectedCell = null;
                    return;
                }

                if (_selectedCell) {
                    _selectedCell.deselect();
                }

                _selectedCell = cell;

                break;
            case Game.ADD_WORD:
                if (cell.canAddToWord() && !cell.isEmpty()) {
                    _game.collectWord(cell.char);
                } else if (cell.isEmpty()){
                    cell.deselect();
                }
                break;
        }

        Game.GLOBAL_DISPATCHER.dispatchEvent(new Event(Game.BOARD_READY, false, this));
    }

    public function setToCanSelectChar():void {
        for (var index:String in _cells) {
            var cell:Cell = _cells[index];
            if (cell.char != "") {
                cell.setInCanSelect();
                cell.deselect();
            }
        }
    }

//    public function tryClearPrevCell():Boolean {
//        if (/*_prevCell && _prevCell.char != "" && */_selectedCell && _selectedCell.state == Cell.NEW) {
//            _prevCell.char = "";
//            _prevCell = null;
//            return true;
//        }
//        return false;
//    }

    public function setToCanSelectWord():void {
        if (_selectedCell) {
            _selectedCell.state = Cell.OLD;
            _selectedCell.deselect();
            _selectedCell.setInCanSelect();
            _selectedCell = null;
        }
    }
}
}
