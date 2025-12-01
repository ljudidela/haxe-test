package scenes;

import h2d.Scene;
import h2d.Graphics;
import core.Game;
import world.LevelGenerator;
import world.Entity;
import ui.Hud;

class PlayScene extends Scene {
    var map:Array<Array<Int>>;
    var entities:Array<Entity>;
    var player:Entity;
    var hud:Hud;
    var tileSize:Int = 32;
    var mapWidth:Int = 40;
    var mapHeight:Int = 25;
    var mapContainer:h2d.Object;

    public function new() {
        super();
        mapContainer = new h2d.Object(this);
        mapContainer.x = 20;
        mapContainer.y = 60;

        initLevel();
        hud = new Hud(this);
    }

    function initLevel() {
        // Generate Map
        var gen = new LevelGenerator(mapWidth, mapHeight);
        map = gen.generate();
        
        // Draw Map
        mapContainer.removeChildren();
        var g = new Graphics(mapContainer);
        for(y in 0...mapHeight) {
            for(x in 0...mapWidth) {
                if(map[y][x] == 1) {
                    g.beginFill(0x444444);
                    g.drawRect(x * tileSize, y * tileSize, tileSize, tileSize);
                    g.endFill();
                } else if (map[y][x] == 2) {
                    g.beginFill(0x0000FF);
                    g.drawRect(x * tileSize + 5, y * tileSize + 5, tileSize - 10, tileSize - 10);
                    g.endFill();
                } else {
                    g.beginFill(0x222222);
                    g.drawRect(x * tileSize, y * tileSize, tileSize, tileSize);
                    g.endFill();
                    // Grid lines
                    g.lineStyle(1, 0x333333);
                    g.drawRect(x * tileSize, y * tileSize, tileSize, tileSize);
                    g.lineStyle();
                }
            }
        }

        // Spawn Entities
        entities = [];
        var startPos = gen.getFreeSpot(map);
        player = new Entity(startPos.x, startPos.y, 0x00FF00, mapContainer);
        
        // Spawn Enemies
        var enemyCount = 5 + Game.level;
        for(i in 0...enemyCount) {
            var pos = gen.getFreeSpot(map);
            if(pos.x != player.cx || pos.y != player.cy) {
                var enemy = new Entity(pos.x, pos.y, 0xFF0000, mapContainer);
                enemy.hp = 20 + Game.level * 5;
                entities.push(enemy);
            }
        }
    }

    override function update(dt:Float) {
        handleInput();
        hud.updateStats();
    }

    function handleInput() {
        var dx = 0;
        var dy = 0;
        if (hxd.Key.isPressed(hxd.Key.UP)) dy = -1;
        else if (hxd.Key.isPressed(hxd.Key.DOWN)) dy = 1;
        else if (hxd.Key.isPressed(hxd.Key.LEFT)) dx = -1;
        else if (hxd.Key.isPressed(hxd.Key.RIGHT)) dx = 1;

        if (dx != 0 || dy != 0) {
            turn(dx, dy);
        }
        
        if (hxd.Key.isPressed(hxd.Key.ESCAPE)) {
            Game.save();
            Main.inst.setScene(new MenuScene());
        }
    }

    function turn(dx:Int, dy:Int) {
        var targetX = player.cx + dx;
        var targetY = player.cy + dy;

        // Wall Collision
        if (map[targetY][targetX] == 1) return;

        // Enemy Interaction
        var hitEnemy:Entity = null;
        for(e in entities) {
            if(e.cx == targetX && e.cy == targetY) {
                hitEnemy = e;
                break;
            }
        }

        if(hitEnemy != null) {
            // Attack
            hitEnemy.hp -= 10;
            // Simple particle effect
            flashColor(hitEnemy.sprite, 0xFFFFFF);
            if(hitEnemy.hp <= 0) {
                hitEnemy.remove();
                entities.remove(hitEnemy);
                Game.gold += 10;
            }
        } else {
            // Move
            player.cx = targetX;
            player.cy = targetY;
            player.updatePos();

            // Stairs
            if (map[targetY][targetX] == 2) {
                nextLevel();
                return;
            }
        }

        // Enemy Turn
        for(e in entities) {
            // Simple AI: if close, attack, else random move
            var dist = Math.abs(e.cx - player.cx) + Math.abs(e.cy - player.cy);
            if (dist == 1) {
                Game.playerHp -= 5;
                flashColor(player.sprite, 0xFF0000);
                if(Game.playerHp <= 0) gameOver();
            }
        }
    }

    function flashColor(obj:h2d.Object, color:Int) {
        obj.alpha = 0.5;
        haxe.Timer.delay(function() obj.alpha = 1, 100);
    }

    function nextLevel() {
        Game.level++;
        Game.save();
        Main.inst.setScene(new StoryScene("Descending to Floor " + Game.level, new PlayScene()));
    }

    function gameOver() {
        Game.save(); // Or delete save for roguelike permadeath
        Main.inst.setScene(new StoryScene("GAME OVER
You died on floor " + Game.level, new MenuScene()));
    }
}