extends Spatial

export(PackedScene) var spawn_scene

onready var timer = $Timer

var waves # list of all Wave nodes : [Wave, Wave1, Wave2, ...]
var current_wave_index: int = -1
var current_wave: Wave

var spawns_remaining: int
var killed_enemies: int

func _ready():
  waves = $Waves.get_children()
  start_next_wave()


func start_next_wave():
  current_wave_index += 1
  killed_enemies = 0
  if current_wave_index < waves.size():
    current_wave = waves[current_wave_index]
    spawns_remaining = current_wave.num_spawns
    timer.wait_time = current_wave.time_between_spawns
    print("Wave ", current_wave_index + 1, "/", waves.size())
    timer.start()
  else:
    print("Hurray!! You defeated all enemies.")


func _on_Timer_timeout():
  if spawns_remaining:
    spawn()
    spawns_remaining -= 1


func spawn():
  var spawned: Enemy = spawn_scene.instance()
  var stats_node : Stats = spawned.get_node("Stats")
  stats_node.connect("death", self, "_on_Enemy_Stats_death")
  var scene_root = get_node("/root/Level")
  scene_root.add_child(spawned)


func _on_Enemy_Stats_death():
  killed_enemies += 1
  if killed_enemies >= current_wave.num_spawns:
    start_next_wave()
