#ifndef CARCONTROL_H
#define CARCONTROL_H

#include <QtQml/QQmlComponent>
#include <QtQml/QQmlEngine>

class CarControl : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool turnedOn READ turnedOn WRITE setTurnedOn NOTIFY turnedOnChanged)
  Q_PROPERTY(double yaw READ yaw NOTIFY yawChanged)
  Q_PROPERTY(double pitch READ pitch NOTIFY pitchChanged)
  QML_NAMED_ELEMENT(CarControl)
  QML_SINGLETON

public:
  explicit CarControl(QObject *parent = nullptr);

  bool turnedOn() const;
  void setTurnedOn(bool newTurnedOn);

  double yaw() const;
  Q_INVOKABLE void decreaseYaw();
  Q_INVOKABLE void increaseYaw();

  double pitch() const;
  Q_INVOKABLE void decreasePitch();
  Q_INVOKABLE void increasePitch();

signals:
  void turnedOnChanged();

  void yawChanged();

  void pitchChanged();

private:
  bool m_turnedOn;
  double m_yaw;
  double m_pitch;

  // Avoid copy paste logic as roll, yaw, and pitch all follow the same rules
  double increaseDegree(double degree);
  double decreaseDegree(double degree);
};

#endif // CARCONTROL_H
