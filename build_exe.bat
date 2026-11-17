@echo off
chcp 65001 >nul
cd /d "%~dp0"
pyinstaller --onefile --name "compiler-frontend" main.py
pyinstaller --onefile --windowed --name "compiler-frontend-gui" gui_tkinter.py
pause
