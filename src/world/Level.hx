package world;

import h2d.Graphics;

class Level {
    public var width:Int;
    public var height:Int;
    public var tiles:Array<Array<Int>>;
    public var root:h2d.Object;
    var graphics:Graphics;

    public var startX:Int;
    public var startY:Int;
    public var exitX:Int;
    public var exitY:Int;

    public function new(parent:h2d.Object, w:Int, h:Int) {
        this.width = w;
        this.height = h;
        this.root = new h2d.Object(parent);
        this.graphics = new Graphics(root);
        generate();
    }

    function generate() {
        // Initialize with walls
        tiles = [for (y in 0...height) [for (x in 0...width) 0]];

        // Simple Random Walk for dungeon generation
        var cx = Std.int(width / 2);
        var cy = Std.int(height / 2);
        startX = cx;
        startY = cy;

        var steps = 400;
        while (steps > 0) {
            tiles[cy][cx] = 1; // Floor
            var dir = Std.random(4);
            switch(dir) {
                case 0: if(cx < width - 2) cx++;
                case 1: if(cx > 1) cx--;
                case 2: if(cy < height - 2) cy++;
                case 3: if(cy > 1) cy--;
            }
            steps--;
            // Mark last position as exit candidate
            if (steps == 0) {
                exitX = cx;
                exitY = cy;
                tiles[cy][cx] = 2; // Stairs
            }
        }

        draw();
    }

    function draw() {
        graphics.clear();
        for (y in 0...height) {
            for (x in 0...width) {
                var t = tiles[y][x];
                if (t == 0) continue; // Skip walls (bg color)
                
                if (t == 1) graphics.beginFill(Const.C_FLOOR);
                else if (t == 2) graphics.beginFill(Const.C_STAIRS);
                
                graphics.drawRect(x * Const.TILE_SIZE, y * Const.TILE_SIZE, Const.TILE_SIZE, Const.TILE_SIZE);
                graphics.endFill();
            }
        }
    }

    public function isWall(x:Int, y:Int):Bool {
        if (x < 0 || x >= width || y < 0 || y >= height) return true;
        return tiles[y][x] == 0;
    }

    public function isExit(x:Int, y:Int):Bool {
        if (x < 0 || x >= width || y < 0 || y >= height) return false;
        return tiles[y][x] == 2;
    }

    public function remove() {
        root.remove();
    }
}