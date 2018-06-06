T=require 'halvalla'
spec = ()->
  T.div ".w3social-icons", =>
    T.ul =>
      T.li =>
        T.a ".fb", href: "#", =>
          T.i ".fa.fa-facebook",''
      T.li =>
        T.a ".gp", href: "#", =>
          T.i ".fa.fa-google-plus",''
      T.li =>
        T.a ".twit", href: "#", =>
          T.i ".fa.fa-twitter",''
      T.li =>
        T.a ".drbl", href: "#", =>
          T.i ".fa.fa-dribbble",''
console.log T.render spec