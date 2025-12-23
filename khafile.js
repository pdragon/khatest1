let project = new Project('PenetratorLikeGame');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');

// Настройки для HTML5
// project.addParameter('--html-title', 'Kha|Test0!');
// project.addParameter('--html-width', '1024');
// project.addParameter('--html-height', '768');
project.addParameter('-D KHA_PATH=Kha');

// Дополнительные библиотеки (если нужны)
// project.addParameter('-lib', 'название_библиотеки');
resolve(project);