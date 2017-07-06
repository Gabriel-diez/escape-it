GameTimer = 
	init: ->
		setInterval( ->
			date = $('.datestarted').data('time')
			$('.datestarted').html('Démarré ' + moment(Date.parse(date)).fromNow())
		, 1000)

Search = 
	init: ->
		$('#search-form, #search').on 'submit, change, keydown', this.process.bind(this)

	process: (event) ->
		event.preventDefault() if event.keyCode == 13
		return if $('#search').val().length < 2
		$.ajax
			url: "/games?search=#{$('#search').val()}",
			dataType: "script",
			type: "GET"



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
	Search.init()