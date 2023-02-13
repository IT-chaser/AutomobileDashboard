QT += network
QT += quick virtualkeyboard

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        engineconfiguration.cpp \
        main.cpp

RESOURCES += qml.qrc

TRANSLATIONS += \
    AutomobileDashboard1_en_US.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = D:\Qt\5.15.2\mingw81_64\include\QtNetwork

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = D:\Qt\5.15.2\mingw81_64\include\QtNetwork

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    engineconfiguration.h

#win32:CONFIG(release, debug|release): LIBS += -LD:/Qt/5.15.2/mingw81_64/lib/ -lQt5Network
#else:win32:CONFIG(debug, debug|release): LIBS += -LD:/Qt/5.15.2/mingw81_64/lib/ -lQt5Networkd
#else:unix: LIBS += -LD:/Qt/5.15.2/mingw81_64/lib/ -lQt5Network

#INCLUDEPATH += D:/Qt/5.15.2/mingw81_64/include/QtNetwork
#DEPENDPATH += D:/Qt/5.15.2/mingw81_64/include/QtNetwork

