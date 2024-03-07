extends Control


func _ready() -> void:
    $VBoxContainer/TextureButton.pressed.connect(on_play_button_pressed)
    $VBoxContainer/Label2.text = "High score: " + str(Global.high_score)


func on_play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://main/main.tscn")