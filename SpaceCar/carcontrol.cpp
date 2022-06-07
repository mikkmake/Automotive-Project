#include "carcontrol.h"

#include <QDebug>
#include <string>

CarControl::CarControl(QObject *parent)
  : QObject{parent}
{
  // Control starts off as shut down
  m_turnedOn = true;
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

void CarControl::changeYaw(double change)
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_yaw = changeDegree(m_yaw, change);
  qDebug() << "Emitting yawChanged signal";
  emit yawChanged(m_yaw);
}

double CarControl::pitch() const
{
  return m_pitch;
}

void CarControl::changePitch(double change)
{
  qDebug() << Q_FUNC_INFO;
  if (!m_turnedOn) return;
  m_pitch = changeDegree(m_pitch, change);
  emit pitchChanged(m_pitch);
}

double CarControl::changeDegree(double degree, double change)
{
  // Hardcoding 360 degrees should be fine. It's not about to change
  degree += change;
  // Using whiles here to not break behavior if change is something redonculous
  while (degree >= 360.0)
    degree -= 360.0;
  while (degree < 0)
    degree += 360;
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
