#include "carcontrol.h"

#include <QDebug>
#include <string>

CarControl::CarControl(QObject *parent)
  : QObject{parent}
{
  // Control starts off as shut down
  m_turnedOn = true;
  // Orientation and acceleration starts at zeros
  m_yaw = 0.0;
  m_pitch = 0.0;
  m_acceleration = 0.0;
  m_velocity = 0.0;
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
  qDebug() << Q_FUNC_INFO;
  emit turnedOnChanged();
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
  if (m_acceleration + change >= 5.0) {
    return;
  } else if (m_acceleration + change < 0) {
    m_acceleration = 0.0;
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
      qDebug() << newVector.x() << " " << newVector.y() << " " << newVector.z();
      qDebug() << m_velocityVector->x() << " " << m_velocityVector->y() << " " << m_velocityVector->z();
      m_velocity = m_velocityVector->length();
      emit velocityChanged();
    }
}

double CarControl::velocity() const
{
  return m_velocity;
}
