# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#doc_matchers").multiselect
    enableFiltering: true
    includeSelectAllOption: true
    nonSelectedText: 'Выберите согласующих'
    selectAllText: 'Выбрать всех'
    buttonWidth: '100%'
    numberDisplayed: 4
    nSelectedText: ' подписантов выбрано'
    filterPlaceholder: 'Поиск'

