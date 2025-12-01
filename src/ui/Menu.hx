package ui;

import h2d.Flow;
import h2d.Text;
import hxd.Event;

class Menu extends h2d.Object {
    public function new(parent:h2d.Object) {
        super(parent);
        
        var flow = new Flow(this);
        flow.layout = Vertical;
        flow.verticalSpacing = 20;
        flow.horizontalAlign = Middle;
        flow.fillWidth = true;
        flow.fillHeight = true;

        var font = hxd.res.DefaultFont.get();
        
        var title = new Text(font, flow);
        title.text = "FATAL LABYRINTH: REBORN";
        title.scale(3);
        title.textColor = 0xFF0000;

        addSpacer(flow, 50);

        addButton(flow, "NEW GAME", () -> Main.inst.startNewGame());
        
        var continueBtn = addButton(flow, "CONTINUE", () -> Main.inst.continueGame());
        if (!Main.inst.hasSave) continueBtn.alpha = 0.5;

        addButton(flow, "SETTINGS", () -> trace("Settings clicked"));
        addButton(flow, "EXIT", () -> Main.inst.exitGame());
    }

    function addSpacer(flow:Flow, h:Int) {
        var s = new h2d.Object(flow);
        flow.getProperties(s).minHeight = h;
    }

    function addButton(flow:Flow, label:String, onClick:Void->Void):h2d.Object {
        var t = new Text(hxd.res.DefaultFont.get(), flow);
        t.text = label;
        t.scale(2);
        
        var i = new h2d.Interactive(t.textWidth * 2, t.textHeight * 2, t);
        i.onOver = (_) -> t.textColor = 0xFFFF00;
        i.onOut = (_) -> t.textColor = 0xFFFFFF;
        i.onClick = (_) -> {
            if (t.alpha == 1) onClick();
        };
        return t;
    }
}