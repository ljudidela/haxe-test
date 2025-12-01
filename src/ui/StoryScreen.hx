package ui;

import h2d.Text;
import hxd.res.DefaultFont;

class StoryScreen extends h2d.Object {
    public function new(parent:h2d.Object) {
        super(parent);
        
        var t = new Text(DefaultFont.get(), this);
        t.text = "The year is 2025...

" +
                 "You have entered the Fatal Labyrinth.
" +
                 "Rumors say the source of infinite spaghetti code lies at the bottom.

" +
                 "Survive. Descend. Debug.

" +
                 "[PRESS ANY KEY TO START]";
        t.scale(1.5);
        t.textAlign = Center;
        t.x = hxd.Window.getInstance().width / 2;
        t.y = 200;
    }

    public function onEvent(e:hxd.Event) {
        if (e.kind == hxd.Event.EKeyDown || e.kind == hxd.Event.EClick) {
            Main.inst.startGame(false);
        }
    }
}