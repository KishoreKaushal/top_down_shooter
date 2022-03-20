extends Spatial

export(int) var speed = 70

const KILL_TIME = 3
var timer = 0;

func _physics_process(delta):
  var fire_direction : Vector3 = global_transform.basis.z.normalized()
  global_translate(fire_direction * speed * delta)
  
  timer += delta
  
  if timer > KILL_TIME:
    queue_free()
