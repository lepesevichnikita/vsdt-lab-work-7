#include "task3.h"

Task3::Task3(QObject* parent)
    : QObject(parent), n_(1), result_(0.0), mode_(BY_FORMULA) {
  QObject::connect(this, SIGNAL(nChanged()), this, SLOT(calculateResult()));
  QObject::connect(this, SIGNAL(modeChanged()), this, SLOT(calculateResult()));
}

quint64 Task3::n() const { return n_; }

void Task3::setN(const quint64& n) {
  if (n_ == n) return;
  n_ = n;
  emit nChanged();
}

qreal Task3::result() const { return result_; }

Task3::Mode Task3::mode() const { return mode_; }

void Task3::setMode(const Task3::Mode& mode) {
  if (mode_ == mode) return;
  mode_ = mode;
  emit modeChanged();
}

void Task3::toggleMode() {
  mode_ = mode_ == BY_FORMULA ? IN_CYCLE : BY_FORMULA;
  emit modeChanged();
}

void Task3::calculateInCicle() {
  result_ = 0.0;
  for (quint64 i = 1; i <= n_; i++) {
    result_ += GENERAL_MEMBER_FORMULA(i);
  }
}

void Task3::calculateByFormula() { result_ = FORMULA(n_); }

void Task3::calculateResult() {
  switch (mode_) {
    case BY_FORMULA:
      calculateByFormula();
      break;
    case IN_CYCLE:
      calculateInCicle();
      break;
  }
  emit resultChanged();
}
