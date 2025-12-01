package;

import hxd.App;
import hxd.System;
import ui.Menu;
import ui.StoryScreen;

class Main extends App {
    public static var inst:Main;
    
    public var game:Game;
    public var savedFloor:Int = 1;
    public var hasSave:Bool = false;

    override function init() {
        inst = this;
        s2d.scaleMode = ScaleMode.LetterBox(1280, 720);
        showMenu();
    }

    public function showMenu() {
        s2d.removeChildren();
        new Menu(s2d);
    }

    public function startNewGame() {
        savedFloor = 1;
        hasSave = true;
        showStory();
    }

    public function showStory() {
        s2d.removeChildren();
        new StoryScreen(s2d, () -> startGame());
    }

    public function continueGame() {
        if (hasSave) {
            startGame(savedFloor);
        }
    }

    public function startGame(floor:Int = 1) {
        s2d.removeChildren();
        game = new Game(s2d, floor);
    }

    public function exitGame() {
        System.exit();
    }

    static function main() {
        new Main();
    }
}