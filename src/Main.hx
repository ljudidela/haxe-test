package;

import hxd.App;
import ui.Menu;
import ui.StoryScreen;

class Main extends App {
    public static var inst:Main;
    
    var currentScene:h2d.Object;
    var menu:Menu;
    var story:StoryScreen;
    var game:Game;

    override function init() {
        inst = this;
        s2d.scaleMode = LetterBox(1280, 720);
        engine.backgroundColor = Const.C_BG;
        showMenu();
    }

    public function showMenu() {
        clearScene();
        menu = new Menu(s2d);
        currentScene = menu;
    }

    public function startStory() {
        clearScene();
        story = new StoryScreen(s2d);
        currentScene = story;
    }

    public function startGame(load:Bool) {
        clearScene();
        game = new Game(s2d, load);
        currentScene = game;
    }

    function clearScene() {
        if (currentScene != null) {
            currentScene.remove();
            currentScene = null;
        }
        menu = null;
        story = null;
        game = null;
    }

    override function update(dt:Float) {
        // Global input routing
    }

    public static function main() {
        new Main();
    }

    // Event routing hack for simple state machine
    override function onEvent(e:hxd.Event) {
        if (menu != null) menu.onEvent(e);
        else if (story != null) story.onEvent(e);
        else if (game != null) game.onEvent(e);
    }
}