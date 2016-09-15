#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require semantic
#= require clipboard
#= require_tree .

document.addEventListener 'turbolinks:load', ->
  new Clipboard('.js-clipboard')

  $modal =$ '#documentModal'
  $modal.modal({ duration: 0 })
  $(document).on 'click', '.js-document-link', (e) ->
    e.preventDefault()
    url = $(this).attr 'href'
    $modal.find('.content').html "<iframe src=#{url}></iframe>"
    $modal.modal('show')
