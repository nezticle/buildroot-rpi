TEMPLATE += app

QT += webkitwidgets network widgets

SOURCES = wktst.cpp

TARGET = wktst

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += gstreamer-0.10
}
