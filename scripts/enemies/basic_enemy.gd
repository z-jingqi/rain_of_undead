extends CharacterBody2D

# 敌人属性
var health = 1
var speed = 100.0
var is_alive = true
var target = null

func _ready():
	# 获取玩家引用
	target = get_tree().get_first_node_in_group("player")

func _process(delta):
	if not is_alive or not target:
		return
		
	# 计算移动方向
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed
	
	# 移动敌人
	move_and_slide()
	
	# 检查是否超出屏幕
	if is_out_of_bounds():
		queue_free()

func take_damage(amount):
	if not is_alive:
		return
		
	health -= amount
	if health <= 0:
		die()

func die():
	is_alive = false
	# TODO: 添加死亡效果和掉落物
	queue_free()

func is_out_of_bounds():
	var viewport_rect = get_viewport_rect()
	var margin = 100  # 屏幕边缘的额外空间
	
	return (global_position.x < -margin or 
			global_position.x > viewport_rect.size.x + margin or
			global_position.y < -margin or
			global_position.y > viewport_rect.size.y + margin) 
