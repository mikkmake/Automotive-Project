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
  Q_PROPERTY(double velocity READ velocity NOTIFY velocityChanged)
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

  double velocity() const;
  Q_INVOKABLE void increaseVelocity();

signals:
  void turnedOnChanged();

  void yawChanged();

  void pitchChanged();

  void velocityChanged();

private:
  bool m_turnedOn;
  double m_yaw;
  double m_pitch;

  // Avoid copy paste logic as roll, yaw, and pitch all follow the same rules
  double increaseDegree(double degree);
  double decreaseDegree(double degree);
  double m_velocity;
};

#endif // CARCONTROL_H
