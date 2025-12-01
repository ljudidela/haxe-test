package world;

class LevelGenerator {
    var width:Int;
    var height:Int;

    public function new(w:Int, h:Int) {
        this.width = w;
        this.height = h;
    }

    public function generate():Array<Array<Int>> {
        var map = [for (y in 0...height) [for (x in 0...width) 1]];

        // Simple Room Generation
        var rooms = [];
        for (i in 0...10) {
            var w = 4 + Std.random(6);
            var h = 4 + Std.random(6);
            var x = 1 + Std.random(width - w - 2);
            var y = 1 + Std.random(height - h - 2);
            
            // Carve room
            for (ry in y...y+h) {
                for (rx in x...x+w) {
                    map[ry][rx] = 0;
                }
            }
            rooms.push({x: x + Std.int(w/2), y: y + Std.int(h/2)});
        }

        // Connect rooms
        for (i in 0...rooms.length - 1) {
            var r1 = rooms[i];
            var r2 = rooms[i+1];
            
            // Horizontal corridor
            var minX = r1.x < r2.x ? r1.x : r2.x;
            var maxX = r1.x > r2.x ? r1.x : r2.x;
            for (x in minX...maxX + 1) map[r1.y][x] = 0;

            // Vertical corridor
            var minY = r1.y < r2.y ? r1.y : r2.y;
            var maxY = r1.y > r2.y ? r1.y : r2.y;
            for (y in minY...maxY + 1) map[y][r2.x] = 0;
        }

        // Place Stairs in the last room
        var last = rooms[rooms.length - 1];
        map[last.y][last.x] = 2;

        return map;
    }

    public function getFreeSpot(map:Array<Array<Int>>):{x:Int, y:Int} {
        while(true) {
            var x = Std.random(width);
            var y = Std.random(height);
            if (map[y][x] == 0) return {x: x, y: y};
        }
    }
}