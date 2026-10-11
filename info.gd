extends PanelContainer

func _ready() -> void:
	$InfoLayout/PlanetName.pressed.connect(
		func(): toggle_section("generalInfo", "PlanetName")
	)

	$InfoLayout/mineralsTitle.pressed.connect(
		func(): toggle_section("mineralsInfo", "mineralsTitle")
	)

	$InfoLayout/plantsTitle.pressed.connect(
		func(): toggle_section("plantsDetails", "plantsTitle")
	)


func toggle_section(details_name: String, title_name: String) -> void:
	var details = $VBoxContainer.get_node(details_name)
	var title = $VBoxContainer.get_node(title_name)

	details.visible = not details.visible

	if details.visible:
		title.text = "▼ " + title.text.trim_prefix("▼ ").trim_prefix("▶ ")
	else:
		title.text = "▶ " + title.text.trim_prefix("▼ ").trim_prefix("▶ ")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
