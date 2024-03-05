extends Camera3D

@export var target_path: NodePath
@export var offset = Vector3.ZERO

var target = null


func _ready() -> void:
    if target_path:
        target = get_node(target_path)
        if position != target.position:
            position = target.position
            look_at(target.position)


func _physics_process(delta) -> void:
    if !target:
        return
    position = target.position + offset