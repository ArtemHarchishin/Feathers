package {
import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;

import starling.events.Event;

public class Alphabet extends Board {

    public function Alphabet(game:Game) {
        super(game);
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private var _buttonGroup:ButtonGroup;

    private function init(e:Event):void {
        var char:String;
        var alphabet:Array = [
            ["Й", "Ц", "У", "К", "Е", "Н", "Г", "Ш", "Щ", "З", "Х", "Ъ"],
            ["Ф", "Ы", "В", "А", "П", "Р", "О", "Л", "Д", "Ж", "Э"],
            ["Я", "Ч", "С", "М", "И", "Т", "Ь", "Б", "Ю", "Ё"]
        ];

        var i:int = 0;
        var columns:LayoutGroup = Factory.createLayoutGroup();
        columns.layout = Factory.createVerticalLayout(GameBoard.BETWEEN_V);
        for each (var ar:Array in alphabet) {
            var column:LayoutGroup = Factory.createLayoutGroup();
            var layout:HorizontalLayout = Factory.createHorizontalLayout(GameBoard.BETWEEN_H);
            layout.paddingLeft = i * 10;
            column.layout = layout;
            for each (char in ar) {
                Factory.createCellAndAddTo(column, this, char);
            }
            columns.addChild(column);
            column.validate();
            i++;
        }

        addChild(columns);
        columns.validate();

        _buttonGroup = Factory.createButtonGroupAndAddTo(new ListCollection(
                [
                    {label: "Done", triggered: btnDoneHandler},
                ]
        ), this);
        _buttonGroup.x = _game.stage.stageWidth - _buttonGroup.width - 40;
        _buttonGroup.visible = false;
    }

    private function btnDoneHandler(e:Event):void {
        _game.state = Game.ADD_WORD;
    }

    override public function cellSelected(cell:Cell):void {
        if (_selectedCell && _selectedCell == cell) return;
        if (_selectedCell) {
            _selectedCell.deselect();
        }

        _selectedCell = cell;

        Game.GLOBAL_DISPATCHER..dispatchEvent(new Event(Game.BOARD_READY, false, this));
    }


    public function disableSelectedCell():void {
        if (_selectedCell) {
            _selectedCell.deselect();
            _selectedCell = null;
        }
    }

    public function set btnDoneVisible(value:Boolean):void {
        _buttonGroup.visible = value;
    }

}
}
