package world;

import hxd.Key;

class Player extends Entity {
    public var hp:Int = 100;
    public var maxHp:Int = 100;
    public var gold:Int = 0;

    public function new(level:Level, x:Int, y:Int) {
        super(level, x, y, Const.COLOR_PLAYER);
        hxd.Window.getInstance().addEventTarget(onEvent);
    }

    override function onRemove() {
        hxd.Window.getInstance().removeEventTarget(onEvent);
        super.onRemove();
    }

    function onEvent(e:hxd.Event) {
        if (e.kind == EKeyDown) {
            var dx = 0;
            var dy = 0;
            
            switch(e.keyCode) {
                case Key.UP, Key.W: dy = -1;
                case Key.DOWN, Key.S: dy = 1;
                case Key.LEFT, Key.A: dx = -1;
                case Key.RIGHT, Key.D: dx = 1;
                case Key.ESCAPE: Main.inst.showMenu(); return;
            }

            if (dx != 0 || dy != 0) {
                move(dx, dy);
            }
        }
    }

    function move(dx:Int, dy:Int) {
        var nx = cx + dx;
        var ny = cy + dy;

        if (level.isWalkable(nx, ny)) {
            cx = nx;
            cy = ny;
            updatePos();
            
            // Check interactions
            var t = level.getTile(cx, cy);
            if (t == 2) { // Stairs
                Main.inst.game.nextLevel();
            }
            
            Main.inst.game.onTurn();
        }
    }
}