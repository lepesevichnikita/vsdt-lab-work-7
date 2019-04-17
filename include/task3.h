#ifndef VSDT_LAB_WORK_7_INCLUDE_TASK_3_H
#define VSDT_LAB_WORK_7_INCLUDE_TASK_3_H

#include <QObject>
#include <QtMath>
#include <algorithm>

class Task3 : public QObject {
  Q_OBJECT
  Q_PROPERTY(quint64 n READ n WRITE setN NOTIFY nChanged)
  Q_PROPERTY(qreal result READ result NOTIFY resultChanged)
  Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged)

 public:
  enum Mode { IN_CYCLE, BY_FORMULA };
  Q_ENUM(Mode)

  static constexpr auto FORMULA = [](const quint64& n) {
    return n * (4 * qPow(n, 2) - 1) / 3;
  };

  static constexpr auto GENERAL_MEMBER_FORMULA = [](const quint64& n) {
    return qPow((2 * n - 1), 2);
  };

  Task3(QObject* parent = nullptr);

  quint64 n() const;
  void setN(const quint64&);

  qreal result() const;

  Mode mode() const;
  void setMode(const Mode&);

 public slots:
  void toggleMode();

 signals:
  void nChanged();
  void resultChanged();
  void modeChanged();

 private:
  Mode mode_;
  quint64 n_;
  qreal result_;

  void calculateInCicle();
  void calculateByFormula();

 private slots:
  void calculateResult();
};

#endif
