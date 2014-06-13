package {
import starling.display.Sprite;

public class Board extends Sprite implements IBoard {
    protected var _game:Game;
    protected var _selectedCell:Cell;
//    protected var _prevCell:Cell;

    public function Board(game:Game) {
        _game = game;
        super();
    }

    public function get selectedCell():Cell {
        return _selectedCell;
    }

    public function cellSelected(cell:Cell):void {
//        if (_selectedCell && _selectedCell == cell) return;
//
//        if (_selectedCell) {
//            _selectedCell.deselect();
//        }
//
//        if (_prevCell) {
//            _prevCell.deselect();
//        }
//
//        _prevCell = _selectedCell;
//
//        if (_selectedCell && _selectedCell.state == Cell.NEW && cell.state == Cell.NEW) {
//            _selectedCell = cell;
//        } else if (_selectedCell == null && cell.state == Cell.NEW) {
//            _selectedCell = cell;
//        } else {
//            _prevCell = cell;
//            _selectedCell = null;
//        }
//
//        if (_prevCell == null) {
//            _prevCell = cell;
//        }
    }
}
}
