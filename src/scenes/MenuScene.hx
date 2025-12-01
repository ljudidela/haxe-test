package scenes;

import h2d.Scene;
import h2d.Text;
import hxd.Event;
import hxd.System;
import core.Game;

class MenuScene extends Scene {
    var items:Array<Text> = [];
    var selected:Int = 0;
    var menuOptions:Array<{name:String, action:Void->Void}>;

    public function new() {
        super();
        var font = hxd.res.DefaultFont.get();
        
        var title = new Text(font, this);
        title.text = "FATAL LABYRINTH";
        title.scale(4);
        title.textColor = 0xFF0000;
        title.x = (getScene().width - title.textWidth * 4) / 2;
        title.y = 100;

        menuOptions = [
            { name: "NEW GAME", action: onNewGame },
            { name: "CONTINUE", action: onContinue },
            { name: "SETTINGS", action: onSettings },
            { name: "EXIT", action: onExit }
        ];

        for (i in 0...menuOptions.length) {
            var t = new Text(font, this);
            t.text = menuOptions[i].name;
            t.scale(2);
            t.x = (getScene().width - t.textWidth * 2) / 2;
            t.y = 300 + i * 50;
            items.push(t);
            
            // Mouse interaction
            var interactive = new h2d.Interactive(t.textWidth * 2, t.textHeight * 2, t);
            interactive.onOver = function(_) selected = i;
            interactive.onClick = function(_) menuOptions[i].action();
        }
    }

    override function update(dt:Float) {
        for (i in 0...items.length) {
            items[i].textColor = (i == selected) ? 0xFFFF00 : 0xFFFFFF;
            if (i == 1 && !Game.hasSave()) items[i].textColor = 0x555555; // Dim continue if no save
        }

        if (hxd.Key.isPressed(hxd.Key.UP)) selected = (selected - 1 + items.length) % items.length;
        if (hxd.Key.isPressed(hxd.Key.DOWN)) selected = (selected + 1) % items.length;
        if (hxd.Key.isPressed(hxd.Key.ENTER)) menuOptions[selected].action();
    }

    function onNewGame() {
        Game.newGame();
        Main.inst.setScene(new StoryScene("You enter the cursed dungeon...
Floor " + Game.level, new PlayScene()));
    }

    function onContinue() {
        if (!Game.hasSave()) return;
        Game.load();
        Main.inst.setScene(new PlayScene());
    }

    function onSettings() {
        Main.inst.setScene(new StoryScene("Settings:
Sound: ON
Graphics: RETRO

(Press SPACE to return)", new MenuScene()));
    }

    function onExit() {
        System.exit();
    }
}