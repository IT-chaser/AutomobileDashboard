#ifndef ENGINECONFIGURATION_H
#define ENGINECONFIGURATION_H

#include <QObject>
#include <QtNetwork>
#include <QUdpSocket>


class EngineConfiguration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int engineRPM READ engineRPM WRITE setEngineRPM NOTIFY engineRPMChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(double maxEngineRPM READ maxEngineRPM WRITE setMaxEngineRPM NOTIFY maxEngineRPMChanged)
    Q_PROPERTY(int curGear READ curGear WRITE setCurGear NOTIFY curGearChanged)
    Q_PROPERTY(int fuelLevel READ fuelLevel WRITE setFuelLevel NOTIFY fuelLevelChanged)
    Q_PROPERTY(int engineTemp READ engineTemp WRITE setEngineTemp NOTIFY engineTempChanged)
    Q_PROPERTY(QString distance READ distance WRITE setDistance NOTIFY distanceChanged)

public:
    EngineConfiguration();

    void setEngineRPM(int temp);
    int engineRPM() const;

    void setSpeed(int temp);
    int speed() const;

    void setCurGear(int temp);
    int curGear() const;

    void setFuelLevel(int temp);
    int fuelLevel() const;

    void setEngineTemp(int temp);
    int engineTemp() const;

    void setMaxEngineRPM(int temp);
    double maxEngineRPM() const;

    QString distance() const {
        return m_distanceStr;
    }

    void setDistance(QString temp) {
        m_distanceStr = temp;
    }

    void init();

    Q_INVOKABLE double getEngineProperty(QString param);
    Q_INVOKABLE void accelerate(bool acc);
    // udpSocket function for getting click notification from accelerate and decelerate buttons
    Q_INVOKABLE void speedStatus(bool spd);
    Q_INVOKABLE void applyBrake(bool breaks);
    Q_INVOKABLE void updateEngineProp(QString param, double value);

public slots:
    void calculateSpeed();
    void calculateDistance();
    void generateEvent();
    // udpSocket slot for reading datagram
    void readyRead();

signals:
    void engineRPMChanged();
    void speedChanged();
    void maxEngineRPMChanged();
    void curGearChanged();
    void fuelLevelChanged();
    void engineTempChanged();
    void distanceChanged();

    void eventGenerated(QString event);

private:

    void saveDistance(double distance);
    int m_engineRPM;
    int m_speed;
    int m_curGear;
    int m_upShiftRPM;

    int m_fuelLevel;
    int m_engineTemp;

    double m_maxEngineRPM;
    double m_tyreDiameter;
    QVector<double> m_gearRatios;
    QVector<int> m_gearSpeeds;
    double m_driveRatio;
    double m_distance;
    QString m_distanceStr;

    bool isAccelerating;
    bool isBraking;
    QUdpSocket *udpSocket;
};

#endif // ENGINECONFIGURATION_H
