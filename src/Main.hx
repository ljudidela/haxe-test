package;

import hxd.App;
import h2d.Scene;
import core.Game;
import scenes.MenuScene;

class Main extends App {
    public static var inst: Main;

    override function init() {
        inst = this;
        // Initialize global game state
        Game.init();
        // Start with Menu
        setScene(new MenuScene());
    }

    public function setScene(newScene:h2d.Scene) {
        setScene2D(newScene);
    }

    static function main() {
        new Main();
    }
}