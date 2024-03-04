extends CharacterBody3D

@export var forward_speed: float = 25.0
@export var pitch_speed: float = 1.1
@export var roll_speed: float = 2.5
@export var level_speed: float = 4.0

var pitch_input: float = 0
var roll_input: float = 0
var max_altitude: float = 20


func _physics_process(delta) -> void:
    get_input(delta)

    rotation.x = lerpf(rotation.x, pitch_input, pitch_speed * delta)
    rotation.x = clamp(rotation.x, deg_to_rad(-45), deg_to_rad(45))

    $cartoon_plane.rotation.z = lerpf($cartoon_plane.rotation.z, roll_input, roll_speed * delta)

    velocity = -transform.basis.z * forward_speed
    velocity += transform.basis.x * $cartoon_plane.rotation.z / deg_to_rad(45) * forward_speed / 2.0

    move_and_slide()


func get_input(delta: float) -> void:
    pitch_input = Input.get_axis("pitch_down", "pitch_up")
    roll_input = Input.get_axis("roll_left", "roll_right")

    if position.y >= max_altitude and pitch_input > 0:
        position.y = max_altitude
        pitch_input = 0

