extends Control


func _ready() -> void:
    $VBoxContainer/TextureButton.pressed.connect(on_play_button_pressed)


func on_play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://main/main.tscn")