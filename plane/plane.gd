extends CharacterBody3D

signal dead
signal score_changed
signal fuel_changed

@export var forward_speed: float = 25.0
@export var pitch_speed: float = 1.1
@export var roll_speed: float = 2.5
@export var level_speed: float = 4.0

var pitch_input: float = 0
var roll_input: float = 0
var max_altitude: float = 20

@export var fuel_burn: float = 1.0
var max_fuel: float = 10.0
var fuel: float = 10.0:
    set = set_fuel
var score: int = 0:
    set = set_score


# setters

func set_fuel(value: float) -> void:
    fuel = min(value, max_fuel)
    fuel_changed.emit(fuel)
    if fuel <= 0:
        die()


func set_score(value: int) -> void:
    score = value      
    score_changed.emit(score)


# built-in functions

func _physics_process(delta) -> void:
    get_input(delta)

    rotation.x = lerpf(rotation.x, pitch_input, pitch_speed * delta)
    rotation.x = clamp(rotation.x, deg_to_rad(-45), deg_to_rad(45))

    $cartoon_plane.rotation.z = lerpf($cartoon_plane.rotation.z, roll_input, roll_speed * delta)

    velocity = -transform.basis.z * forward_speed
    velocity += transform.basis.x * $cartoon_plane.rotation.z / deg_to_rad(45) * forward_speed / 2.0

    move_and_slide()
    if get_slide_collision_count() > 0:
        die()
    
    fuel -= fuel_burn * delta
    print(fuel)


# custom functions

func get_input(delta: float) -> void:
    pitch_input = Input.get_axis("pitch_up", "pitch_down")
    roll_input = Input.get_axis("roll_left", "roll_right")

    if position.y >= max_altitude and pitch_input > 0:
        position.y = max_altitude
        pitch_input = 0


func die() -> void:
    set_physics_process(false)
    $cartoon_plane.hide()
    $Explosion.show()
    $Explosion.play("default")
    await $Explosion.animation_finished
    $Explosion.hide()
    dead.emit()
    get_tree().reload_current_scene()