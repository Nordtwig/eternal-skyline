extends Area3D

@export var center_bonus_size: float = 2.0
@export var center_bonus_modifier: float = 2.0
@export var score: int = 100

func _ready() -> void:
    body_entered.connect(on_body_entered)
    $Label3D.hide()
    

func _process(delta) -> void:
    $CollisionShape3D/MeshInstance3D.rotate_y(deg_to_rad(50) * delta)


func on_body_entered(body: CharacterBody3D) -> void:
    $CollisionShape3D/MeshInstance3D.hide()
    var distance_to_center = global_position.distance_to(body.global_position)
    if distance_to_center < center_bonus_size:
        $Label3D.text = str(int(score * center_bonus_modifier))
        $Label3D.modulate = Color(1, 1, 0)
    elif distance_to_center > 3.5:
        $Label3D.text = str(int(score / 2))
    else:
        $Label3D.text = str(score)
    $Label3D.show()

    var tween = create_tween().set_parallel()
    tween.tween_property($Label3D, "position", Vector3(0, 10, 0), 1.0)
    tween.tween_property($Label3D, "modulate:a", 0.0, 0.5)
