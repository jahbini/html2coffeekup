# 
T = require 'halvalla'
module.exports = class C_html
  #pass the db entry into the class so that the classes have access to it
  constructor: (@db,@allDB)->
    return

  # 
  # section html
  # 
  html: =>
    T.doctype 'html'
    T.comment 'paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/'
    T.comment '[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]'
    T.comment '[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]'
    T.comment '[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]'
    T.comment '[if gt IE 8]><!'
    T.html ".no-js", lang: "en", =>
      T.comment '<![endif]'
      T.head =>
        T.meta "http-equiv": "content-type", content: "text/html; charset=UTF-8"
        T.tag "futag", "http-equiv": "content-type", content: "text/html; charset=UTF-8"
        T.title => T.raw "bamboo can do cooperative :: Bamboo Snow"
        T.meta name: "description", content: "Home page for Bamboo-Snow.com"
        T.meta name: "generator", content: "concrete5 - 5.6.3.2"
        T.script type: "text/javascript", """
var CCM_DISPATCHER_FILENAME = '/index.php';
var CCM_CID = 244;
var CCM_EDIT_MODE = false;
var CCM_ARRANGE_MODE = false;
var CCM_IMAGE_PATH = \"/updates/concrete5.6.3.2/concrete/images\";
var CCM_TOOLS_PATH = \"/index.php/tools/required\";
var CCM_BASE_URL = \"http://bamboo-snow.com\";
var CCM_REL = \"\";
"""
        T.link rel: "stylesheet", type: "text/css", href: "/updates/concrete5.6.3.2/concrete/css/ccm.base.css"
        T.script type: "text/javascript", src: "/updates/concrete5.6.3.2/concrete/js/jquery.js"
        T.script type: "text/javascript", src: "/updates/concrete5.6.3.2/concrete/js/ccm.base.js"
        T.style type: "text/css", => T.raw """
#inlineLogin {background-repeat:no-repeat; float:right} #inlineLogin form {display:inline-block}  #inlineLogin form div {display:inline-block}
"""
        T.link rel: "stylesheet", type: "text/css", href: "/updates/concrete5.6.3.2/concrete/blocks/page_list/view.css"
        T.link rel: "stylesheet", type: "text/css", href: "/packages/content_around_image/blocks/content_around_image/view.css"
        T.link rel: "stylesheet", type: "text/css", href: "/packages/theme_hi_vis/blocks/fullscreen_background/view.css"
        T.link rel: "stylesheet", type: "text/css", href: "/packages/login/blocks/login/view.css"
        T.comment 'Mobile viewport optimization http://goo.gl/b9SaQ'
        T.meta name: "HandheldFriendly", content: "True"
        T.meta name: "MobileOptimized", content: "320"
        T.meta name: "viewport", content: "initial-scale=1, maximum-scale=1"
        T.link rel: "stylesheet", href: "/themes/hi_vis/stylesheets/normalize.css"
        T.link rel: "stylesheet", href: "/themes/hi_vis/stylesheets/foundation.css"
        T.link href: "http://fonts.googleapis.com/css?family=Lato:400,700", rel: "stylesheet", type: "text/css"
        T.link rel: "stylesheet", media: "screen", type: "text/css", href: "/files/cache/css/hi_vis/app.css"
        T.link rel: "stylesheet", href: "/themes/hi_vis/typography.css"
        T.script src: "/themes/hi_vis/js/vendor/modernizr.js"
        T.link href: "//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css", rel: "stylesheet"
        T.comment 'IE Fix for HTML5 Tags'
        T.comment """
'[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]'
"""
      T.body =>
        @page()
        T.comment 'contents end here'
        T.comment 'Footer'
        @footer()
        T.div ".row", =>
          T.p ".right", => T.raw "&copy; 2018 bamboo can do cooperative."
        T.script src: "/themes/hi_vis/js/vendor/fastclick.js"
        T.script src: "/themes/hi_vis/js/foundation.min.js"
        T.script """
$(document).foundation({
    orbit: {},
    topbar: {
      mobile_show_parent_link: true
    }
  });
"""
  # 
  # section footer
  # 
  # 
  # section page
  # 
  page: =>
    T.div "#page", =>
      T.comment 'Header and Nav'
      @header()
      T.comment 'End Header and Nav'
      T.comment 'content starts'
      T.div ".content.row", =>
        T.div ".columns.large-12", =>
          T.ul ".breadcrumbs", =>
            T.li =>
              T.a ".crumb", href: "/", target: "_self", => T.raw "Home"
            T.li => T.raw "Bamboo Snow"
        @blovi_ation()
      T.div ".columns.large-4.sidebar", =>
        T.div ".ccm-page-list", =>
          T.h3 ".ccm-page-list-title", =>
            T.a href: "/bamboo-snow/greater-life/", target: "_self", => T.raw "The Greater Life"
          @dicey_0()
          T.h3 ".ccm-page-list-title", =>
            T.a href: "/bamboo-snow/true-confessions/", target: "_self", => T.raw "True Confessions"
          @dicey_1()
          T.h3 ".ccm-page-list-title", =>
            T.a href: "/bamboo-snow/faq/", target: "_self", => T.raw "FAQ"
          @dicey_2()
          T.h3 ".ccm-page-list-title", =>
            T.a href: "/bamboo-snow/news/", target: "_self", => T.raw "News"
          @dicey_3()
        T.comment 'end .ccm-page-list'
  # 
  # section dicey_3
  # 
  # 
  # section dicey_2
  # 
  # 
  # section dicey_1
  # 
  # 
  # section dicey_0
  # 
  # 
  # section blovi-ation
  # 
  # 
  # section cai-image-with-caption-216
  # 
  # 
  # section header
  # 
  # 
  # section badclass
  # 
  # 
  # section inlineLogin
  # 
  # 
  # section submit
  # 
  # 
  # section uPassword
  # 
  # 
  # section uName
  # 
  # 
  # section rcID
  # 
