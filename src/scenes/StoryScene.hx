package scenes;

import h2d.Scene;
import h2d.Text;

class StoryScene extends Scene {
    var nextScene:Scene;
    var time:Float = 0;

    public function new(content:String, next:Scene) {
        super();
        this.nextScene = next;
        
        var font = hxd.res.DefaultFont.get();
        var t = new Text(font, this);
        t.text = content;
        t.scale(2);
        t.textAlign = Center;
        t.x = getScene().width / 2;
        t.y = getScene().height / 2 - 50;
        
        var hint = new Text(font, this);
        hint.text = "Press SPACE or ENTER to continue";
        hint.y = getScene().height - 100;
        hint.x = (getScene().width - hint.textWidth) / 2;
    }

    override function update(dt:Float) {
        time += dt;
        if (time > 0.5 && (hxd.Key.isPressed(hxd.Key.SPACE) || hxd.Key.isPressed(hxd.Key.ENTER))) {
            Main.inst.setScene(nextScene);
        }
    }
}