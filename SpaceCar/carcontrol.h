#ifndef CARCONTROL_H
#define CARCONTROL_H

#include <QtQml/QQmlComponent>
#include <QtQml/QQmlEngine>
#include <QTimer>
#include <cmath>
#include <math.h>
#include <QVector3D>

class CarControl : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool turnedOn READ turnedOn WRITE setTurnedOn NOTIFY turnedOnChanged)
  Q_PROPERTY(double yaw READ yaw WRITE changeYaw NOTIFY yawChanged)
  Q_PROPERTY(double pitch READ pitch WRITE changePitch NOTIFY pitchChanged)
  Q_PROPERTY(double acceleration READ acceleration NOTIFY accelerationChanged)
  Q_PROPERTY(double velocity READ velocity NOTIFY velocityChanged)
  Q_PROPERTY(double velocityYaw READ velocityYaw NOTIFY velocityYawChanged)
  Q_PROPERTY(double velocityPitch READ velocityPitch NOTIFY velocityPitchChanged)
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

  double acceleration() const;
  Q_INVOKABLE void changeAcceleration(double change);

  double velocity() const;

  double velocityYaw() const;

  double velocityPitch() const;

public slots:


signals:
  void turnedOnChanged();

  void yawChanged(double m_yaw);

  void pitchChanged(double m_pitch);

  void accelerationChanged();

  void velocityChanged();

  void velocityYawChanged();

  void velocityPitchChanged();

private:
  bool m_turnedOn;
  double m_yaw;
  double m_pitch;
  QTimer *m_stateTimer;
  QVector3D *m_velocityVector;

  void updateState();
  // Avoid copy paste logic as roll, yaw, and pitch all follow the same rules
  double changeDegree(double degree, double change);
  double m_acceleration;
  double m_velocity;
  double m_velocityYaw;
  double m_velocityPitch;
};

#endif // CARCONTROL_H
