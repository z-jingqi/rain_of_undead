extends CharacterBody2D

# 玩家属性
var health = 3
var max_health = 3
var is_alive = true

# 射击相关
var can_shoot = true
var shoot_cooldown = 0.2
var bullet_scene = preload("res://scenes/weapons/Bullet.tscn")

# 节点引用
@onready var weapon_pivot = $WeaponPivot
@onready var shoot_timer = $ShootTimer
@onready var area2d = $Area2D
@onready var game_ui = get_node("/root/Main/UI")

func _ready():
	# 初始化射击计时器
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.one_shot = true
	area2d.body_entered.connect(_on_area2d_body_entered)
	
	# 初始化UI
	game_ui.update_health(health)

func _process(delta):
	if not is_alive:
		return
		
	# 处理瞄准
	aim_at_mouse()
	
	# 自动射击
	if can_shoot:
		shoot()

func aim_at_mouse():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	weapon_pivot.rotation = direction.angle()

func shoot():
	if not can_shoot:
		return
		
	# 创建子弹
	var bullet = bullet_scene.instantiate()
	bullet.global_position = weapon_pivot.global_position
	bullet.rotation = weapon_pivot.rotation
	get_parent().get_node("BulletContainer").add_child(bullet)
	
	# 开始冷却
	can_shoot = false
	shoot_timer.start()

func _on_shoot_timer_timeout():
	can_shoot = true

func take_damage(amount):
	if not is_alive:
		return
		
	health -= amount
	game_ui.update_health(health)
	
	if health <= 0:
		die()

func die():
	is_alive = false
	# TODO: 实现死亡效果
	queue_free()

func _on_area2d_body_entered(body):
	if body.is_in_group("enemies"):
		take_damage(1) 
