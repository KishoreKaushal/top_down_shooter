extends Node

export(PackedScene)  var StartingWeapon

var hand : Position3D
var equipped_weapon : Spatial

func _ready():
  hand = get_parent().find_node("Hand")
  if StartingWeapon:
    equip_weapon(StartingWeapon.instance())
    
    
func equip_weapon(weapon_to_equip: Spatial):
  if equipped_weapon:
#    print("Delete current weapon")
    equipped_weapon.queue_free()
  else:
#    print("No weapon equipped")
    equipped_weapon = weapon_to_equip
    hand.add_child(equipped_weapon)

func shoot():
  if equipped_weapon:
    equipped_weapon.shoot()
