@tool
class_name DialogicHistoryEvent
extends DialogicEvent

## Event that allows clearing, pausing and resuming of history functionality.

enum ActionTypes {Clear, Pause, Resume}

### Settings

## The type of action: Clear, Pause or Resume
var action_type := ActionTypes.Pause


################################################################################
## 						EXECUTION
################################################################################

func _execute() -> void:
	match action_type:
		ActionTypes.Clear:
			dialogic.History.full_history = []
		ActionTypes.Pause:
			dialogic.History.full_history_enabled = false
		ActionTypes.Resume:
			dialogic.History.full_history_enabled = true
	
	finish()


################################################################################
## 						INITIALIZE
################################################################################

func _init() -> void:
	event_name = "History"
	set_default_color('Color6')
	event_category = Category.AudioVisual
	event_sorting_index = 0
	expand_by_default = false


func get_required_subsystems() -> Array:
	return [
				{'name':'History',
				'subsystem': get_script().resource_path.get_base_dir().path_join('subsystem_history.gd'),
				'settings': get_script().resource_path.get_base_dir().path_join('settings_history.tscn'),
				},
			]


################################################################################
## 						SAVING/LOADING
################################################################################

func get_shortcode() -> String:
	return "history"

func get_shortcode_parameters() -> Dictionary:
	return {
		#param_name 		: property_info
		"action" 			: {"property": "action_type", "default": ActionTypes.Pause},
	}

################################################################################
## 						EDITOR REPRESENTATION
################################################################################

func build_event_editor():
	add_header_edit('action_type', ValueType.FixedOptionSelector, '', '', {
		'selector_options': [
			{
				'label': 'Pause History',
				'value': ActionTypes.Pause,
			},
			{
				'label': 'Resume History',
				'value': ActionTypes.Resume,
			},
			{
				'label': 'Clear History',
				'value': ActionTypes.Clear,
			},
		]
		})
