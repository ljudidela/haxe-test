package ui;

import h2d.Text;
import h2d.Flow;

class StoryScreen extends h2d.Object {
    public function new(parent:h2d.Object, onComplete:Void->Void) {
        super(parent);

        var flow = new Flow(this);
        flow.layout = Vertical;
        flow.fillWidth = true;
        flow.fillHeight = true;
        flow.verticalAlign = Middle;
        flow.horizontalAlign = Middle;

        var t = new Text(hxd.res.DefaultFont.get(), flow);
        t.text = "You enter the cursed Dragonia Castle...

Rumors say the Holy Goblet is hidden on the 30th floor.
Many have entered. None have returned.

Prepare yourself.";
        t.textAlign = Center;
        t.scale(2);

        var sub = new Text(hxd.res.DefaultFont.get(), flow);
        sub.text = "[ Click to Enter ]";
        sub.textColor = 0xAAAAAA;
        sub.scale(1.5);
        flow.getProperties(sub).paddingTop = 50;

        var i = new h2d.Interactive(1280, 720, this);
        i.onClick = (_) -> onComplete();
    }
}