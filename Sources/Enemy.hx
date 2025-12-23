import kha.System;

import Colliders.Collidable;

class Enemy implements Collidable {
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;
    var speed:Float;

    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
        this.width = 40;
        this.height = 40;
        this.speed = 1 + Math.random() * 2;
    }

    public function update() {
        y += speed;
        x += (Math.random() - 0.5) * 2;
        if (x < 0) x = 0;
        if (x > System.windowWidth() - width) x = System.windowWidth() - width;
    }

    public function render(g2:kha.graphics2.Graphics) {
        g2.color = Color.fromBytes(255, 50, 50);
        g2.fillRect(x, y, width, height);
        
        g2.color = Color.fromBytes(200, 0, 0);
        g2.fillRect(x + 5, y + 5, width - 10, 10);
    }
}