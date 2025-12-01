package scenes;

import hxd.Key;

class MenuScene extends h2d.Scene {
    var menu:ui.Menu;

    public function new() {
        super();
        var title = new h2d.Text(hxd.res.DefaultFont.get(), this);
        title.text = "FATAL LABYRINTH: HAXE EDITION";
        title.scale(3);
        title.x = 100;
        title.y = 50;
        title.textColor = 0xFF0000;

        menu = new ui.Menu(this);
        menu.x = 100;
        menu.y = 200;

        menu.addItem("NEW GAME", function() {
            core.Game.inst.reset();
            Main.inst.setScene(new scenes.StoryScene());
        });

        menu.addItem("CONTINUE", function() {
            if (core.Game.inst.load()) {
                Main.inst.setScene(new scenes.PlayScene());
            } else {
                // Shake effect or sound could go here
                trace("No save file");
            }
        });

        menu.addItem("EXIT", function() {
            hxd.System.exit();
        });
    }

    override function update(dt:Float) {
        if (Key.isPressed(Key.UP)) menu.prev();
        if (Key.isPressed(Key.DOWN)) menu.next();
        if (Key.isPressed(Key.ENTER)) menu.trigger();
    }
}