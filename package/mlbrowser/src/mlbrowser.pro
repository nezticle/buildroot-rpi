contains(QT_MAJOR_VERSION, 5)
{
	QT      += \
	webkitwidgets \
	widgets \
	network 
}

contains(QT_MAJOR_VERSION, 4)
{
	QT += \
	webkit
	network
}

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
	_INSPECTOR_ \
	_KEYFILTER_
#	_PLAYER_ \

#ifdef _PLAYER_
unix
{
	CONFIG += link_pkgconfig
	PKGCONFIG += gstreamer-0.10
}
#endif
