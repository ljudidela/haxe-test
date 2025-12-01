package ui;

class Hud extends h2d.Object {
    var hpText:h2d.Text;
    var lvlText:h2d.Text;
    var goldText:h2d.Text;

    public function new(parent:h2d.Object) {
        super(parent);
        var font = hxd.res.DefaultFont.get();
        
        var bg = new h2d.Bitmap(h2d.Tile.fromColor(0x333333, Const.UI_WIDTH, 720), this);
        
        hpText = new h2d.Text(font, this);
        hpText.scale(2);
        hpText.x = 10;
        hpText.y = 10;

        lvlText = new h2d.Text(font, this);
        lvlText.scale(2);
        lvlText.x = 10;
        lvlText.y = 50;

        goldText = new h2d.Text(font, this);
        goldText.scale(2);
        goldText.x = 10;
        goldText.y = 90;
    }

    public function updateStats() {
        var g = core.Game.inst;
        hpText.text = "HP: " + g.hp + " / " + g.maxHp;
        lvlText.text = "FLOOR: " + g.level;
        goldText.text = "GOLD: " + g.gold;
    }
}