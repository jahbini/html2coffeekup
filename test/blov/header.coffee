# 
renderer = class C_header extends C_html
  # 
  # section html
  # 
  # 
  # section footer
  # 
  # 
  # section page
  # 
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
  header: =>
    T.header "#header", =>
      T.div ".row", =>
        T.div ".columns.large-12", =>
          T.img ".ccm-image-block", border: "0", alt: "", src: "/files/4014/0709/8794/Photos_-_345.jpg", width: "4464", height: "544"
          T.script src: "/packages/theme_hi_vis/blocks/fullscreen_background/vegas/jquery.vegas.min.js"
          T.link rel: "stylesheet", type: "text/css", href: "/packages/theme_hi_vis/blocks/fullscreen_background/vegas/jquery.vegas.css"
          T.script """
$(function() {
	$.vegas('slideshow', {
	  backgrounds:[
			    {src:'/files/7013/9633/5232/wallcoo_com_bamboos_GH099.jpg', fade:2000},
			    {src:'/files/1113/9633/5905/Photos_-_712.jpg', fade:2000},
			    {src:'/files/4613/9633/5855/FeaturePics-Bamboo-Snow-153825-1423111.jpg', fade:2000},
			    {src:'/files/2213/9633/6615/Photos_-_359.jpg', fade:2000},
			    {src:'/files/5713/9633/6402/Photos_-_816.jpg', fade:2000},
			    {src:'/files/3113/9633/6188/P1010080.JPG', fade:2000},
			    {src:'/files/1113/9633/5905/Photos_-_712.jpg', fade:2000},
			    {src:'/files/4613/9633/5855/FeaturePics-Bamboo-Snow-153825-1423111.jpg', fade:2000},
			  ],
	  delay:5000	})('overlay', {
	  src:'/packages/theme_hi_vis/blocks/fullscreen_background/vegas/overlays/black.png'
	});
});
"""
          @inlineLogin()
      @badclass()
  # 
  # section badclass
  # 
  badclass: =>
    T.div "#badclass.-bad-bad-badrow.nav-container", =>
      T.div ".columns.large12", =>
        T.nav ".centered.contain-to-grid.top-bar", "data-topbar": "data-topbar", =>
          T.ul ".title-area", =>
            T.li ".name"
            T.li ".menu-icon.toggle-topbar", =>
              T.a href: "#", =>
                T.span => T.raw "Menu"
          T.section ".top-bar-section", =>
            T.ul ".right", =>
              T.li class: "", =>
                T.a href: "/members/", target: "_self", class: "", => T.raw "Members"
  # 
  # section inlineLogin
  # 
  inlineLogin: =>
    T.div "#inlineLogin..ccm-block-styles", =>
      T.form ".login_block_form", method: "post", action: "/index.php/login/do_login/", =>
        @rcID()
        T.div ".loginTxt", => T.raw "Login"
        T.div ".uNameWrap", =>
          T.label for: "uName", => T.raw "Email Address"
          T.br()
          @uName()
        T.div ".passwordWrap", =>
          T.label for: "uPassword", => T.raw "Password"
          T.br()
          @uPassword()
        T.div ".loginButton", =>
          @submit()
        T.div ".login_block_register_link", =>
          T.a href: "/index.php/register/", => T.raw "Register"
  # 
  # section submit
  # 
  submit: =>
    T.input "#submit.btn.ccm-input-submit", type: "submit", name: "submit", value: "Sign In &gt;"
  # 
  # section uPassword
  # 
  uPassword: =>
    T.input "#uPassword.ccm-input-password", type: "password", name: "uPassword", value: ""
  # 
  # section uName
  # 
  uName: =>
    T.input "#uName.ccm-input-text", type: "text", name: "uName", value: ""
  # 
  # section rcID
  # 
  rcID: =>
    T.input "#rcID.ccm-input-hidden", type: "hidden", name: "rcID", value: "244"
