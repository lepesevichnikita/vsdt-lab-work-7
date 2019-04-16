#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

#include "task1.h"
#include "task2.h"

int main(int argc, char *argv[])
{
  QUrl mainQml(QStringLiteral("qrc:///main.qml"));
  QGuiApplication application(argc, argv);

  qmlRegisterType<Task1>("vsdt.lab.work", 1, 0, "Task1");
  qmlRegisterType<Task2>("vsdt.lab.work", 1, 0, "Task2");

  QQmlApplicationEngine engine;
  engine.load(mainQml);
  return application.exec();
}
