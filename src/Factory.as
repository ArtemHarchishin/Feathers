package {
import feathers.controls.ButtonGroup;
import feathers.controls.GroupedList;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.display.DisplayObjectContainer;
import starling.display.Quad;

public class Factory {

    public static function createButtonGroupAndAddTo(btns:ListCollection, parent:DisplayObjectContainer = null):ButtonGroup {
        var bg:ButtonGroup = new ButtonGroup();
        bg.dataProvider = btns;
        if (parent) {
            parent.addChild(bg);
            bg.validate();
        }
        return bg;
    }

    public static function createLabelAndAddTo(text:String, parent:DisplayObjectContainer = null):Label {
        var label:Label = new Label();
        label.text = text;
        if (parent != null) {
            parent.addChild(label);
            label.validate();
        }
        return label;
    }

    public static function createQuadAndAddTo(w:Number, h:Number, color:uint, parent:DisplayObjectContainer = null):Quad {
        var quad:Quad = new Quad(w, h, color);
        if (parent != null) {
            parent.addChild(quad);
        }
        return quad;
    }

    public static function createVerticalLayout(gap:int):VerticalLayout {
        var layoutV:VerticalLayout = new VerticalLayout();
        layoutV.gap = gap;
        return layoutV;
    }

    public static function createHorizontalLayout(gap:int):HorizontalLayout {
        var layoutH:HorizontalLayout = new HorizontalLayout();
        layoutH.gap = gap;
        return layoutH;
    }

    public static function createLayoutGroup(parent:DisplayObjectContainer = null):LayoutGroup {
        var group:LayoutGroup = new LayoutGroup();
        if (parent != null) {
            parent.addChild(group);
            group.validate();
        }
        return  group;
    }

    public static function createCellAndAddTo(parent:DisplayObjectContainer, board:IBoard, char:String = "", positionOnBoard:String = "-1"):Cell {
        var cell:Cell = new Cell(board, char, positionOnBoard);
        if (parent != null) {
            parent.addChild(cell);
        }
        return cell;
    }

    public static function createDictionaryTreeVertex(char:String = ""):DictionaryTreeVertex {
        return  new DictionaryTreeVertex(char);
    }

    public static function createGameBoard(word:String, game:Game):GameBoard {
        var gameBoard:GameBoard = new GameBoard("БАЛДА", game);
        game.addChild(gameBoard);
        return gameBoard;
    }

    public static function createAlphabet(game:Game):Alphabet {
        var alphabet:Alphabet = new Alphabet(game);
        game.addChild(alphabet);
        return alphabet;
    }

    public static function createCollectedWordsControl(parent:DisplayObjectContainer, game:Game):CollectedWordsControl {
        var control:CollectedWordsControl = new CollectedWordsControl(game);
        if (parent) {
            parent.addChild(control);
        }
        return control;
    }

    public static function createGroupedList(parent:DisplayObjectContainer):GroupedList {
        var groupedList:GroupedList = new GroupedList();
        if (parent) {
            parent.addChild(groupedList);
        }
        return groupedList;
    }

    public static function createList(parent:DisplayObjectContainer):List {
        var list:List = new List();
        if (parent) {
            parent.addChild(list);
        }
        return list;
    }
}
}
