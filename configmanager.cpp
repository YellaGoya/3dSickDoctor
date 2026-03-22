#include "configmanager.h"

#include <QDir>
#include <QStandardPaths>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

ConfigManager::ConfigManager(QObject *parent) : QObject(parent) {}

bool ConfigManager::save(const QVariantMap& configMap)
{
    QString docsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QDir dir(docsPath);

    if (!dir.exists("3DSickDoctor")) {
        dir.mkpath("3DSickDoctor");
    }

    QFile file(dir.filePath("3DSickDoctor/configs.json"));
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        return false;
    }

    QJsonObject jsonObj = QJsonObject::fromVariantMap(configMap);
    file.write(QJsonDocument(jsonObj).toJson());
    return true;
}

QVariantMap ConfigManager::load()
{
    QString docsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QFile file(QDir(docsPath).filePath("3DSickDoctor/configs.json"));

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return QVariantMap();
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    return doc.object().toVariantMap();
}
