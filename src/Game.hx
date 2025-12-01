package;

import h2d.Object;
import world.Level;
import world.Player;
import ui.Hud;
import hxd.Key;

class Game extends Object {
    public var level:Level;
    public var player:Player;
    public var hud:Hud;
    public var currentFloor:Int;
    
    var gameLayer:Object;
    var uiLayer:Object;

    public function new(parent:Object, floor:Int) {
        super(parent);
        this.currentFloor = floor;

        gameLayer = new Object(this);
        uiLayer = new Object(this);

        initLevel();
        initUI();
    }

    function initLevel() {
        if (level != null) level.remove();
        level = new Level(gameLayer, Const.GRID_W, Const.GRID_H, currentFloor);
        
        // Spawn player at start
        player = new Player(level, level.startX, level.startY);
        
        // Center camera roughly
        gameLayer.x = (1280 - Const.GRID_W * Const.TILE_SIZE) / 2;
        gameLayer.y = (720 - Const.GRID_H * Const.TILE_SIZE) / 2;
    }

    function initUI() {
        hud = new Hud(uiLayer);
        updateHud();
    }

    public function updateHud() {
        hud.updateStats(player.hp, player.maxHp, currentFloor, player.gold);
        hud.updateLog("Explored floor " + currentFloor);
    }

    public function nextLevel() {
        currentFloor++;
        Main.inst.savedFloor = currentFloor;
        initLevel();
        hud.addLog("Descended to floor " + currentFloor);
        updateHud();
    }

    public function onTurn() {
        // Process enemies here
        updateHud();
    }
}