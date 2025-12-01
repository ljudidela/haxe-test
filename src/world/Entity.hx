package world;

import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;

class Entity extends Object {
    public var cx:Int;
    public var cy:Int;
    public var level:Level;
    var sprite:Bitmap;

    public function new(level:Level, x:Int, y:Int, color:Int) {
        super(level);
        this.level = level;
        this.cx = x;
        this.cy = y;
        
        var t = Tile.fromColor(color, Const.TILE_SIZE, Const.TILE_SIZE);
        sprite = new Bitmap(t, this);
        
        updatePos();
    }

    public function updatePos() {
        this.x = cx * Const.TILE_SIZE;
        this.y = cy * Const.TILE_SIZE;
    }
}