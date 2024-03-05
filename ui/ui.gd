extends CanvasLayer


func _ready() -> void:
    var plane = get_tree().get_first_node_in_group("player")
    plane.fuel_changed.connect(on_player_fuel_changed)
    plane.score_changed.connect(on_player_score_changed)


func update_fuel(value: float) -> void:
    $FuelBar.value = value


func update_score(value: int) -> void:
    $Score.text = str(value)


func on_player_fuel_changed(value: float) -> void:
    update_fuel(value)


func on_player_score_changed(value: int) -> void:
    update_score(value)
