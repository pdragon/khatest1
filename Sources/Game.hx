import kha.graphics2.Graphics;
import kha.Color;
import kha.System;
import kha.Framebuffer;
import kha.Scheduler;
import kha.input.Keyboard;
import kha.input.KeyCode;

import Bullet;
import Enemy;
import Particle;
import Colliders.Collidable;

class Game {
    var player:Player;
    var bullets:Array<Bullet>;
    var enemies:Array<Enemy>;
    var particles:Array<Particle>;
    var leftDown:Bool = false;
    var rightDown:Bool = false;
    var upDown:Bool = false;
    var downDown:Bool = false;
    var shootDown:Bool = false;
    var score:Int = 0;
    var gameFont:kha.Font; // Храним ссылку на шрифт

    public function new(font:kha.Font) {
        this.gameFont = font;
        trace("Игра запущена!");
        
        bullets = [];
        enemies = [];
        particles = [];
        player = new Player(375, 500);
        
        initInput();
        
        // Настройка рендеринга
        System.notifyOnFrames(function(framebuffers) {
            var g2 = framebuffers[0].g2;
            g2.begin();
            render(g2);
            g2.end();
        });
        
        Scheduler.addTimeTask(update, 0, 1 / 60);
        Scheduler.addTimeTask(spawnEnemy, 0, 0.5);
    }

    function initInput() {
        if (Keyboard.get() != null) {
            Keyboard.get().notify(keyDown, keyUp, null);
        }
    }

    function keyDown(key:KeyCode) {
        switch (key) {
            case KeyCode.Left, KeyCode.A: leftDown = true;
            case KeyCode.Right, KeyCode.D: rightDown = true;
            case KeyCode.Up, KeyCode.W: upDown = true;
            case KeyCode.Down, KeyCode.S: downDown = true;
            case KeyCode.Space: shootDown = true;
            default:
        }
    }

    function keyUp(key:KeyCode) {
        switch (key) {
            case KeyCode.Left, KeyCode.A: leftDown = false;
            case KeyCode.Right, KeyCode.D: rightDown = false;
            case KeyCode.Up, KeyCode.W: upDown = false;
            case KeyCode.Down, KeyCode.S: downDown = false;
            case KeyCode.Space: shootDown = false;
            default:
        }
    }

    function update() {
        var speed = 5;
        if (leftDown) player.x -= speed;
        if (rightDown) player.x += speed;
        if (upDown) player.y -= speed;
        if (downDown) player.y += speed;

        if (shootDown) {
            player.shoot(bullets);
        }

        player.update();
        
        for (bullet in bullets) bullet.update();
        for (enemy in enemies) enemy.update();
        for (particle in particles) particle.update();

        var bulletsCopy = bullets.copy();
        var enemiesCopy = enemies.copy();
        
        for (bullet in bulletsCopy) {
            for (enemy in enemiesCopy) {
                if (collision(bullet, enemy)) {
                    createExplosion(enemy.x + 20, enemy.y + 20);
                    enemies.remove(enemy);
                    bullets.remove(bullet);
                    score += 100;
                    break;
                }
            }
        }

        for (enemy in enemies) {
            if (collision(player, enemy)) {
                createExplosion(player.x + 25, player.y + 25);
            }
        }

        bullets = bullets.filter(function(bullet) {
            return bullet.y > -20 && bullet.y < System.windowHeight() + 20;
        });

        enemies = enemies.filter(function(enemy) {
            if (enemy.y > System.windowHeight()) {
                score -= 50;
                return false;
            }
            return true;
        });

        particles = particles.filter(function(p) return p.active);
    }

    function createExplosion(x:Float, y:Float) {
        for (i in 0...15) {
            particles.push(new Particle(x, y));
        }
    }

    function collision(obj1:Collidable, obj2:Collidable):Bool {
        return obj1.x < obj2.x + obj2.width &&
               obj1.x + obj1.width > obj2.x &&
               obj1.y < obj2.y + obj2.height &&
               obj1.y + obj1.height > obj2.y;
    }

    function spawnEnemy() {
        var x = Math.random() * (System.windowWidth() - 40);
        enemies.push(new Enemy(x, -40));
    }

    // ВАЖНО: без begin() и end()
    //function render(framebuffer:Framebuffer) {
    function render(g2:Graphics) {
        
        // Фон
        g2.color = Color.fromBytes(10, 10, 40);
        g2.fillRect(0, 0, System.windowWidth(), System.windowHeight());
        
        // Объекты
        for (particle in particles) particle.render(g2);
        for (enemy in enemies) enemy.render(g2);
        for (bullet in bullets) bullet.render(g2);
        player.render(g2);
        
        // Счёт
        g2.color = Color.White;
        if (g2.font != null) {
            g2.fontSize = 24;
            g2.drawString('Счёт: $score', 20, 20);
        }
    }
}