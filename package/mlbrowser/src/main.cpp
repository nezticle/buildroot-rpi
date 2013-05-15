#define _BUILD_TIME_ __TIME__
#define _BUILD_DATE_ __DATE__

#include <QApplication>
#include <QtGui>

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
class KeyFilter : public QObject
{
protected:
	bool eventFilter(QObject* pobject, QEvent* pevent)
	{
		if ( pevent->type() == QEvent::KeyPress )
		{
//TODO: understand why a stream of keycode = 0 with alternating repeat occurs 

			QKeyEvent* pkeyevent = static_cast< QKeyEvent* >( pevent );

			/*
			pkeyevent->count
			pkeyevent->isAutoRepeat
			pkeyevent->key
			pkeyevent->matches
			pkeyevent->modifiers
			pkeyevent->nativeModifiers
			pkeyevent->nativeScanCode
			pkeyevent->nativeVirtualKey
			pkeyevent->text
			*/

			if ( pkeyevent->key() != 0 ) // avoid a (default) stream of output
				qDebug() << "METROLOGICAL : key code (Qt::Key) : " << QString("%1").arg(pkeyevent->key(), 0, 16) << " : unicode : " << pkeyevent->text() << " : modifiers (or of Qt::KeyboardModifier's) : "<< pkeyevent->modifiers() << " : keypress event (true/false) : " << true << " : key by autorepeat mechanism (true/false) : " << pkeyevent->isAutoRepeat();
//TODO: check values

			qDebug () << "METROLOGICAL : application instance :" << QApplication::instance();
			qDebug () << "METROLOGICAL : active window : " << QApplication::activeWindow (); 
			qDebug () << "METROLOGICAL : focus widget : " << QApplication::focusWidget (); 

			switch ( pkeyevent->key() )
			{
				case Qt::Key_Select : // 0x1010000
				{
					QKeyEvent keyevent ( QEvent::KeyPress, Qt::Key_Enter, pkeyevent->modifiers(), "", pkeyevent->isAutoRepeat(), 1 );
					qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent ); 
					return true;
				}

				case Qt::Key_Menu : // 0x1000055
        	        	{
					QKeyEvent keyevent ( QEvent::KeyPress, Qt::Key_Backspace, pkeyevent->modifiers(), "", pkeyevent->isAutoRepeat(), 1 );
					qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
					return true;
        		        } 

				case Qt::Key_HomePage : // 'Apps', 0x1000090
				{
					QKeyEvent keyevent ( QEvent::KeyPress, Qt::Key_F8, pkeyevent->modifiers(), "", pkeyevent->isAutoRepeat(), 1 );
					qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
					return true;
				}
				case Qt::Key_Favorites : // 'FAV1', 0x1000091
				{
					QKeyEvent keyevent ( QEvent::KeyPress, Qt::Key_F10, pkeyevent->modifiers(), "", pkeyevent->isAutoRepeat(), 1 );
					qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
					return true;
				}
#ifdef _INSPECTOR_
				case Qt::Key_Period : // '.' (period), 0x2e
				{
//TODO: move to the browser context menu event 

					// show / hide webinspector
					MLWebKit* pWebKit = MLWebKit::instance();

					if (pWebKit != NULL )
						pWebKit->inspector();

					return true;
				}

				case Qt::Key_VolumeMute : // 0x1000071
				{	
					QKeyEvent keyevent ( QEvent::KeyPress, Qt::Key_BracketRight, Qt::ControlModifier, "", pkeyevent->isAutoRepeat(), 1 );
					qDebug () << "METROLOGICAL : send event : " << QApplication::sendEvent ( QApplication::focusWidget(), &keyevent );
					return true;
				}

#endif
				default:;
			}
		}	

	return QObject::eventFilter(pobject, pevent);
     }
};
#endif

int main(int argc, char * argv[])
{
	qDebug () << "METROLOGICAL : browser release (" << _BUILD_DATE_ << _BUILD_TIME_ <<")";

#ifdef _PLAYER_
        Player player(NULL);
#endif

	qDebug () << "METROLOGICAL : start main application";

	QApplication app(argc, argv);

#ifdef _KEYFILTER_
	qDebug () << "METROLOGICAL : add keyboard filter";

	KeyFilter keyfilter;

	app.installEventFilter ( &keyfilter );
#endif

#ifdef _EVENTMONITORING_
        qDebug () << "METROLOGICAL : enable event monitoring";
	EventListener listener( &app );
#endif

#ifdef _BROWSER_
	QUrl url;

        if (argc > 1)
                url = QUrl(argv[1]);
        else
                url = QUrl("");

#ifndef _MOUSE_
        qDebug () << "METROLOGICAL : hide mouse pointer";
	QApplication::setOverrideCursor ( QCursor ( Qt::BlankCursor ) );
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
