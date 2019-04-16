#ifndef VSDT_LAB_WORK_7_INCLUDE_TASK_2_H
#define VSDT_LAB_WORK_7_INCLUDE_TASK_2_H

#include <QObject>

class Task2 : public QObject {
  Q_OBJECT
  Q_PROPERTY(quint8 quorter READ quorter WRITE setQuorter NOTIFY quorterChanged)
  Q_PROPERTY(char signOfResult READ signOfResult NOTIFY signOfResultChanged)
 public:
  Task2(QObject* parent = nullptr);

  char signOfResult() const;
  quint8 quorter() const;
  void setQuorter(const quint8&);

 signals:
  void signOfResultChanged();
  void quorterChanged();

 private:
  quint8 quorter_;
  char signOfResult_;

 private slots:
  void calculateSignOfQuorter();
};

#endif
