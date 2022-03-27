extends Node

class_name Stats

export var max_hp = 10
var current_hp = max_hp

signal death

func take_hit(damage):
  current_hp -= 1
#  print("I'm hit!! ", current_hp, "/", max_hp)
  
  if current_hp <= 0:
    die()

func die():
  emit_signal("death")

func _ready():
  pass
