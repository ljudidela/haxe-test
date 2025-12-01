package ui;

import h2d.Flow;
import h2d.Text;
import hxd.res.DefaultFont;

class Hud extends h2d.Object {
    var flow:Flow;
    var hpText:Text;
    var levelText:Text;
    var floorText:Text;
    var msgText:Text;

    public function new(parent:h2d.Object) {
        super(parent);
        
        flow = new Flow(this);
        flow.layout = Horizontal;
        flow.padding = 10;
        flow.spacing = 20;
        flow.y = Const.GRID_H * Const.TILE_SIZE;
        
        var font = DefaultFont.get();
        
        hpText = new Text(font, flow);
        levelText = new Text(font, flow);
        floorText = new Text(font, flow);
        msgText = new Text(font, flow);
        msgText.textColor = Const.C_HIGHLIGHT;
    }

    public function updateStats(hp:Int, max:Int, lvl:Int, floor:Int) {
        hpText.text = "HP: " + hp + " / " + max;
        levelText.text = "LVL: " + lvl;
        floorText.text = "FLOOR: " + floor;
    }

    public function showMessage(msg:String) {
        msgText.text = msg;
    }
}