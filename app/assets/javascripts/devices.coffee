Device = 
	init: ->
		this.fetch_sensors_list()
		$(document).on 'change', '#device_device_id', this.fetch_sensors_list

	fetch_sensors_list: ->
		game_id = $('#device_device_id').data 'game-id'
		step_id = $('#device_device_id').data 'step-id'
		device_id = $('#device_device_id').val()

		$.getJSON "/games/#{game_id}/steps/#{step_id}/devices/#{device_id}/sensors", (response) ->
			Device.update_sensors_select(response)

	update_sensors_select: (response) ->
		$('#device_sensor_id').html ''
		response.forEach (sensor) ->
			$('#device_sensor_id').append "<option value='#{sensor.id}'>#{sensor.sensor_type}</option>"

    

$(document).ready ->
	Device.init()