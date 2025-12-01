package ui;

class Menu extends h2d.Object {
    var items:Array<h2d.Text> = [];
    var selected:Int = 0;
    var font:h2d.Font;
    var callbacks:Array<Void->Void> = [];

    public function new(parent:h2d.Object) {
        super(parent);
        font = hxd.res.DefaultFont.get();
    }

    public function addItem(label:String, onClick:Void->Void) {
        var t = new h2d.Text(font, this);
        t.text = label;
        t.scale(2);
        t.y = items.length * 40;
        items.push(t);
        callbacks.push(onClick);
        refresh();
    }

    public function next() {
        selected = (selected + 1) % items.length;
        refresh();
    }

    public function prev() {
        selected--;
        if (selected < 0) selected = items.length - 1;
        refresh();
    }

    public function trigger() {
        if (callbacks[selected] != null) callbacks[selected]();
    }

    function refresh() {
        for (i in 0...items.length) {
            items[i].textColor = (i == selected) ? Const.COLOR_SELECT : Const.COLOR_TEXT;
        }
    }
}