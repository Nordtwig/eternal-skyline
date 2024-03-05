extends Node3D

var chunk: Resource = preload("res://chunk/chunk.tscn")

var number_of_chunks: int = 1
var chunk_size: float = 200
var max_position: float = -100

func _process(delta) -> void:
    if $Plane.position.z < max_position:
        number_of_chunks += 1
        var new_chunk = chunk.instantiate()
        new_chunk.position.z = max_position - chunk_size / 2
        new_chunk.level = number_of_chunks / 4
        add_child(new_chunk)
        max_position -= chunk_size