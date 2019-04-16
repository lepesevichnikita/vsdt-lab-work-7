#ifndef VSDT_LAB_WORK_7_TASK_1_H
#define VSDT_LAB_WORK_7_TASK_1_H

#include <QObject>

class Task1: public QObject {
  Q_OBJECT
  Q_PROPERTY(qreal length
      READ length
      WRITE setLength
      NOTIFY roomVolumeChanged)

  Q_PROPERTY(qreal width
      READ width
      WRITE setWidth
      NOTIFY roomVolumeChanged)

  Q_PROPERTY(qreal height
      READ height
      WRITE setHeight
      NOTIFY roomVolumeChanged)

  Q_PROPERTY(qreal roomVolume
      READ roomVolume
      NOTIFY roomVolumeChanged)

  Q_PROPERTY(qreal oxygenVolume
      READ oxygenVolume
      NOTIFY oxygenVolumeChanged)

  public:
    explicit Task1(QObject * parent = nullptr);

    const static qreal OXYGEN_PERCENT_IN_AIR;

    qreal length();
    qreal width();
    qreal height();
    qreal roomVolume();
    qreal oxygenVolume();

    void setLength(const qreal&);
    void setWidth(const qreal&);
    void setHeight(const qreal&);

signals:
    void roomVolumeChanged();
    void oxygenVolumeChanged();

  private:
    qreal length_, width_, height_;
    qreal roomVolume_;
    qreal oxygenVolume_;

  private slots:
    void calculateRoomVolume();
    void calculateOxygenVolume();
};

#endif
