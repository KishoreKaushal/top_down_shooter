extends Spatial

export(int) var speed = 70
export(int) var damage = 1

const KILL_TIME = 3
var timer = 0;

func _physics_process(delta):
  var fire_direction : Vector3 = global_transform.basis.z.normalized()
  global_translate(fire_direction * speed * delta)
  
  timer += delta
  
  if timer > KILL_TIME:
    queue_free()


func _on_Area_body_entered(body: Node):
#  print("Area entered!")
  queue_free()
  
  if body.has_node("Stats"):
    var stats_node : Stats = body.get_node("Stats")
    stats_node.take_hit(damage)
