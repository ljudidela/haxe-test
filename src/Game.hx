package;

import world.Level;
import world.Player;
import ui.Hud;

class Game extends h2d.Object {
    public var worldLayer:h2d.Object;
    public var uiLayer:h2d.Object;
    
    public var level:Level;
    public var player:Player;
    public var hud:Hud;
    
    public var floorDepth:Int = 1;

    public function new(parent:h2d.Object, loadSave:Bool) {
        super(parent);
        
        worldLayer = new h2d.Object(this);
        uiLayer = new h2d.Object(this);
        
        hud = new Hud(uiLayer);
        
        if (loadSave && hxd.Save.load(null, "save") != null) {
            var data = hxd.Save.load(null, "save");
            floorDepth = data.floor;
            startLevel(true, data.player);
        } else {
            startLevel(false, null);
        }
    }

    function startLevel(restore:Bool, playerData:Dynamic) {
        if (level != null) level.remove();
        if (player != null) player.remove();

        level = new Level(worldLayer, Const.GRID_W, Const.GRID_H);
        
        player = new Player(this, level.startX, level.startY);
        if (restore && playerData != null) {
            player.loadStats(playerData);
        }

        hud.updateStats(player.hp, player.maxHp, player.level, floorDepth);
        hud.showMessage("Welcome to Floor " + floorDepth);
    }

    public function onEvent(e:hxd.Event) {
        if (e.kind == hxd.Event.EKeyDown) {
            var dx = 0;
            var dy = 0;
            
            switch(e.keyCode) {
                case hxd.Key.UP, hxd.Key.W: dy = -1;
                case hxd.Key.DOWN, hxd.Key.S: dy = 1;
                case hxd.Key.LEFT, hxd.Key.A: dx = -1;
                case hxd.Key.RIGHT, hxd.Key.D: dx = 1;
                case hxd.Key.ESCAPE: 
                    saveGame();
                    Main.inst.showMenu();
                    return;
            }

            if (dx != 0 || dy != 0) {
                takeTurn(dx, dy);
            }
        }
    }

    function takeTurn(dx:Int, dy:Int) {
        if (player.tryMove(dx, dy)) {
            // Check for stairs
            if (level.isExit(player.cx, player.cy)) {
                floorDepth++;
                hud.showMessage("Descending...");
                startLevel(true, player.getSaveData());
                saveGame();
            }
        }
        hud.updateStats(player.hp, player.maxHp, player.level, floorDepth);
    }

    function saveGame() {
        var data = {
            floor: floorDepth,
            player: player.getSaveData()
        };
        hxd.Save.save(data, "save");
    }
}