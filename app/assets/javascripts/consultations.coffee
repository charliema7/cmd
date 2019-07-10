# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.consultation = App.cable.subscriptions.create "ConsultationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	unless data.consultation?
      switch data.action
        when "create" then document.getElementById("consultations-table").innerHTML += data.html
        when "update" then document.getElementById("#{data.id}").innerHTML = data.html
        when "destroy" then document.getElementById("#{data.id}").remove()
        else break