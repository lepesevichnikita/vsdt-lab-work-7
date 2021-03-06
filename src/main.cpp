#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "task1.h"
#include "task2.h"
#include "task3.h"
#include "task4.h"

int main(int argc, char *argv[]) {
  QUrl mainQml(QStringLiteral("qrc:///main.qml"));
  QGuiApplication application(argc, argv);

  qmlRegisterType<Task1>("vsdt.lab.work", 1, 0, "Task1");
  qmlRegisterType<Task2>("vsdt.lab.work", 1, 0, "Task2");
  qmlRegisterType<Task3>("vsdt.lab.work", 1, 0, "Task3");
  qmlRegisterType<TrainModel>("vsdt.lab.work", 1, 0, "TrainModel");
  qmlRegisterType<Train>("vsdt.lab.work", 1, 0, "Train");

  QQmlApplicationEngine engine;
  engine.load(mainQml);
  return application.exec();
}
