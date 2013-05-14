contains(QT_MAJOR_VERSION, 5) {
	QT += \
		webkitwidgets \
		widgets \
		network 
}

contains(QT_MAJOR_VERSION, 4) {
	QT += \
		webkit \
		network
}

TARGET = mlbrowser
HEADERS = mlwebkit.h

SOURCES = \
	mlwebkit.cpp \
	main.cpp

contains(DEFINES, _PLAYER_) {
	HEADERS += mlplayer.h
	SOURCES += mlplayer.cpp

	unix {
		CONFIG += link_pkgconfig
		PKGCONFIG += gstreamer-0.10
	}
}
