package scenes;

class StoryScene extends h2d.Scene {
    public function new() {
        super();
        var content = "You stand before the entrance of the Fatal Labyrinth.

Many have entered.
None have returned.

Rumors speak of a Dragon at the bottom.

Press ENTER to descend...";
        
        var screen = new ui.StoryScreen(content, this);
        screen.x = 100;
        screen.y = 100;
    }

    override function update(dt:Float) {
        if (hxd.Key.isPressed(hxd.Key.ENTER)) {
            Main.inst.setScene(new scenes.PlayScene());
        }
    }
}