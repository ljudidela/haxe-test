package ui;

import h2d.Object;
import h2d.Text;
import h2d.Flow;
import core.Game;

class Hud extends Object {
    var txtHp:Text;
    var txtLevel:Text;
    var txtGold:Text;
    var txtInv:Text;

    public function new(parent:Object) {
        super(parent);
        var font = hxd.res.DefaultFont.get();
        
        var flow = new Flow(this);
        flow.layout = Horizontal;
        flow.spacing = 20;
        flow.padding = 10;
        flow.x = 10;
        flow.y = 10;

        txtHp = new Text(font, flow);
        txtLevel = new Text(font, flow);
        txtGold = new Text(font, flow);
        txtInv = new Text(font, this);
        txtInv.y = 40;
        txtInv.x = 20;
        
        updateStats();
    }

    public function updateStats() {
        txtHp.text = "HP: " + Game.playerHp + "/" + Game.playerMaxHp;
        txtLevel.text = "FLOOR: " + Game.level;
        txtGold.text = "GOLD: " + Game.gold;
        txtInv.text = "INVENTORY: " + Game.inventory.join(", ");
        
        txtHp.textColor = (Game.playerHp < 30) ? 0xFF0000 : 0xFFFFFF;
    }
}