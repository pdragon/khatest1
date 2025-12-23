import kha.Color;

class Particle {
    public var x:Float;
    public var y:Float;
    public var active:Bool = true;
    var vx:Float;
    var vy:Float;
    var life:Int;
    var color:Color;

    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
        this.vx = (Math.random() - 0.5) * 8;
        this.vy = (Math.random() - 0.5) * 8;
        this.life = 30;
        this.color = Color.fromBytes(
            Std.int(200 + Math.random() * 55),
            Std.int(100 + Math.random() * 155),
            Std.int(Math.random() * 100)
        );
    }

    public function update() {
        x += vx;
        y += vy;
        vy += 0.2;
        life--;
        if (life <= 0) active = false;
    }

    public function render(g2:kha.graphics2.Graphics) {
        g2.color = color;
        var size = 3 + life / 10;
        g2.fillRect(x, y, size, size);
    }
}