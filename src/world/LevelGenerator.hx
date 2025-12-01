package world;

class LevelGenerator {
    public static function generate(w:Int, h:Int):{map:Array<Array<Int>>, start:{x:Int, y:Int}} {
        var map = [for (y in 0...h) [for (x in 0...w) 0]];
        
        // Simple Random Walk for guaranteed connectivity
        var cx = Std.int(w / 2);
        var cy = Std.int(h / 2);
        var start = {x: cx, y: cy};
        
        var floorCount = 0;
        var targetFloors = Std.int(w * h * 0.4);

        while (floorCount < targetFloors) {
            if (map[cy][cx] == 0) {
                map[cy][cx] = 1;
                floorCount++;
            }
            
            var dir = Std.random(4);
            if (dir == 0) cx++;
            else if (dir == 1) cx--;
            else if (dir == 2) cy++;
            else if (dir == 3) cy--;

            if (cx < 1) cx = 1;
            if (cx >= w - 1) cx = w - 2;
            if (cy < 1) cy = 1;
            if (cy >= h - 1) cy = h - 2;
        }

        // Place stairs far from start (simple random try)
        var stairsPlaced = false;
        while(!stairsPlaced) {
            var sx = Std.random(w);
            var sy = Std.random(h);
            if (map[sy][sx] == 1 && (Math.abs(sx - start.x) + Math.abs(sy - start.y) > 10)) {
                map[sy][sx] = 2;
                stairsPlaced = true;
            }
        }

        return {map: map, start: start};
    }
}