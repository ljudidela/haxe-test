package world;

import h2d.Graphics;

class Entity {
    public var cx:Int;
    public var cy:Int;
    public var sprite:Graphics;
    public var game:Game;

    public function new(game:Game, x:Int, y:Int, color:Int) {
        this.game = game;
        this.cx = x;
        this.cy = y;
        
        sprite = new Graphics(game.worldLayer);
        sprite.beginFill(color);
        sprite.drawRect(0, 0, Const.TILE_SIZE, Const.TILE_SIZE);
        sprite.endFill();
        
        updatePos();
    }

    public function updatePos() {
        sprite.x = cx * Const.TILE_SIZE;
        sprite.y = cy * Const.TILE_SIZE;
    }

    public function remove() {
        sprite.remove();
    }
}