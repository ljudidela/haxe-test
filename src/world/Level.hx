package world;

class Level extends h2d.Object {
    public var width:Int;
    public var height:Int;
    public var data:Array<Array<Int>>;
    var tiles:h2d.TileGroup;

    public function new(w:Int, h:Int, parent:h2d.Object) {
        super(parent);
        this.width = w;
        this.height = h;
        
        var t = h2d.Tile.fromColor(0xFFFFFF, Const.TILE_SIZE, Const.TILE_SIZE);
        tiles = new h2d.TileGroup(t, this);
    }

    public function render(mapData:Array<Array<Int>>) {
        this.data = mapData;
        tiles.clear();
        for(y in 0...height) {
            for(x in 0...width) {
                var type = mapData[y][x];
                if (type == 1) {
                    tiles.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, 1, 1, 1, 1).setColor(Const.COLOR_FLOOR);
                } else if (type == 0) {
                    tiles.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, 1, 1, 1, 1).setColor(Const.COLOR_WALL);
                } else if (type == 2) {
                    tiles.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, 1, 1, 1, 1).setColor(Const.COLOR_STAIRS);
                }
            }
        }
    }

    public function isWalkable(x:Int, y:Int):Bool {
        if (x < 0 || x >= width || y < 0 || y >= height) return false;
        return data[y][x] != 0;
    }

    public function isStairs(x:Int, y:Int):Bool {
        if (x < 0 || x >= width || y < 0 || y >= height) return false;
        return data[y][x] == 2;
    }
}