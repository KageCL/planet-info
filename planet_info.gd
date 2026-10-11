
extends Control

var planets = [
	{
		"name": "Farinoth",
		"terrain": "Rocky",
		"gravity": "9.8 m/s²",
		"temperature": "35°C",
		"status": "Habitable, Unexplored",
		"metals": "Iron, Copper, Gold",
		"crystals": "Quartz, Hematite, Graphite",
		"fuels": "Xenon, Gasoline",
		"plants": "Burnwood, Ancient Trussel",
		"wildlife": "Chax, Grusbeak",
		"enemies": "Cave Stalkers",
		"color": Color(0.2, 0.55, 0.85)
	},
	{
		"name": "Pyrine",
		"terrain": "Volcanic",
		"gravity": "12.1 m/s²",
		"temperature": "300°C",
		"status": "Uninhabitable, Unexplored",
		"metals": "Iron, Nickel, Argon",
		"crystals": "Obsidian, Quartz",
		"fuels": "Sulfur",
		"plants": "Ashmoss, Fireweeds",
		"wildlife": "Lava Worms",
		"enemies": "Magma Birds",
		"color": Color(0.85, 0.2, 0.08)
	},
	{
		"name": "Glaciar",
		"terrain": "Glacial",
		"gravity": "7.4 m/s²",
		"temperature": "-110°C",
		"status": "Unexplored",
		"metals": "Cobalt",
		"crystals": "Diamonds, Quartz",
		"fuels": "Frozen",
		"plants": "Ice Ferns",
		"wildlife": "Frost Bears",
		"enemies": "Ice Leviathan",
		"color": Color(0.55, 0.85, 1.0)
	}
]

var current_planet := 0


@onready var planet_name_label = $LayoutContainer/Info/VBoxContainer/PlanetName
@onready var general_info = $LayoutContainer/Info/VBoxContainer/generalInfo
@onready var minerals_info = $LayoutContainer/Info/VBoxContainer/mineralsInfo
@onready var plants_details = $LayoutContainer/Info/VBoxContainer/plantsDetails

@onready var sphere = $LayoutContainer/PlanetView/SubViewport/Planet/MeshInstance3D

@onready var previous_button = $LayoutContainer/Info/VBoxContainer/PlanetNavigation/PreviousButton
@onready var next_button = $LayoutContainer/Info/VBoxContainer/PlanetNavigation/NextButton



func _ready():
	previous_button.pressed.connect(previous_planet)
	next_button.pressed.connect(next_planet)

	show_planet()


func previous_planet():
	current_planet = (current_planet - 1 + planets.size()) % planets.size()
	show_planet()


func next_planet():
	current_planet = (current_planet + 1) % planets.size()
	show_planet()


func show_planet():
	var planet = planets[current_planet]

	planet_name_label.text = planet["name"]

	update_labels(general_info, [
		"Terrain: " + planet["terrain"],
		"Gravity: " + planet["gravity"],
		"Temperature: " + planet["temperature"],
		"Status: " + planet["status"]
	])

	update_labels(minerals_info, [
		"Metals: " + planet["metals"],
		"Crystals: " + planet["crystals"],
		"Fuels: " + planet["fuels"]
	])

	update_labels(plants_details, [
		"Plants: " + planet["plants"],
		"Wildlife: " + planet["wildlife"],
		"Enemies: " + planet["enemies"]
	])

	var material = StandardMaterial3D.new()
	material.albedo_color = planet["color"]
	sphere.material_override = material


func update_labels(container: Node, values: Array):
	for i in range(min(container.get_child_count(), values.size())):
		var label = container.get_child(i) as Label
		if label:
			label.text = values[i]
