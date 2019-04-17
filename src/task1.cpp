#include "task1.h"

const qreal Task1::OXYGEN_PERCENT_IN_AIR = 21;

Task1::Task1(QObject* parent)
    : QObject(parent),
      width_(0.0),
      height_(0.0),
      length_(0.0),
      roomVolume_(0.0),
      oxygenVolume_(0.0) {
  QObject::connect(this, SIGNAL(roomVolumeChanged()), this,
                   SLOT(calculateOxygenVolume()));
}

qreal Task1::length() { return length_; }

qreal Task1::width() { return width_; }

qreal Task1::height() { return height_; }

qreal Task1::roomVolume() {
  calculateRoomVolume();
  return roomVolume_;
}

qreal Task1::oxygenVolume() { return oxygenVolume_; }

void Task1::setLength(const qreal& length) {
  if (length_ == length) return;
  length_ = length;
  emit roomVolumeChanged();
}

void Task1::setWidth(const qreal& width) {
  if (width_ == width) return;
  width_ = width;
  emit roomVolumeChanged();
}

void Task1::setHeight(const qreal& height) {
  if (height_ == height) return;
  height_ = height;
  emit roomVolumeChanged();
}

void Task1::calculateRoomVolume() {
  if (length_ != 0 && width_ != 0 && height_ != 0)
    roomVolume_ = length_ * width_ * height_;
}

void Task1::calculateOxygenVolume() {
  oxygenVolume_ = roomVolume_ * OXYGEN_PERCENT_IN_AIR / 100;
  emit oxygenVolumeChanged();
}
