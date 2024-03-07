extends Node

var high_score: int = 0
var score_file: String = "user://hs.es"


func _ready() -> void:
    load_score()


func load_score() -> void:
    if FileAccess.file_exists(score_file):
        var file = FileAccess.open(score_file, FileAccess.READ)
        high_score = file.get_var()
    else:
        high_score = 0


func save_score() -> void:
    var file = FileAccess.open(score_file, FileAccess.WRITE)
    file.store_var(high_score)