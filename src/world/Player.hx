package world;

class Player extends Entity {
    public var hp:Int;
    public var maxHp:Int;
    public var level:Int;
    public var xp:Int;
    public var gold:Int;

    public function new(game:Game, x:Int, y:Int) {
        super(game, x, y, Const.C_PLAYER);
        // Default stats
        hp = 100;
        maxHp = 100;
        level = 1;
        xp = 0;
        gold = 0;
    }

    public function tryMove(dx:Int, dy:Int):Bool {
        var tx = cx + dx;
        var ty = cy + dy;

        if (game.level.isWall(tx, ty)) {
            return false;
        }

        cx = tx;
        cy = ty;
        updatePos();
        return true;
    }

    public function loadStats(data:Dynamic) {
        if (data == null) return;
        hp = data.hp;
        maxHp = data.maxHp;
        level = data.level;
        xp = data.xp;
        gold = data.gold;
    }

    public function getSaveData():Dynamic {
        return {
            hp: hp,
            maxHp: maxHp,
            level: level,
            xp: xp,
            gold: gold
        };
    }
}