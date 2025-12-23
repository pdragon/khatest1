# testKha0

2D игра, созданная на Haxe с использованием Kha framework.

## Быстрый старт

### Windows:
1. Скачайте репозиторий
2. Запустите `setup.bat`
3. Соберите проект: `khamake html5 --debug`
4. Откройте `build/debug-html5/index.html`

### Linux/Mac:
1. Клонируйте репозиторий
2. Дайте права: `chmod +x setup.sh`
3. Запустите: `./setup.sh`
4. Соберите: `khamake html5 --debug`

## Сборка для других платформ

```bash
# HTML5 (браузер)
khamake html5 --debug

# Windows
khamake windows --debug

# Linux
khamake linux --debug

# Android (требуется Android SDK)
khamake android --debug

Так же внутри проекта должна быть папка содержащая Kha или локальная ссылка ведущая на папку с библиотекой Kha