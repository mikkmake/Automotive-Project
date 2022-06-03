#ifndef CARCONTROL_H
#define CARCONTROL_H

#include <QtQml/QQmlComponent>
#include <QtQml/QQmlEngine>

class CarControl : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool turnedOn READ turnedOn WRITE setTurnedOn NOTIFY turnedOnChanged)
  QML_NAMED_ELEMENT(CarControl)
  QML_SINGLETON

public:
  explicit CarControl(QObject *parent = nullptr);

  bool turnedOn() const;
  void setTurnedOn(bool newTurnedOn);

signals:
  void turnedOnChanged();

private:
  bool m_turnedOn;
};

#endif // CARCONTROL_H
