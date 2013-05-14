#include <QApplication>
#include <QGraphicsScene>
#include <QGraphicsView>
#include <QGraphicsWebView>
#include <QGLWidget>
#include <QWebSettings>
#include <QUrl>

int
main(int argc, char **argv)
{
  QApplication app(argc, argv);
  QUrl url;
  const int width = 1920;
  const int height = 1080;

  if (argc > 1)
    url = QUrl(argv[1]);
  else
    url = QUrl("");

  QGraphicsScene scene;

  QGraphicsView view(&scene);
  QGLWidget viewport(&view);

  view.setViewport(&viewport);  
  view.setFrameShape(QFrame::NoFrame);
  view.setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
  view.setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);

  QGraphicsWebView webview;
  webview.resize(width, height);
  webview.load(url);

  scene.addItem(&webview);
  view.resize(width, height);
  view.show();

  webview.setFocus();

  return app.exec();
}
