#include "task2.h"

Task2::Task2(QObject* parent) : QObject(parent) {
  QObject::connect(this, SIGNAL(quorterChanged()), this,
                   SLOT(calculateSignOfQuorter()));
}

char Task2::signOfResult() const {
  return signOfResult_;
}

quint8 Task2::quorter() const {
  return quorter_;
}

void Task2::setQuorter(const quint8& quorter) {
  if (quorter == quorter_)
    return;
  quorter_ = quorter;
  emit quorterChanged();
}

void Task2::calculateSignOfQuorter() {
  char result = '-';
  if (quorter_ == 1 || quorter_ == 4)
    result = '+';
  signOfResult_ = result;
  emit signOfResultChanged();
}
