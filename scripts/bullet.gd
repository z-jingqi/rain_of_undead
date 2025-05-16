extends Area2D

var speed = 750.0
var damage = 1

func _ready():
	# 设置碰撞检测
	body_entered.connect(_on_body_entered)

func _process(delta):
	# 子弹向上移动
	position.y -= speed * delta
	
	# 如果子弹超出屏幕则删除
	if position.y < -50:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free() 
