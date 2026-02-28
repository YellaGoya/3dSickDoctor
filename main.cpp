#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QTimer>
#include <QSystemTrayIcon>
#include <QMenu>
#include <QAction>
#include <QStyle>

#ifdef Q_OS_WIN
#include <windows.h>
#include <dwmapi.h>
#pragma comment(lib, "dwmapi.lib")
#endif

int main(int argc, char *argv[])
{
    // 투명 윈도우 지원
    QQuickWindow::setDefaultAlphaBuffer(true);

    QApplication app(argc, argv);
    app.setQuitOnLastWindowClosed(false); // 트레이에서도 유지

    // 시스템 트레이 아이콘
    QSystemTrayIcon trayIcon;
    trayIcon.setIcon(app.style()->standardIcon(QStyle::SP_DialogResetButton));
    trayIcon.setToolTip("3D Sick Doctor");

    // 트레이 메뉴
    QMenu trayMenu;
    QAction* toggleAction = trayMenu.addAction("Hide pattern");
    toggleAction->setCheckable(true);
    toggleAction->setChecked(false);
    QAction* settingsAction = trayMenu.addAction("Settings");
    trayMenu.addSeparator();
    QAction* quitAction = trayMenu.addAction("Exit");
    trayIcon.setContextMenu(&trayMenu);
    trayIcon.show();

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("threeSickDoctor", "Main");

    // 종료 연결
    QObject::connect(quitAction, &QAction::triggered, &app, &QApplication::quit);

    // 토글 상태
    bool dotsVisible = true;

    // Windows에서 강제 최상단 유지
#ifdef Q_OS_WIN
    QTimer topMostTimer;
    QObject::connect(&topMostTimer, &QTimer::timeout, [&engine, &dotsVisible]() {
        if (!dotsVisible) return;
        auto roots = engine.rootObjects();
        for (auto* root : roots) {
            if (QQuickWindow* window = qobject_cast<QQuickWindow*>(root)) {
                HWND hwnd = (HWND)window->winId();
                SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0,
                    SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE | SWP_SHOWWINDOW);
            }
        }
    });
    topMostTimer.start(100);
#endif

    // 토글 연결
    QObject::connect(toggleAction, &QAction::triggered, [&engine, &dotsVisible, toggleAction]() {
        dotsVisible = !dotsVisible;
        toggleAction->setChecked(!dotsVisible);
        auto roots = engine.rootObjects();
        for (auto* root : roots) {
            if (QQuickWindow* window = qobject_cast<QQuickWindow*>(root)) {
                window->setVisible(dotsVisible);
            }
        }
    });

    // 설정창 연결
    QObject::connect(settingsAction, &QAction::triggered, [&engine]() {
        auto roots = engine.rootObjects();
        for (auto* root : roots) {
            QMetaObject::invokeMethod(root, "openSettings");
        }
    });

    return app.exec();
}
