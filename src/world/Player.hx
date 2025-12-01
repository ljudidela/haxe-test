package world;

class Player extends Entity {
    public function new(x:Int, y:Int, parent:h2d.Object) {
        super(x, y, Const.COLOR_PLAYER, parent);
    }
}