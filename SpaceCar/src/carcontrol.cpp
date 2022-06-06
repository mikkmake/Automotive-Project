#include "include/carcontrol.h"

#include <QDebug>
#include <string>

CarControl::CarControl(QObject *parent)
  : QObject{parent}
{
  // Control starts off as shut down
  m_turnedOn = false;
  // Orientation and velocity starts at zeros
  m_yaw = 0.0;
  m_pitch = 0.0;
  m_velocity = 0.0;
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
  qDebug() << "flipped turnedOn";
  emit turnedOnChanged();
}

double CarControl::yaw() const
{
  return m_yaw;
}

void CarControl::decreaseYaw()
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_yaw = decreaseDegree(m_yaw);
  emit yawChanged();
}

void CarControl::increaseYaw()
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_yaw = increaseDegree(m_yaw);
  emit yawChanged();
}


double CarControl::pitch() const
{
  return m_pitch;
}

void CarControl::decreasePitch()
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_pitch = decreaseDegree(m_pitch);
  emit pitchChanged();
}

void CarControl::increasePitch()
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_pitch = increaseDegree(m_pitch);
  emit pitchChanged();
}

double CarControl::increaseDegree(double degree)
{
  // Temporary hardcoding
  degree += 10.0;
  // Hardcoding 360 degrees should be fine. It's not about to change
  if (degree >= 360.0)
    degree -= 360.0;

  return degree;
}

// Reverse logic to the above method
double CarControl::decreaseDegree(double degree)
{
  degree -= 10;
  if (degree < 0.0)
    degree += 360.0;
  return degree;
}

double CarControl::velocity() const
{
  return m_velocity;
}

void CarControl::increaseVelocity()
{
  // Hard-code for now
  m_velocity += 10;
}
