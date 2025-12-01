package scenes;

import hxd.Key;
import world.*;

class PlayScene extends h2d.Scene {
    var level:Level;
    var player:Player;
    var hud:ui.Hud;
    var gameLayer:h2d.Object;

    public function new() {
        super();
        
        // Layers
        gameLayer = new h2d.Object(this);
        hud = new ui.Hud(this);
        hud.x = 1280 - Const.UI_WIDTH;

        generateLevel();
    }

    function generateLevel() {
        gameLayer.removeChildren();
        
        var w = 30;
        var h = 20;
        var gen = LevelGenerator.generate(w, h);
        
        level = new Level(w, h, gameLayer);
        level.render(gen.map);

        player = new Player(gen.start.x, gen.start.y, gameLayer);
        
        centerCamera();
        hud.updateStats();
        
        // Auto-save on new level
        core.Game.inst.save();
    }

    function centerCamera() {
        // Simple centering
        gameLayer.x = (1280 - Const.UI_WIDTH) / 2 - player.x;
        gameLayer.y = 720 / 2 - player.y;
    }

    override function update(dt:Float) {
        var dx = 0;
        var dy = 0;

        if (Key.isPressed(Key.UP)) dy = -1;
        else if (Key.isPressed(Key.DOWN)) dy = 1;
        else if (Key.isPressed(Key.LEFT)) dx = -1;
        else if (Key.isPressed(Key.RIGHT)) dx = 1;

        if (dx != 0 || dy != 0) {
            movePlayer(dx, dy);
        }
    }

    function movePlayer(dx:Int, dy:Int) {
        var tx = player.cx + dx;
        var ty = player.cy + dy;

        if (level.isWalkable(tx, ty)) {
            player.cx = tx;
            player.cy = ty;
            player.updatePos();
            
            if (level.isStairs(tx, ty)) {
                nextLevel();
            }
            
            centerCamera();
        }
    }

    function nextLevel() {
        core.Game.inst.level++;
        core.Game.inst.xp += 10;
        generateLevel();
    }
}