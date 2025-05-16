extends Node2D

# 玩家基础属性
var speed = 300.0
var health = 3
var shoot_cooldown = 0.2
var can_shoot = true

# 子弹场景
var bullet_scene = preload("res://scenes/weapons/Bullet.tscn")

func _ready():
	# 初始化玩家
	pass

func _process(delta):
	# 处理移动
	var direction = Input.get_axis("ui_left", "ui_right")
	position.x += direction * speed * delta
	
	# 限制玩家在屏幕范围内
	position.x = clamp(position.x, 50, 1102)  # 假设屏幕宽度为1152
	
	# 自动射击
	if can_shoot:
		shoot()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true

func shoot():
	# 创建子弹
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)

func take_damage(amount):
	health -= amount
	if health <= 0:
		game_over()

func game_over():
	# 游戏结束逻辑
	queue_free() 
