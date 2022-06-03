#include "carcontrol.h"

#include <QDebug>
#include <string>

CarControl::CarControl(QObject *parent)
  : QObject{parent}
{
  // Control starts off as shut down
  m_turnedOn = false;
  // Orientation starts at zeros
  m_yaw = 0.0;
  m_pitch = 0.0;
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
  m_yaw = decreaseDegree(m_yaw);
  qDebug() << Q_FUNC_INFO;
  emit yawChanged();
}

void CarControl::increaseYaw()
{
  m_yaw = increaseDegree(m_yaw);
  qDebug() << Q_FUNC_INFO;
  emit yawChanged();
}


double CarControl::pitch() const
{
  return m_pitch;
}

void CarControl::decreasePitch()
{
  m_pitch = decreaseDegree(m_pitch);
  qDebug() << Q_FUNC_INFO;
  emit pitchChanged();
}

void CarControl::increasePitch()
{
  m_pitch = increaseDegree(m_pitch);
  qDebug() << Q_FUNC_INFO;
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
