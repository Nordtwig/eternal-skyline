extends Node3D


var buildings: Array = [
    preload("res://buildings/building_1.tscn"),
    preload("res://buildings/building_2.tscn"),
    preload("res://buildings/building_3.tscn"),
    preload("res://buildings/building_4.tscn"),
    preload("res://buildings/building_5.tscn"),
]
var ring = preload("res://ring/ring.tscn")

var level: int = 0


func _ready() -> void:
    $VisibleOnScreenNotifier3D.screen_exited.connect(on_vos_notifier_screen_exited)

    add_buildings()
    add_obstacle_buildings()
    add_rings()


func add_buildings() -> void:
    pass


func add_obstacle_buildings() -> void:
    pass


func add_rings()  -> void:
    pass


func on_vos_notifier_screen_exited() -> void:
    queue_free()