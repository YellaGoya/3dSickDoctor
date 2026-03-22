#ifndef CONFIGMANAGER_H
#define CONFIGMANAGER_H

#include <QObject>
#include <QVariantMap>

class ConfigManager : public QObject
{
    Q_OBJECT
public:
    explicit ConfigManager(QObject *parent = nullptr);

    Q_INVOKABLE bool save(const QVariantMap& configMap);
    Q_INVOKABLE QVariantMap load();
};

#endif // CONFIGMANAGER_H
