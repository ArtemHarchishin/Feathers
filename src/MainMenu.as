package {
import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import starling.display.Sprite;
import starling.events.Event;

public class MainMenu extends Sprite {
    private var _game:Game;

    public function MainMenu(game:Game) {
        super();
        _game = game;
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        var buttonGroup:ButtonGroup = Factory.createButtonGroupAndAddTo(new ListCollection(
                [
                    {label: "Start", triggered: btnStartHandler},
                    {label: "Exit", triggered: btnExitHandler},
                ]
        ), this);

        Helper.setControlPosition(buttonGroup,
                (_game.stage.stageWidth - buttonGroup.width) / 2,
                (_game.stage.stageHeight - buttonGroup.height) / 2);
    }

    private function btnStartHandler(e:Event):void {
        visible = false;
        if (_game) {
            _game.start();
        }
    }

    private function btnExitHandler(e:Event):void {
        visible = false;
    }
}
}
