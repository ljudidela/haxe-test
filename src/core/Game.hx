package core;

class Game {
    public static var level:Int = 1;
    public static var playerHp:Int = 100;
    public static var playerMaxHp:Int = 100;
    public static var gold:Int = 0;
    public static var inventory:Array<String> = [];
    
    public static function init() {
        load();
    }

    public static function newGame() {
        level = 1;
        playerHp = 100;
        playerMaxHp = 100;
        gold = 0;
        inventory = ["Dagger", "Potion"];
    }

    public static function save() {
        var data = {
            level: level,
            hp: playerHp,
            maxHp: playerMaxHp,
            gold: gold,
            inv: inventory
        };
        hxd.Save.save(data, "savefile");
    }

    public static function load() {
        try {
            var data = hxd.Save.load(null, "savefile");
            if (data != null) {
                level = data.level;
                playerHp = data.hp;
                playerMaxHp = data.maxHp;
                gold = data.gold;
                inventory = data.inv;
            }
        } catch(e:Dynamic) {
            trace("No save found");
        }
    }

    public static function hasSave():Bool {
        return hxd.Save.load(null, "savefile") != null;
    }
}