#ifndef VSDT_LAB_WORK_7_INCLUDE_TASK_4_H
#define VSDT_LAB_WORK_7_INCLUDE_TASK_4_H

#include <QAbstractListModel>
#include <QDataStream>
#include <QDebug>
#include <QFile>
#include <QMetaProperty>
#include <QQmlListProperty>
#include <QUrl>
#include <fstream>
#include <vector>

#include <QTime>

class Train : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString destination READ destination WRITE setDestination NOTIFY
                 destinationChanged)
  Q_PROPERTY(QString trainNumber READ trainNumber WRITE setTrainNumber NOTIFY
                 trainNumberChanged)
  Q_PROPERTY(QString departureTime READ departureTime WRITE setDepartureTime
                 NOTIFY departureTimeChanged)

  Q_PROPERTY(bool isValid READ isValid NOTIFY isValidChanged)
 public:
  explicit Train(QObject* parent = nullptr);

  QString destination() const;

  QString trainNumber() const;

  QString departureTime() const;

  Q_INVOKABLE void reset();
  Q_INVOKABLE void setFromObject(QObject*);

  Q_INVOKABLE static bool destroy(QObject*);
  Q_INVOKABLE static QObject* copyFromObject(QObject*);

  bool isValid() const;

 public slots:
  void setDestination(const QString& destination);
  void setTrainNumber(const QString& trainNumber);
  void setDepartureTime(const QString& departureTime);

 signals:
  void destinationChanged(QString);
  void trainNumberChanged(QString);
  void departureTimeChanged(QString);

  void isValidChanged();

 private:
  QString destination_, trainNumber_, departureTime_;
  QString m_departureTime;

 private slots:
};

QDataStream& operator<<(QDataStream&, const Train&);
QDataStream& operator>>(QDataStream&, Train&);

struct TrainStruct {
  QString destination, trainNumber, departureTime;
  Train* toTrain() {
    Train* result = new Train();
    result->setDestination(destination);
    result->setTrainNumber(trainNumber);
    result->setDepartureTime(departureTime);
    return result;
  }
  static TrainStruct fromTrain(const Train& train) {
    TrainStruct result;
    result.destination = train.destination();
    result.trainNumber = train.trainNumber();
    result.departureTime = train.departureTime();
    return result;
  }
  static TrainStruct fromTrain(const Train* train) {
    TrainStruct result = fromTrain(*train);
    return result;
  }
};

class TrainModel : public QAbstractListModel {
  Q_OBJECT
  Q_PROPERTY(QUrl inputFilePath READ inputFilePath WRITE setInputFilePath NOTIFY
                 inputFilePathChanged)
  Q_PROPERTY(QUrl outputFilePath READ outputFilePath WRITE setOutputFilePath
                 NOTIFY outputFilePathChanged)
  Q_PROPERTY(int count READ count NOTIFY countChanged)
  Q_PROPERTY(QQmlListProperty<QObject> content READ content)

  Q_CLASSINFO("DefaultProperty", "content")
 public:
  explicit TrainModel(QObject* parent = nullptr);

  virtual QHash<int, QByteArray> roleNames() const;
  virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;
  virtual QVariant data(const QModelIndex& index,
                        int role = Qt::DisplayRole) const;

  Q_INVOKABLE static qint64 fileSize(QString filePath);
  Q_INVOKABLE void append(QObject*);
  Q_INVOKABLE void insert(QObject*, const int&);
  Q_INVOKABLE QObject* get(const int&);
  Q_INVOKABLE void clear();
  QQmlListProperty<QObject> content();

  QUrl inputFilePath() const;
  QUrl outputFilePath() const;
  int count() const;
  Q_INVOKABLE TrainModel *afterTime(const QString &);

  public slots:
  void readTrains();
  void writeTrains();

  void setOutputFilePath(const QUrl& outputFilePath);
  void setInputFilePath(const QUrl&);

  static void trainAppend(QQmlListProperty<QObject>*, QObject*);
  static int trainCount(QQmlListProperty<QObject>*);
  static QObject* trainAt(QQmlListProperty<QObject>*, int);
  static void trainClear(QQmlListProperty<QObject>*);

 signals:
  void inputFilePathChanged();
  void outputFilePathChanged();
  void countChanged(int count);

 private:
  QList<QObject*> trains_;
  QUrl inputFilePath_;
  QUrl outputFilePath_;
};

#endif
