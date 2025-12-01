package ui;

import h2d.Text;
import h2d.Flow;
import hxd.Event;
import hxd.res.DefaultFont;

class Menu extends h2d.Object {
    var items:Array<Text> = [];
    var selected:Int = 0;
    var flow:Flow;

    public function new(parent:h2d.Object) {
        super(parent);
        
        var title = new Text(DefaultFont.get(), this);
        title.text = "FATAL LABYRINTH: HAXE EDITION";
        title.scale(2);
        title.x = 100;
        title.y = 50;

        flow = new Flow(this);
        flow.layout = Vertical;
        flow.spacing = 10;
        flow.x = 100;
        flow.y = 150;

        addItem("New Game", () -> Main.inst.startStory());
        addItem("Continue", () -> Main.inst.startGame(true));
        addItem("Settings", () -> trace("Settings clicked"));
        addItem("Exit", () -> hxd.System.exit());

        updateSelection();
    }

    function addItem(label:String, onClick:Void->Void) {
        var t = new Text(DefaultFont.get(), flow);
        t.text = label;
        t.scale(1.5);
        
        // Interactive setup
        var i = new h2d.Interactive(100, 20, t);
        i.onClick = (_) -> onClick();
        i.onOver = (_) -> {
            selected = items.indexOf(t);
            updateSelection();
        };
        
        items.push(t);
    }

    function updateSelection() {
        for (i in 0...items.length) {
            items[i].textColor = (i == selected) ? Const.C_HIGHLIGHT : Const.C_TEXT;
        }
    }

    public function onEvent(e:Event) {
        if (e.kind == EKeyDown) {
            if (e.keyCode == hxd.Key.UP) {
                selected--;
                if (selected < 0) selected = items.length - 1;
                updateSelection();
            } else if (e.keyCode == hxd.Key.DOWN) {
                selected++;
                if (selected >= items.length) selected = 0;
                updateSelection();
            } else if (e.keyCode == hxd.Key.ENTER) {
                // Trigger click on selected
                var interactive = cast(items[selected].getComponents()[0], h2d.Interactive);
                interactive.onClick(new Event(EClick));
            }
        }
    }
}