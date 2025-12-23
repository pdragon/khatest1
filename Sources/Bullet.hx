import Colliders.Collidable;

class Bullet implements Collidable {
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;
    var speed:Float;
    var isPlayerBullet:Bool;

    public function new(x:Float, y:Float, isPlayerBullet:Bool) {
        this.x = x;
        this.y = y;
        this.width = 10;
        this.height = 20;
        this.isPlayerBullet = isPlayerBullet;
        this.speed = isPlayerBullet ? -8 : 5;
    }

    public function update() {
        y += speed;
    }

    public function render(g2:kha.graphics2.Graphics) {
        g2.color = isPlayerBullet ? 
                   Color.fromBytes(255, 255, 100) : 
                   Color.fromBytes(255, 100, 100);
        g2.fillRect(x, y, width, height);
    }
}