import h2d.Scene;

class Main extends hxd.App {
    public static var inst:Main;

    override function init() {
        inst = this;
        s2d.scaleMode = ScaleMode.LetterBox(1280, 720);
        // Start with Menu
        setScene(new scenes.MenuScene());
    }

    public function setScene(newScene:Scene) {
        setScene2D(newScene);
    }

    static function main() {
        new Main();
    }
}