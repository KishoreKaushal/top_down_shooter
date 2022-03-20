extends Spatial

export(PackedScene) var Bullet

export(float) var muzzle_speed = 30
export(int) var shot_intervals_ms = 100
onready var rof_timer = $Timer
var can_we_shoot = true

func _ready():
  rof_timer.wait_time = shot_intervals_ms/1000.0

func _process(delta):
  pass


func shoot():
  if can_we_shoot:
    var bullet : Spatial = Bullet.instance()
    bullet.global_transform = $Muzzle.global_transform
    bullet.speed = muzzle_speed
    #var scene_root = get_tree().root.get_child(0)
    var scene_root = get_node("/root/Level")
    scene_root.add_child(bullet)
    can_we_shoot = false
    rof_timer.start()


func _on_Timer_timeout():
  can_we_shoot = true
