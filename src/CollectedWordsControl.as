package {
import feathers.controls.ButtonGroup;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.data.ListCollection;

import starling.display.Sprite;
import starling.events.Event;

public class CollectedWordsControl extends Sprite {
    private var _game:Game;
    private var _collectedWords:LayoutGroup;
    private var _currentWord:Label;
    private var _canDone:Boolean;

    public function CollectedWordsControl(game:Game) {
        super();
        _game = game;
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private var _buttonGroup:ButtonGroup;

    private function init(e:Event):void {
        _collectedWords = Factory.createLayoutGroup(this);
        _collectedWords.layout = Factory.createVerticalLayout(0);
        _collectedWords.x = 5;
        _collectedWords.y = 50;

        _currentWord = Factory.createLabelAndAddTo("", _collectedWords);

        _buttonGroup = Factory.createButtonGroupAndAddTo(new ListCollection(
                [
                    {label: "Done", triggered: btnDoneHandler},
                    {label: "Cancel", triggered: btnCancelHandler},
                ]
        ), this);

        _buttonGroup.x = this.stage.stageWidth - _buttonGroup.width >> 1;
        _buttonGroup.y = this.stage.stageHeight - _buttonGroup.height - 10;
    }

    private function btnCancelHandler(e:Event):void {
        if (_currentWord) {
            _currentWord.text = "";
            _game.gameBoard.setToCanSelectChar();
            _canDone = false;
        }
    }

    private function btnDoneHandler(e:Event):void {
        if (_canDone) {
            _currentWord = Factory.createLabelAndAddTo("", _collectedWords);
            _game.state = Game.ADD_CHAR;
            _canDone = false;
        }
    }

    public function addCharToCurrentWord(char:String):void {
        if (_currentWord) {
            _currentWord.text += char;
            _canDone = true;
        }
    }

    override public function set visible(value:Boolean):void {
        _buttonGroup.visible = value;
    }
}
}
