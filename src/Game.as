package {
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.getTimer;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.EventDispatcher;

public class Game extends Sprite {

    public static const ADD_CHAR:int = 0;
    public static const ADD_WORD:int = 1;

    public static var GLOBAL_DISPATCHER:EventDispatcher;

    public function Game() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, loadAndParseDictToTree);
    }

    private function loadAndParseDictToTree(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        GLOBAL_DISPATCHER = new EventDispatcher();

        selectTheme();

        new Log(Factory.createLabelAndAddTo("", this));


        var ss:Number = getTimer();
        var textLoader:URLLoader = new URLLoader();
        textLoader.addEventListener(Event.COMPLETE, onLoaded);
        textLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
        textLoader.load(new URLRequest("dict.txt"));

        function onLoaded(e:flash.events.Event):void {
            Log.print(String(getTimer() - ss) + " ms", " dict loaded ");

            var s:* = getTimer();
//            var words:Array = e.target.data.split(/\r\n/);
            Log.print(String(getTimer() - s) + " ms", " split done ");

            var tree:DictionaryTree = new DictionaryTree();
//            for each (var word:String in words) {
//                tree.addToLexicalRoot(word);
//                tree.addToInvertedRoot(word);
//            }
            Log.print(String(getTimer() - s) + " ms", " parse dict done ");

//            var json_out:String = JSON.stringify(tree);
//            var json_in:* = JSON.parse(json_out);
            init();
        }

        function onError(e:IOErrorEvent):void {
            Log.print("LOAD ERROR");
        }
    }

    private function init():void {
        var mainMenu:MainMenu = new MainMenu(this);
        addChild(mainMenu);
    }

    private var _gameBoard:GameBoard;
    private var _alphabet:Alphabet;

    private var _collectedWordsControl:CollectedWordsControl;
    private var _state:int = -1;
    private var _alphabetReady:Boolean;
    private var _gameBoardReady:Boolean;

    public static const BOARD_READY:String = "board_ready";

    public function start():void {
        _collectedWordsControl = Factory.createCollectedWordsControl(this, this);

        _gameBoard = Factory.createGameBoard("БАЛДА", this);
        Helper.centeredByStage(_gameBoard, this.stage);

        _alphabet = Factory.createAlphabet(this);
        _alphabet.x = this.stage.stageWidth - _alphabet.width >> 1;
        _alphabet.y = this.stage.stageHeight - _alphabet.height - 10;

        state = ADD_CHAR;

        GLOBAL_DISPATCHER.addEventListener(BOARD_READY, boardReadyHandler);
    }

    public function boardReadyHandler(e:Event):void {
        if (_alphabetReady && e.data is GameBoard) {
            processBoardToBoard();
        } else if (_gameBoardReady && e.data is Alphabet) {
            processBoardToBoard();
        } else if (e.data is Alphabet) {
            _alphabetReady = true;
        } else if (e.data is GameBoard) {
            if (_gameBoardReady) {
                _alphabet.btnDoneVisible = true;
            } else {
                _gameBoardReady = true;
            }
        }
    }

    public function set state(state:int):void {
        if (_state != state) {
            _state = state;
            switch (_state) {
                case ADD_CHAR:
                    _alphabet.visible = true;
                    _gameBoard.setToCanSelectChar();
                    _collectedWordsControl.visible = false;
                    break;
                case ADD_WORD:
                    _gameBoard.setToCanSelectWord();
                    _alphabet.visible = false;
                    _collectedWordsControl.visible = true;
                    break;
            }
        }
    }

    public function processBoardToBoard():void {
        _gameBoard.putCharInSelectedCell(_alphabet.selectedCell);
        _alphabet.disableSelectedCell();
        _alphabet.btnDoneVisible = true;
        _alphabetReady = _gameBoardReady = false;
    }

    public function selectTheme():void {
//        new MetalWorksMobileTheme();
//        new AeonDesktopTheme();
//        new MinimalMobileTheme();
        new ExtendedAeonDesktopTheme();
    }

    public function collectWord(char:String):void {
        _collectedWordsControl.addCharToCurrentWord(char);
    }

    public function get state():int {
        return _state;
    }

    public function get gameBoard():GameBoard {
        return _gameBoard;
    }
}
}
