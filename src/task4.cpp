#include "task4.h"

TrainModel::TrainModel(QObject *parent) : QAbstractListModel(parent) {}

QHash<int, QByteArray> TrainModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[Qt::UserRole + 1] = "train";
  return roles;
}

int TrainModel::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent)
  return trains_.size();
}

QVariant TrainModel::data(const QModelIndex &index, int role) const {
  Q_UNUSED(role)
  QVariant result;
  if (index.row() < trains_.size())
    result = QVariant::fromValue(trains_[index.row()]);
  return result;
}

qint64 TrainModel::fileSize(QString filePath) {
  QFile f(filePath);
  qint64 result = 0;
  if (f.open(QIODevice::ReadOnly)) {
    result = f.size();
  }
  f.close();
  return result;
}

void TrainModel::append(QObject *object) {
  int i = trains_.size();
  qDebug() << "current trains count" << i;
  qDebug() << (qobject_cast<Train *>(object))->destination();
  beginInsertRows(QModelIndex(), i, i);
  trains_.append(object);
  emit countChanged(trains_.size());
  endInsertRows();
}

void TrainModel::insert(QObject *object, const int &i) {
  beginInsertRows(QModelIndex(), i, i);
  trains_.insert(i, object);
  emit countChanged(trains_.size());
  endInsertRows();
}

QObject *TrainModel::get(const int &i) { return trains_.at(i); }

void TrainModel::clear() {
  int last = trains_.size();
  beginRemoveRows(QModelIndex(), 1, last);
  trains_.clear();
  emit countChanged(trains_.size());
  endResetModel();
}

QQmlListProperty<QObject> TrainModel::content() {
  return QQmlListProperty<QObject>(
      this, nullptr, &TrainModel::trainAppend, &TrainModel::trainCount,
      &TrainModel::trainAt, &TrainModel::trainClear);
}

QUrl TrainModel::outputFilePath() const { return outputFilePath_; }

void TrainModel::setOutputFilePath(const QUrl &outputFilePath) {
  if (outputFilePath == outputFilePath_) return;
  outputFilePath_ = outputFilePath;
  emit outputFilePathChanged();
}

int TrainModel::count() const { return trains_.size(); }

TrainModel *TrainModel::afterTime(const QString &timeString)
{
    qDebug() << "фильтр времени:" << timeString;
    const QString format = "h:m:s";
    TrainModel *result = new TrainModel;
    QTime time = QTime::fromString(timeString, format);
    qDebug() << "qtime время:" << time;
    for (QObject *obj : trains_) {
        Train *train = qobject_cast<Train *>(obj);
        qDebug() << "время отправления " << train->departureTime();
        if (QTime::fromString(train->departureTime(), format) > time) {
            result->append(obj);
        }
    }
    return result;
}

void TrainModel::readTrains() {
  QFile fin(inputFilePath_.toLocalFile());
  clear();
  if (fin.open(QIODevice::ReadWrite)) {
    QDataStream in(&fin);
    while (true) {
      Train *newTrain = new Train(this);
      in >> (*newTrain);
      if (in.status() != QDataStream::Status::Ok) break;
      append(newTrain);
    }
    fin.close();
  }
  foreach (QObject *trainObj, trains_) {
    Train *train = qobject_cast<Train *>(trainObj);
    qDebug() << train->destination();
  }
}

void TrainModel::writeTrains() {
  QFile fout(outputFilePath_.toLocalFile());
  if (fout.open(QIODevice::ReadWrite)) {
    QDataStream out(&fout);
    foreach (QObject *trainObj, trains_) {
      Train *train = qobject_cast<Train *>(trainObj);
      out << (*train);
    }
    fout.flush();
  }
}

QUrl TrainModel::inputFilePath() const { return inputFilePath_; }

void TrainModel::setInputFilePath(const QUrl &inputFilePath) {
  if (inputFilePath_ == inputFilePath) return;
  inputFilePath_ = inputFilePath;
  emit inputFilePathChanged();
}

void TrainModel::trainAppend(QQmlListProperty<QObject> *list, QObject *object) {
  TrainModel *trains = qobject_cast<TrainModel *>(list->object);
  if (trains && object) trains->append(object);
}

int TrainModel::trainCount(QQmlListProperty<QObject> *list) {
  TrainModel *trains = qobject_cast<TrainModel *>(list->object);
  int result = 0;
  if (trains) result = trains->count();
  return result;
}

QObject *TrainModel::trainAt(QQmlListProperty<QObject> *list, int i) {
  TrainModel *trains = qobject_cast<TrainModel *>(list->object);
  QObject *result = nullptr;
  if (trains) result = trains->get(i);
  return result;
}

void TrainModel::trainClear(QQmlListProperty<QObject> *list) {
  TrainModel *trains = qobject_cast<TrainModel *>(list->object);
  if (trains) trains->clear();
}

Train::Train(QObject *parent) : QObject(parent) {}

QString Train::destination() const { return destination_; }

void Train::setDestination(const QString &destination) {
  if (destination == destination_) return;
  destination_ = destination;
  emit destinationChanged(destination);
  emit isValidChanged();
}

QString Train::trainNumber() const { return trainNumber_; }

void Train::setTrainNumber(const QString &trainNumber) {
  if (trainNumber_ == trainNumber) return;
  trainNumber_ = trainNumber;
  emit trainNumberChanged(trainNumber);
  emit isValidChanged();
}

QString Train::departureTime() const { return departureTime_; }

void Train::setDepartureTime(const QString &departureTime) {
  if (departureTime_ == departureTime) return;
  departureTime_ = departureTime;
  emit departureTimeChanged(departureTime);
  emit isValidChanged();
}

void Train::reset() {
  setDestination("");
  setTrainNumber("");
  setDepartureTime("");
}

void Train::setFromObject(QObject *object) {
  Train *train = qobject_cast<Train *>(object);
  if (train) {
    setDestination(train->destination());
    setTrainNumber(train->trainNumber());
    setDepartureTime(train->departureTime());
  }
}

bool Train::destroy(QObject *object) {
  bool result = false;
  Train *destroyable = qobject_cast<Train *>(object);
  if (destroyable) {
    delete destroyable;
    result = false;
  }
  return result;
}

QObject *Train::copyFromObject(QObject *object) {
  Train *result = new Train();
  Train *tempTrain = qobject_cast<Train *>(object);
  result->setDepartureTime(tempTrain->departureTime());
  result->setTrainNumber(tempTrain->trainNumber());
  result->setDestination(tempTrain->destination());
  result->setParent(tempTrain->parent());
  return result;
}

QDataStream &operator<<(QDataStream &ds, const Train &train) {
  for (int i = 0; i < train.metaObject()->propertyCount(); ++i) {
    if (train.metaObject()->property(i).isStored(&train)) {
      ds << train.metaObject()->property(i).read(&train);
    }
  }
  return ds;
}

QDataStream &operator>>(QDataStream &ds, Train &train) {
  QVariant var;
  for (int i = 0; i < train.metaObject()->propertyCount(); ++i) {
    if (train.metaObject()->property(i).isStored(&train)) {
      ds >> var;
      train.metaObject()->property(i).write(&train, var);
    }
  }
  return ds;
}

bool Train::isValid() const {
  bool result = !destination_.isEmpty();
  result &= !trainNumber_.isEmpty();
  result &= !departureTime_.isEmpty();
  return result;
}
