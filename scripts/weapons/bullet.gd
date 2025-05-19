extends Area2D

# 子弹属性
var speed = 800.0
var damage = 1
var direction = Vector2.ZERO
var max_distance = 1000.0
var distance_traveled = 0.0

func _ready():
	# 连接信号
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _process(delta):
	# 移动子弹
	position += direction * speed * delta
	
	# 检查最大距离
	distance_traveled += speed * delta
	if distance_traveled >= max_distance:
		queue_free()

func initialize(start_pos: Vector2, dir: Vector2):
	position = start_pos
	direction = dir.normalized()
	rotation = direction.angle()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.get_parent().take_damage(damage)
		queue_free() 
