#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require semantic
#= require clipboard
#= require_tree .

document.addEventListener 'turbolinks:load', ->
  new Clipboard('.copy')
