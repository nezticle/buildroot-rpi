#define _BUILD_TIME_ __TIME__
#define _BUILD_DATE_ __DATE__

#include <QApplication>
#include <QtGui>

#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
#undef _KEYFILTER_
#else
// Workaround, use setCursor on QWidget instead
#define _MOUSE_
#endif

#if defined ( _KEYFILTER_ )
#include <QWSServer>
#endif

#ifdef _KEYFILTER_
#include <QKeyEvent>
#include <QMouseEvent>
#endif

#ifdef _EVENTMONITORING_ 
#include "eventlistener.h"
#endif

#ifdef _BROWSER_
#include "mlwebkit.h"
#endif

#ifdef _PLAYER_
#include <mlplayer.h>
#endif

#ifdef _KEYFILTER_
class KeyFilter : public QWSServer::KeyboardFilter
{
public:
	bool filter(int unicode, int keycode, int modifiers, bool isPress, bool autoRepeat)
	{
		Q_UNUSED(unicode);

//TODO: understand why a stream of keycode = 0 with alternating repeat occurs 

		if ( keycode != 0 ) // avoid a (default) stream of output
			qDebug() << "METROLOGICAL : key code (Qt::Key) : " << QString("%1").arg(keycode, 0, 16) << " : unicode : " << unicode << " : modifiers (or of Qt::KeyboardModifier's) : "<< modifiers << " : keypress event (true/false) : " << isPress << " : key by autorepeat mechanism (true/false) : " << autoRepeat;

//TODO: check values

		//qDebug () << "METROLOGICAL : application instance :" << QApplication::instance();
		qDebug () << "METROLOGICAL : focus widget : " << QApplication::focusWidget (); 

		switch ( keycode )
		{
			case Qt::Key_Select : // 0x1010000
			{
				QKeyEvent keyevent ( isPress ?  QEvent::KeyPress : QEvent::KeyRelease, Qt::Key_Enter, (Qt::KeyboardModifiers) modifiers, "", autoRepeat, 1 );
				/*qDebug () << "METROLOGICAL : send event : " << */QApplication::sendEvent ( QApplication::focusWidget(), &keyevent ); 
				return true;
			}

			case Qt::Key_Menu : // 0x1000055
        	        {
				QKeyEvent keyevent ( isPress ?  QEvent::KeyPress : QEvent::KeyRelease, Qt::Key_Backspace, (Qt::KeyboardModifiers) modifiers, "", autoRepeat, 1 );
				/*qDebug () << "METROLOGICAL : send event : " << */QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
				return true;
        	        } 

			case Qt::Key_HomePage : // 'Apps', 0x1000090
			{
				QKeyEvent keyevent ( isPress ?  QEvent::KeyPress : QEvent::KeyRelease, Qt::Key_F8, (Qt::KeyboardModifiers) modifiers, "", autoRepeat, 1 );
				/*qDebug () << "METROLOGICAL : send event : " << */QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
				return true;
			}
			case Qt::Key_Favorites : // 'FAV1', 0x1000091
			{
				QKeyEvent keyevent ( isPress ?  QEvent::KeyPress : QEvent::KeyRelease, Qt::Key_F10, (Qt::KeyboardModifiers) modifiers, "", autoRepeat, 1 );
				/*qDebug () << "METROLOGICAL : send event : " << */QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
				return true;
			}
#ifdef _INSPECTOR_
			case Qt::Key_Period : // '.' (period), 0x2e
			{
//TODO: move to the browser context menu event 

				// show / hide webinspector
				MLWebKit* pWebKit = MLWebKit::instance();

				if (pWebKit != NULL && isPress != true )
					pWebKit->inspector();

				return true;
			}

			case Qt::Key_VolumeMute : // 0x1000071
			{	
				QKeyEvent keyevent ( isPress ?  QEvent::KeyPress : QEvent::KeyRelease, Qt::Key_BracketRight, Qt::ControlModifier, "", autoRepeat, 1 );
				qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
				return true;
			}

#endif
			default:;
		}

		//return true; // stop the key from being processed any further
		return false;
	}
};
#endif

int main(int argc, char * argv[])
{
	qDebug () << "METROLOGICAL : browser release (" << _BUILD_DATE_ << _BUILD_TIME_ <<")";

#ifdef _PLAYER_
        Player player(NULL);
#endif

#ifdef _KEYFILTER_
	qDebug () << "METROLOGICAL : add keyboard filter";

	KeyFilter filter;
	QWSServer::addKeyboardFilter(&filter);
#endif

	qDebug () << "METROLOGICAL : start main application";

	QApplication app(argc, argv);

#ifdef _EVENTMONITORING_
        qDebug () << "METROLOGICAL : enable event monitoring";
	EventListener listener(&app);
#endif

#ifdef _BROWSER_
	QUrl url;

        if (argc > 1)
                url = QUrl(argv[1]);
        else
                url = QUrl("");

#ifndef _MOUSE_
        qDebug () << "METROLOGICAL : hide mouse pointer";
        QWSServer::setCursorVisible(false);
#endif

        MLWebKit* browser = new MLWebKit();

#ifdef _PLAYER_
        qDebug () << "METROLOGICAL : add player";
	browser->attach_object(&player);
#endif

	qDebug () << "METROLOGICAL : load and show page";

        browser->load(url);
        browser->show();
#endif

	return app.exec();

#ifdef _BROWSER_
	delete browser;
#endif
}
