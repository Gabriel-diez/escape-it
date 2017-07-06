Step = 
	init: ->
		$(document).on 'click', '.game-step h4', this.toggleActions.bind this

	toggleActions: (element) ->
		$(element.target).parent('.game-step').find('.game-actions').slideToggle();


$(document).ready ->
	Step.init()
