package core;

class Game {
    public static var inst(default, null):Game = new Game();

    public var level:Int = 1;
    public var hp:Int = 100;
    public var maxHp:Int = 100;
    public var gold:Int = 0;
    public var xp:Int = 0;
    
    // Persistence
    public function new() {}

    public function reset() {
        level = 1;
        hp = 100;
        maxHp = 100;
        gold = 0;
        xp = 0;
    }

    public function save() {
        var data = {
            level: level,
            hp: hp,
            maxHp: maxHp,
            gold: gold,
            xp: xp
        };
        hxd.Save.save(data, "savefile");
    }

    public function load():Bool {
        try {
            var data = hxd.Save.load(null, "savefile");
            if (data == null) return false;
            level = data.level;
            hp = data.hp;
            maxHp = data.maxHp;
            gold = data.gold;
            xp = data.xp;
            return true;
        } catch(e:Dynamic) {
            return false;
        }
    }
}