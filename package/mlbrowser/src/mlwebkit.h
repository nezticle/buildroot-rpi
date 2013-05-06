#ifndef MLWEBKIT_H
#define MLWEBKIT_H

#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsWebView>
#include <QWebPage>
#include <QWebFrame>

#ifdef _INSPECTOR_
#include <QWebInspector>
#endif

class MLWebKit
{
public:
	MLWebKit();
	~MLWebKit();

	void load(QUrl url);
	void show();
	void hide();

#ifdef _PLAYER_
	void attach_object(QObject* pObject);
#endif

#ifdef _INSPECTOR_
	static MLWebKit* instance();
	void inspector();
#endif

private:
	QGraphicsView*		pView;
	QGraphicsScene*		pScene;
	QGraphicsWebView*	pWebview;
	QWebPage*		pPage;
	QWebFrame*		pFrame;

	QObject*		pObject;

#ifdef _INSPECTOR_
	static MLWebKit*	pWebKit;
	QWebInspector*		pInspector;
#endif
};
#endif
