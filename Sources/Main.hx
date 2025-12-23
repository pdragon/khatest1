package;

import kha.System;
import kha.Assets;

import Game;

class Main {
    public static function main() {
        System.start({title: "Penetrator", width: 800, height: 600}, function(_) {
            // Загружаем все ресурсы, включая шрифт
            Assets.loadEverything(function() {
                // Получаем загруженный шрифт по имени файла (без расширения)
                var gameFont = Assets.fonts.Efourpro;
                trace("Шрифт загружен:", gameFont != null);
                new Game(gameFont); // Передаём шрифт в игру
            });
        });
    }
}