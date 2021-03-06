extends Spatial


const RAY_LENGTH:int = 2^63 - 1
var ray_origin = Vector3()
var ray_target = Vector3()

func _physics_process(delta):
  var mouse_position = get_viewport().get_mouse_position()
  ray_origin = $Camera.project_ray_origin(mouse_position)
  
  ray_target = ray_origin + $Camera.project_ray_normal(mouse_position) * RAY_LENGTH
  
  var space_state = get_world().direct_space_state
  var intersection = space_state.intersect_ray(ray_origin, ray_target)
  
  if not intersection.empty():
    var pos = intersection.position
    var look_at_me = Vector3(pos.x, $Player.translation.y, pos.z)
    $Player.look_at(look_at_me, Vector3.UP)
