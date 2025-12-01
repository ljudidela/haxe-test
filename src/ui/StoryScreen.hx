package ui;

class StoryScreen extends h2d.Object {
    var text:h2d.Text;

    public function new(content:String, parent:h2d.Object) {
        super(parent);
        text = new h2d.Text(hxd.res.DefaultFont.get(), this);
        text.text = content;
        text.scale(2);
        text.maxWidth = 600;
        text.textColor = Const.COLOR_TEXT;
    }
}