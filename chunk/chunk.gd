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
    for side in [-1, 1]:
        var z_position = -10
        for i in 18:
            if randf() > 0.75:
                z_position -= randi_range(5, 10)
                continue
            var new_building = buildings[randi_range(0, buildings.size()-1)].instantiate()
            add_child(new_building)
            new_building.transform.origin.z = z_position
            new_building.transform.origin.x = 20 * side
            z_position -= new_building.get_node("MeshInstance3D").mesh.get_aabb().size.z


func add_obstacle_buildings() -> void:
    if level > 0:
        for z in range(0, -200, -20):
            if randf() > 0.8:
                var new_building = buildings[0].instantiate()
                add_child(new_building)
                new_building.position.z = z
                new_building.position.x += 8
                new_building.rotation.y = PI / 2


func add_rings()  -> void:
    for z in range(0, -200, -10):
        if randf() > 0.76:
            var new_ring = ring.instantiate()
            new_ring.position.z = z
            new_ring.position.y = randf_range(3, 17)
            match level:
                0: 
                    pass
                1: 
                    new_ring.move_y = true
                2:
                    new_ring.position.x = randf_range(-10, 10)
                    new_ring.move_y = true
                3:
                    new_ring.position.x = randf_range(-10, 10)
                    new_ring.move_x = true
            add_child(new_ring)


func on_vos_notifier_screen_exited() -> void:
    queue_free()
