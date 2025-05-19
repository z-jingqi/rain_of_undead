extends Node2D

# 游戏状态
enum GameState {
	PLAYING,
	PAUSED,
	GAME_OVER
}

var current_state = GameState.PLAYING

# 场景引用
@onready var player = $Player
@onready var enemy_container = $EnemyContainer
@onready var bullet_container = $BulletContainer

# 敌人生成相关
var basic_enemy_scene = preload("res://scenes/enemies/BasicEnemy.tscn")
var spawn_timer = 0.0
var spawn_interval = 1.0  # 每秒生成一个敌人
var spawn_radius = 300.0  # 生成半径

func _ready():
	# 初始化游戏
	pass

func _process(delta):
	match current_state:
		GameState.PLAYING:
			process_game(delta)
		GameState.PAUSED:
			process_pause()
		GameState.GAME_OVER:
			process_game_over()

func process_game(delta):
	# 处理敌人生成
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_enemy()

func process_pause():
	# 暂停状态处理
	pass

func process_game_over():
	# 游戏结束状态处理
	pass

func spawn_enemy():
	var angle = randf() * 2 * PI  # 随机角度
	var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * spawn_radius
	
	# 创建敌人
	var enemy = basic_enemy_scene.instantiate()
	enemy.global_position = spawn_pos
	enemy_container.add_child(enemy)

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if current_state == GameState.PLAYING:
		current_state = GameState.PAUSED
		get_tree().paused = true
	elif current_state == GameState.PAUSED:
		current_state = GameState.PLAYING
		get_tree().paused = false 
