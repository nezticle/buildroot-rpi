QT      += \
	webkit \
	network 

TARGET	= mlbrowser

HEADERS = \
	 mlwebkit.h \
	 mlplayer.h 

SOURCES = \
	mlwebkit.cpp \
	mlplayer.cpp \
	main.cpp

DEFINES += \
	_BROWSER_ \
	_KEYFILTER_ \
	_PLAYER_ \
	_INSPECTOR_

QMAKE_CXXFLAGS += \
	-I${STAGING_DIR}/usr/include/gstreamer-0.10/ \
	-I${STAGING_DIR}/usr/include/glib-2.0/ \
	-I${STAGING_DIR}/usr/lib/glib-2.0/include/

QMAKE_LFLAGS += \
	-L${TARGET_LDFLAGS}/usr/lib/ -lgstreamer-0.10
