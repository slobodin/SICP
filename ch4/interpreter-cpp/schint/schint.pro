TEMPLATE = app
CONFIG += console
CONFIG -= qt

QMAKE_CXXFLAGS += -std=gnu++0x

SOURCES += main.cpp \
    environment.cpp \
    expression.cpp \
    schemelist.cpp

HEADERS += \
    environment.h \
    expression.h \
    schemelist.h \
    utils.h

