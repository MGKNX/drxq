@echo off
echo.
echo ===============================================
echo       DRXQVLN LAUNCHER - AUTO BUILD
echo ===============================================
echo.

echo [ДИАГНОСТИКА] Текущая папка: %CD%
echo [ДИАГНОСТИКА] Проверяем файлы...
if not exist "package.json" (
    echo ❌ ОШИБКА: Файл package.json не найден!
    echo Убедитесь что вы запускаете батник в папке с проектом.
    echo.
    pause
    exit /b 1
)
echo ✅ package.json найден

echo.
echo [1/4] Проверяем Node.js...
node --version
if %errorlevel% neq 0 (
    echo ❌ ОШИБКА: Node.js не установлен или недоступен!
    echo.
    echo ВОЗМОЖНЫЕ ПРИЧИНЫ:
    echo - Node.js не установлен (скачайте с https://nodejs.org/)
    echo - Нужно перезапустить компьютер после установки Node.js
    echo - В компьютерном клубе заблокирован доступ к консольным командам
    echo.
    echo АЛЬТЕРНАТИВНЫЕ РЕШЕНИЯ:
    echo 1. Попросите администратора разблокировать консоль
    echo 2. Используйте portable версию Node.js
    echo 3. Используйте веб-версию лаунчера (создам отдельно)
    echo.
    pause
    exit /b 1
)
echo ✅ Node.js версия: 
node --version

echo.
echo [ДИАГНОСТИКА] Проверяем npm...
npm --version
if %errorlevel% neq 0 (
    echo ❌ npm недоступен!
    pause
    exit /b 1
)
echo ✅ npm версия:
npm --version

echo.
echo [2/4] Устанавливаем зависимости...
echo Это может занять несколько минут...
npm install
if %errorlevel% neq 0 (
    echo.
    echo ❌ ОШИБКА УСТАНОВКИ ЗАВИСИМОСТЕЙ!
    echo.
    echo ВОЗМОЖНЫЕ ПРИЧИНЫ:
    echo - Нет доступа к интернету
    echo - Заблокирован доступ к npm registry
    echo - Недостаточно прав на запись в папку
    echo - Антивирус блокирует установку
    echo.
    echo ПОПРОБУЙТЕ:
    echo npm cache clean --force
    echo npm install --registry https://registry.npm.taobao.org
    echo.
    pause
    exit /b 1
)
echo ✅ Зависимости установлены!

echo.
echo [3/4] Собираем React приложение...
npm run react-build
if %errorlevel% neq 0 (
    echo.
    echo ❌ ОШИБКА СБОРКИ REACT!
    echo Посмотрите ошибки выше для деталей.
    echo.
    pause
    exit /b 1
)
echo ✅ React собран!

echo.
echo [4/4] Создаем .exe файл...
npm run dist
if %errorlevel% neq 0 (
    echo.
    echo ❌ ОШИБКА СОЗДАНИЯ .EXE!
    echo Посмотрите ошибки выше для деталей.
    echo.
    pause
    exit /b 1
)

echo.
echo ===============================================
echo            ✅ ГОТОВО! ✅
echo ===============================================
echo.
echo 📁 Готовый .exe файл находится в папке: release/
echo 📦 Установщик: DRXQVLN LAUNCHER Setup.exe
echo 🚀 Portable: release/win-unpacked/DRXQVLN LAUNCHER.exe
echo.
pause
if exist "release" explorer release 