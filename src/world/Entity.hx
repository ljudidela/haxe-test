package world;

class Entity extends h2d.Object {
    public var cx:Int;
    public var cy:Int;
    public var sprite:h2d.Bitmap;

    public function new(x:Int, y:Int, color:Int, parent:h2d.Object) {
        super(parent);
        this.cx = x;
        this.cy = y;
        
        var tile = h2d.Tile.fromColor(color, Const.TILE_SIZE, Const.TILE_SIZE);
        sprite = new h2d.Bitmap(tile, this);
        
        updatePos();
    }

    public function updatePos() {
        this.x = cx * Const.TILE_SIZE;
        this.y = cy * Const.TILE_SIZE;
    }
}