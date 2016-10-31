<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>MangaViewer</title>

    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <link rel="stylesheet" href="{{get_url('views_static', path='./files/styles.css')}}" type="text/css" media="all">
    <script async="" src="{{get_url('views_static', path='./files/analytics.js')}}"></script>
    <script src="{{get_url('views_static', path='./files/jquery.min.js')}}"></script>
    <script type="text/javascript" src="{{get_url('views_static', path='./files/smartRollover.js')}}"></script>
    <script type="text/javascript" src="{{get_url('views_static', path='./files/jquery.page-scroller.js')}}"></script>
    <script type="text/javascript" src="{{get_url('views_static', path='./files/jquery.lazyload.min.js')}}"></script>
    <script>
        var scrolltotop={
        	//startline: Integer. Number of pixels from top of doc scrollbar is scrolled before showing control
        	//scrollto: Keyword (Integer, or "Scroll_to_Element_ID"). How far to scroll document up when control is clicked on (0=top).
        	setting: {startline:100, scrollto: 0, scrollduration:1000, fadeduration:[500, 100]},
        	controlHTML: '<img src="{{get_url('views_static', path='./files/images/b_top.png')}}" style="width:70px; height:70px" />', //HTML for control, which is auto wrapped in DIV w/ ID="topcontrol"
        	controlattrs: {offsetx:10, offsety:190}, //offset of control relative to right/ bottom of window corner
        	anchorkeyword: '#top', //Enter href value of HTML anchors on the page that should also act as "Scroll Up" links
        
        	state: {isvisible:false, shouldvisible:false},
        
        	scrollup:function(){
        		if (!this.cssfixedsupport) //if control is positioned using JavaScript
        			this.$control.css({opacity:0}) //hide control immediately after clicking it
        		var dest=isNaN(this.setting.scrollto)? this.setting.scrollto : parseInt(this.setting.scrollto)
        		if (typeof dest=="string" && jQuery('#'+dest).length==1) //check element set by string exists
        			dest=jQuery('#'+dest).offset().top
        		else
        			dest=0
        		this.$body.animate({scrollTop: dest}, this.setting.scrollduration);
        	},
        
        	keepfixed:function(){
        		var $window=jQuery(window)
        		var controlx=$window.scrollLeft() + $window.width() - this.$control.width() - this.controlattrs.offsetx
        		var controly=$window.scrollTop() + $window.height() - this.$control.height() - this.controlattrs.offsety
        		this.$control.css({left:controlx+'px', top:controly+'px'})
        	},
        
        	togglecontrol:function(){
        		var scrolltop=jQuery(window).scrollTop()
        		if (!this.cssfixedsupport)
        			this.keepfixed()
        		this.state.shouldvisible=(scrolltop>=this.setting.startline)? true : false
        		if (this.state.shouldvisible && !this.state.isvisible){
        			this.$control.stop().animate({opacity:1}, this.setting.fadeduration[0])
        			this.state.isvisible=true
        		}
        		else if (this.state.shouldvisible==false && this.state.isvisible){
        			this.$control.stop().animate({opacity:0}, this.setting.fadeduration[1])
        			this.state.isvisible=false
        		}
        	},
        
        	init:function(){
        		jQuery(document).ready(function($){
        			var mainobj=scrolltotop
        			var iebrws=document.all
        			mainobj.cssfixedsupport=!iebrws || iebrws && document.compatMode=="CSS1Compat" && window.XMLHttpRequest //not IE or IE7+ browsers in standards mode
        			mainobj.$body=(window.opera)? (document.compatMode=="CSS1Compat"? $('html') : $('body')) : $('html,body')
        			mainobj.$control=$('<div id="topcontrol">'+mainobj.controlHTML+'</div>')
        				.css({position:mainobj.cssfixedsupport? 'fixed' : 'absolute', bottom:mainobj.controlattrs.offsety, right:mainobj.controlattrs.offsetx, opacity:0, cursor:'pointer'})
        				.attr({title:'Scroll Back to Top'})
        				.click(function(){mainobj.scrollup(); return false})
        				.appendTo('body')
        			if (document.all && !window.XMLHttpRequest && mainobj.$control.text()!='') //loose check for IE6 and below, plus whether control contains any text
        				mainobj.$control.css({width:mainobj.$control.width()}) //IE6- seems to require an explicit width on a DIV containing text
        			mainobj.togglecontrol()
        			$('a[href="' + mainobj.anchorkeyword +'"]').click(function(){
        				mainobj.scrollup()
        				return false
        			})
        			$(window).bind('scroll resize', function(e){
        				mainobj.togglecontrol()
        			})
        		})
        	}
        }
        
        scrolltotop.init()
    </script>
    <script type="text/javascript" src="{{get_url('views_static', path='./files/jcarousel.min.js')}}"></script>
    <link rel="stylesheet" href="./files/jcarousel.css" type="text/css" media="all">
</head>


<body>

<div id="container">

<!--header-->
<div id="header" class="">
<div id="header_inner">
<div class="member_menu">
    <h1>説明文</h1>
</div>


<div id="header_logo"><a href="/"><img src="{{get_url('views_static', path='./files/logo.png')}}" alt="ドロップブックスアダルト" width="360" height="80"></a></div>
<div class="contents">
<!--search-->
<div>
    <form action="http://dropbooks.tv/search" method="post">
        <p>
            <input name="search_type" type="radio" value="and" id="and" checked="checked"><label for="and">and検索</label>／
            <input name="search_type" type="radio" value="or" id="or"><label for="or">or検索</label>
        </p>
        <p class="header_search">
            <input type="search" placeholder="検索文字を入れてください" class="search_box" name="word">
            <input type="submit" value="" class="submitBtn">
        </p>
    </form>
</div>
<!--search-->
</div>
</div>
</div>
<!--/header-->

<script type="text/javascript">
    $(function(){
        var nav = $('#header'),
        h = $("#header .member_menu"),
        height = h.height();
        var b_upload = $("#mybook").next("li").children("a");
        var b_upload_html = b_upload.html();
    
        $(window).scroll(function () {
            if($(window).scrollTop() > height) {
                nav.addClass("fixed");
                b_upload.html("アップロード");
            } else {
                nav.removeClass("fixed");
                b_upload.html(b_upload_html);
            }
        });
    });
    //スクロール時ヘッダーメニューのみ固定
</script>

<div id="wrap">
<div id="outline">
<div id="main2col">
<div class="sortbox">
<div class="sort_title">
<div class="allfile"><span class="all-file">全てのファイル件数</span>{{count_manga}}</div>
    <h2>ファイル一覧(1/8ページ)</h2>
</div>
<ul class="sort_list">

<form action="http://dropbooks.tv/tops/index/sort:download_count/direction:desc/term:24h/page:1" method="get">
    並べ替え：
    <select name="" class="sort_list">
        <option value="created">新着順</option>
        <option value="created_asc">古い順</option>
        <option value="end_period">公開期限が近い順</option>
        <option value="page">ページ数が多い順</option>
        <option value="page_asc">ページ数が少ない順</option>
        <option value="size">ファイルサイズが多い順</option>
        <option value="size_asc">ファイルサイズが少ない順</option>
        <option value="pv">プレビュー数が多い順</option>
        <option value="pv_asc">プレビュー数が少ない順</option>
    </select>
    アップロード期間：
    <select name="" class="sort_time_list">
        <option value="">指定なし</option>
        <option value="24h" selected="selected">24時間以内</option>
        <option value="3d">3日以内</option>
        <option value="1w">1週間以内</option>
        <option value="1m">1ヶ月以内</option>
        <option value="3m">3ヶ月以内</option>
    </select>
</form>

<script type="text/javascript">
    $("select").change(function(){
        var sel = $(this).val();
        switch(sel){
            case '':url = "/tops/index/sort:download_count/direction:desc/term:/page:1";break;
            case '24h':url = "/tops/index/sort:download_count/direction:desc/term:24h/page:1";break;
            case '3d':url = "/tops/index/sort:download_count/direction:desc/term:3d/page:1";break;
            case '1w':url = "/tops/index/sort:download_count/direction:desc/term:1w/page:1";break;
            case '1m':url = "/tops/index/sort:download_count/direction:desc/term:1m/page:1";break;
            case '3m':url = "/tops/index/sort:download_count/direction:desc/term:3m/page:1";break;
            case 'created':url     = "/tops/index/sort:created/direction:desc/page:1/term:24h";break;
            case 'created_asc':url = "/tops/index/sort:created/direction:asc/page:1/term:24h";break;
            case 'end_period':url  = "/tops/index/sort:end_period/direction:asc/page:1/term:24h";break;
            case 'pv':url          = "/tops/index/sort:preview_count/direction:desc/page:1/term:24h";break;
            case 'pv_asc':url      = "/tops/index/sort:preview_count/direction:asc/page:1/term:24h";break;
            case 'dl':url          = "/tops/index/sort:download_count/direction:desc/page:1/term:24h";break;
            case 'dl_asc':url      = "/tops/index/sort:download_count/direction:asc/page:1/term:24h";break;
            case 'page':url        = "/tops/index/sort:page/direction:desc/page:1/term:24h";break;
            case 'page_asc':url    = "/tops/index/sort:page/direction:asc/page:1/term:24h";break;
            case 'size':url        = "/tops/index/sort:size/direction:desc/page:1/term:24h";break;
            case 'size_asc':url    = "/tops/index/sort:size/direction:asc/page:1/term:24h";break;
            case 'assessment':url  = "/tops/index/sort:assessment_count/direction:desc/page:1/term:24h";break;
        }
        location.href = url;
    });
</script>

</ul>
</div>

<script type="text/javascript">
    jump_url = "/Tops/index/sort:download_count/direction:desc/term:24h/";
    function page_jump(){
        jump_url = jump_url + 'page:'+ $("div.page_jump input").val();
        location.href = jump_url;
    }
</script>

<div class="content_mb_none">
<div class="page_jump">
    <input name="" type="number" min="1" max="8">
    ページへ
    <input name="" type="button" value="移動" onclick="page_jump()">
    [←][→]キー移動でもページ移動できます
</div>

<div class="navigationbox">
    <span class="left key_txt">【(←)前ページ】</span>
    <span class="right key_txt">【次ページ(→)】</span>
    <ul class="morelink">
    <li class="prev" id="prePage">
% if page > 1:
    <a href="/tops/index/term:no/page:{{page - 1}}" rel="next" id="nextPage">前へ</a>
% else:
    前へ
% end
    </li>
% for i in range(1, max_page+1):
% if i == page:
    <li class="current">{{page}}</li>
% else:
    <li><a href="/tops/index/term:no/page:{{i}}">{{i}}</a></li>
% end
% end
    <li class="next">
% if max_page > page:
    <a href="/tops/index/term:no/page:{{page + 1}}" rel="next" id="nextPage">次へ</a>
% else:
    次へ
% end
    </li>
    </ul>
</div>
</div>

<script type="text/javascript">
    $(function() {
        $("img.picborder.mb5").lazyload();
    });
    $(window).keydown(
        function (e) {
            switch(e.keyCode){
                case 37:
                prePage();
                break;
                case 39:
                nextPage();
                break;
            }
        }
    );
    function prePage(){
        var url ='';
        url = $('#prePage').attr('href');
        if(url != 'undefined'){
            location.href= url;
        }
    }

    function nextPage(){
        var url ='';
        url = $('#nextPage').attr('href');
        if( url != 'undefined'){
            location.href= url;
        }
    }

    function AutoJump(url){
        if($('input').val() !== ''){
            return;
        }
        location.href= url;
    }
</script>




<!--アップロード一覧-->
<div class="content_list">

% for i in mangas:
%     author = i['author']
%     title = i['title']
    <div class="list" id="iUwI9GcbMe">
        <a href="http://dropbooks.tv/detail/{{author}}:{{title}}" title="[{{author}}] {{title}}">
            <img src="{{get_url('views_static', path='./files/EYCirSrafm.jpg')}}" class="picborder mb5" alt="[{{author}}] {{title}}">
        </a>
        <h3 style="background-color: rgb(255, 204, 153);">
            <a href="http://dropbooks.tv/detail/{{author}}:{{title}}" title="[{{author}}] {{title}}">[{{author}}] {{title}}</a>
        </h3>
        <ul class="tag_list">
            <li class="user"><a href="/search/index/word:{{author}}">{{author}}</a></li>
        </ul>
    </div>
% end
<!--/アップロード一覧-->



<div class="content">
<form action="http://dropbooks.tv/tops/index/sort:download_count/direction:desc/term:24h/page:1" method="get" class="page_jump">
[←][→]キー移動でもページ移動できます
</form>
<div class="navigationbox">
    <span class="left key_txt">【(←)前ページ】</span>
    <span class="right key_txt">【次ページ(→)】</span>
    <ul class="morelink">
    <li class="prev" id="prePage">
% if page > 1:
    <a href="/tops/index/term:no/page:{{page - 1}}" rel="next" id="nextPage">前へ</a>
% else:
    前へ
% end
    </li>
% for i in range(1, max_page+1):
% if i == page:
    <li class="current">{{page}}</li>
% else:
    <li><a href="/tops/index/term:no/page:{{i}}">{{i}}</a></li>
% end
% end
    <li class="next">
% if max_page > page:
    <a href="/tops/index/term:no/page:{{page + 1}}" rel="next" id="nextPage">次へ</a>
% else:
    次へ
% end
    </li>
</div>

</div>

</div><!--/main-->
</body>
</html>
