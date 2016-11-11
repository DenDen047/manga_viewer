<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>MangaViewer</title>

    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <link rel="stylesheet" href="{{get_url('views_static', path='./files/manga_viewer.css')}}" type="text/css" media="all">
</head>


<body>
    <div class="page">
        <img class="bg" src="{{get_url('home_static', path=left_page)}}" alt="" />
    </div>
    <div class="page">
        <img class="bg" src="{{get_url('home_static', path=right_page)}}" alt="" />
    </div>
    <br clear="both">
</body>
</html>