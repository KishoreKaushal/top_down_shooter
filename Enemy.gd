extends KinematicBody

onready var nav = $"../Navigation" as Navigation
onready var player = $"../Player" as KinematicBody

var path = []
var current_node = 0
var speed = 4


func _physics_process(delta):
  if current_node < path.size():
    var direction: Vector3 = path[current_node] - global_transform.origin
    if direction.length() < 1:
      current_node += 1
#      print("Current Node: ", current_node)
    else:
      move_and_slide(direction.normalized() * speed)


func update_path(target_position):
  path = nav.get_simple_path(global_transform.origin, target_position)
  

func _on_Timer_timeout():
  update_path(player.global_transform.origin)
  current_node = 0


func _on_Stats_death():
  queue_free()
