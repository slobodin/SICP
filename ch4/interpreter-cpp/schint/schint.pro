TEMPLATE = app
CONFIG += console
CONFIG -= qt

QMAKE_CXXFLAGS += -std=gnu++0x

SOURCES += main.cpp \
    eval.cpp \
    environment.cpp \
    expression.cpp

HEADERS += \
    eval.h \
    environment.h \
    expression.h

