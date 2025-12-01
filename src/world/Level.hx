package world;

import h2d.Object;
import h2d.Tile;
import h2d.Bitmap;

class Level extends Object {
    public var width:Int;
    public var height:Int;
    public var tiles:Array<Array<Int>>;
    public var startX:Int = 1;
    public var startY:Int = 1;
    public var exitX:Int = 1;
    public var exitY:Int = 1;

    var tileGroup:h2d.TileGroup;

    public function new(parent:Object, w:Int, h:Int, floor:Int) {
        super(parent);
        this.width = w;
        this.height = h;
        generate(floor);
        render();
    }

    function generate(floor:Int) {
        tiles = [for (y in 0...height) [for (x in 0...width) 1]]; // 1 = Wall

        // Simple drunkard's walk for generation
        var cx = Std.int(width / 2);
        var cy = Std.int(height / 2);
        startX = cx;
        startY = cy;

        var steps = 200 + (floor * 10);
        for (i in 0...steps) {
            tiles[cy][cx] = 0; // 0 = Floor
            var dir = Std.random(4);
            switch(dir) {
                case 0: if(cx < width - 2) cx++;
                case 1: if(cx > 1) cx--;
                case 2: if(cy < height - 2) cy++;
                case 3: if(cy > 1) cy--;
            }
        }
        exitX = cx;
        exitY = cy;
        tiles[exitY][exitX] = 2; // 2 = Stairs
    }

    function render() {
        var tFloor = Tile.fromColor(Const.COLOR_FLOOR, Const.TILE_SIZE, Const.TILE_SIZE);
        var tWall = Tile.fromColor(Const.COLOR_WALL, Const.TILE_SIZE, Const.TILE_SIZE);
        var tStairs = Tile.fromColor(Const.COLOR_STAIRS, Const.TILE_SIZE, Const.TILE_SIZE);

        tileGroup = new h2d.TileGroup(tFloor, this);
        
        for (y in 0...height) {
            for (x in 0...width) {
                var t = tiles[y][x];
                if (t == 0) tileGroup.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, tFloor);
                else if (t == 1) tileGroup.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, tWall);
                else if (t == 2) tileGroup.add(x * Const.TILE_SIZE, y * Const.TILE_SIZE, tStairs);
            }
        }
    }

    public function isWalkable(x:Int, y:Int):Bool {
        if (x < 0 || x >= width || y < 0 || y >= height) return false;
        return tiles[y][x] != 1;
    }

    public function getTile(x:Int, y:Int):Int {
        if (x < 0 || x >= width || y < 0 || y >= height) return 1;
        return tiles[y][x];
    }
}