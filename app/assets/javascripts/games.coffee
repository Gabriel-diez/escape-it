GameTimer = 
	init: ->
		setInterval( ->
			date = $('.datestarted').data('time')
			$('.datestarted').html('Démarré ' + moment(Date.parse(date)).fromNow())
		, 1000)


Game =
	init: ->
		setInterval( ->
			$.ajax({
				url: "/games",
				type: "GET",
				dataType: "script"
			})
		, 10000)

		$(document).ajaxStart ->
			$('#loadingSpinner').show()
		.ajaxStop ->
			$('#loadingSpinner').hide()



$(document).ready ->
	GameTimer.init()
	Game.init()