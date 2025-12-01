package world;

import h2d.Object;
import h2d.Graphics;

class Entity {
    public var cx:Int;
    public var cy:Int;
    public var sprite:Graphics;
    public var hp:Int = 100;
    var tileSize:Int = 32;

    public function new(x:Int, y:Int, color:Int, parent:Object) {
        this.cx = x;
        this.cy = y;
        
        sprite = new Graphics(parent);
        sprite.beginFill(color);
        sprite.drawCircle(tileSize/2, tileSize/2, tileSize/2 - 2);
        sprite.endFill();
        
        updatePos();
    }

    public function updatePos() {
        sprite.x = cx * tileSize;
        sprite.y = cy * tileSize;
    }

    public function remove() {
        sprite.remove();
    }
}