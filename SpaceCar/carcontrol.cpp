#include "carcontrol.h"

#include <QDebug>
#include <string>

CarControl::CarControl(QObject *parent)
  : QObject{parent}
{
  // Control starts off as shut down
  m_turnedOn = false;
  // Orientation and acceleration starts at zeros
  m_yaw = m_pitch = m_acceleration = m_velocity = m_velocityYaw
      = m_velocityPitch = 0.0;
  m_velocityVector = new QVector3D(0.0, 0.0, 0.0);
  // Control state by timer
  m_stateTimer = new QTimer;
  m_stateTimer->setInterval(50);
  connect(m_stateTimer, &QTimer::timeout, this, &CarControl::updateState);
  m_stateTimer->start();
}

bool CarControl::turnedOn() const
{
  return m_turnedOn;
}

void CarControl::setTurnedOn(bool newTurnedOn)
{
  if (m_turnedOn == newTurnedOn)
    return;
  m_turnedOn = newTurnedOn;
  emit turnedOnChanged();
  if (!m_turnedOn) {
      m_acceleration = 0.0;
      emit accelerationChanged();
    }
}

double CarControl::yaw() const
{
  return m_yaw;
}

void CarControl::changeYaw(double change)
{
  if (!m_turnedOn) return;
  m_yaw = changeDegree(m_yaw, change);
  emit yawChanged(change);
}

double CarControl::pitch() const
{
  return m_pitch;
}

void CarControl::changePitch(double change)
{
  if (!m_turnedOn) return;
  m_pitch = changeDegree(m_pitch, change);
  emit pitchChanged(change);
}

double CarControl::changeDegree(double degree, double change)
{
  // Hardcoding 360 degrees should be fine. It's not about to change
  degree += change;
  // Using whiles here to not break behavior if change is something redonculous
  while (degree >= 180.0)
    degree -= 360.0;
  while (degree < -180.0)
    degree += 360.0;
  return degree;
}

double CarControl::acceleration() const
{
  return m_acceleration;
}

void CarControl::changeAcceleration(double change)
{
  if (!m_turnedOn) return;
  if (m_acceleration + change >= 5.0) {
    return;
  } else if (m_acceleration + change < 0) {
    m_acceleration = 0.0;
    emit accelerationChanged();
    return;
  }
  m_acceleration += change;
  emit accelerationChanged();
}

// Continuously update speed
void CarControl::updateState()
{
  if (m_acceleration > 0.0) {
      double newVelocity = 9.81 * m_acceleration * 0.05;
      // Create new vector to add to old vector
      QVector3D newVector = QVector3D(
        newVelocity * cos(m_yaw * M_PI /180.0) * cos(m_pitch * M_PI /180.0),
        newVelocity * sin(m_yaw * M_PI / 180.0) * cos(m_pitch * M_PI / 180.0),
        newVelocity * sin(m_pitch * M_PI / 180.0)

      );
      *m_velocityVector += newVector;
      m_velocity = m_velocityVector->length();
      emit velocityChanged();
      // Figure out where velocity is pointing
      newVector = m_velocityVector->normalized();
      m_velocityPitch = asin(newVector.z()) *180/M_PI;
      m_velocityYaw = atan2(newVector.y(), newVector.x()) *180/M_PI;
      emit velocityPitchChanged();
      emit velocityYawChanged();
    }
}

double CarControl::velocity() const
{
  return m_velocity;
}

double CarControl::velocityYaw() const
{
  return m_velocityYaw;
}

double CarControl::velocityPitch() const
{
  return m_velocityPitch;
}
