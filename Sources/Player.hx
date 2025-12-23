import kha.System;
import Colliders.Collidable;


class Player implements Collidable {
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;
    var shootCooldown:Int = 0;

    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
        this.width = 50;
        this.height = 50;
    }

    public function update() {
        if (x < 0) x = 0;
        if (x > System.windowWidth() - width) x = System.windowWidth() - width;
        if (y < 0) y = 0;
        if (y > System.windowHeight() - height) y = System.windowHeight() - height;
        if (shootCooldown > 0) shootCooldown--;
    }

    public function shoot(bullets:Array<Bullet>) {
        if (shootCooldown <= 0) {
            bullets.push(new Bullet(x + width / 2 - 5, y, true));
            shootCooldown = 10;
        }
    }

    public function render(g2:kha.graphics2.Graphics) {
        g2.color = Color.fromBytes(0, 200, 255);
        g2.fillRect(x, y, width, height);
        
        g2.color = Color.fromBytes(0, 150, 200);
        g2.fillTriangle(x + width / 2, y - 10, x + 10, y + 20, x + width - 10, y + 20);
    }
}