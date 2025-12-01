package ui;

import h2d.Object;
import h2d.Text;
import h2d.Flow;
import h2d.Bitmap;
import h2d.Tile;

class Hud extends Object {
    var hpText:Text;
    var floorText:Text;
    var goldText:Text;
    var logText:Text;

    public function new(parent:Object) {
        super(parent);
        
        // Background bar
        var bg = new Bitmap(Tile.fromColor(Const.COLOR_UI_BG, 1280, 60), this);
        bg.y = 720 - 60;
        bg.alpha = 0.8;

        var flow = new Flow(this);
        flow.y = 720 - 50;
        flow.x = 20;
        flow.horizontalSpacing = 40;

        var font = hxd.res.DefaultFont.get();

        hpText = new Text(font, flow);
        hpText.scale(1.5);
        
        floorText = new Text(font, flow);
        floorText.scale(1.5);

        goldText = new Text(font, flow);
        goldText.scale(1.5);
        goldText.textColor = 0xFFFF00;

        logText = new Text(font, this);
        logText.x = 20;
        logText.y = 20;
        logText.textColor = 0xAAAAAA;
    }

    public function updateStats(hp:Int, maxHp:Int, floor:Int, gold:Int) {
        hpText.text = "HP: " + hp + " / " + maxHp;
        floorText.text = "FLOOR: " + floor;
        goldText.text = "GOLD: " + gold;
    }

    public function updateLog(msg:String) {
        // Simple log update
    }

    public function addLog(msg:String) {
        logText.text = msg;
        logText.alpha = 1;
        haxe.Timer.delay(() -> logText.alpha = 0, 3000);
    }
}