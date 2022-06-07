#ifndef CARCONTROL_H
#define CARCONTROL_H

#include <QtQml/QQmlComponent>
#include <QtQml/QQmlEngine>

class CarControl : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool turnedOn READ turnedOn WRITE setTurnedOn NOTIFY turnedOnChanged)
  Q_PROPERTY(double yaw READ yaw WRITE changeYaw NOTIFY yawChanged)
  Q_PROPERTY(double pitch READ pitch WRITE changePitch NOTIFY pitchChanged)
  Q_PROPERTY(double velocity READ velocity NOTIFY velocityChanged)
  QML_NAMED_ELEMENT(CarControl)
  QML_SINGLETON

public:
  explicit CarControl(QObject *parent = nullptr);

  bool turnedOn() const;
  void setTurnedOn(bool newTurnedOn);

  double yaw() const;
  Q_INVOKABLE void changeYaw(double increment);

  double pitch() const;
  Q_INVOKABLE void changePitch(double change);

  double velocity() const;
  Q_INVOKABLE void increaseVelocity();

signals:
  void turnedOnChanged();

  void yawChanged(double m_yaw);

  void pitchChanged(double m_pitch);

  void velocityChanged();

private:
  bool m_turnedOn;
  double m_yaw;
  double m_pitch;

  // Avoid copy paste logic as roll, yaw, and pitch all follow the same rules
  double changeDegree(double degree, double change);
  double m_velocity;
};

#endif // CARCONTROL_H
