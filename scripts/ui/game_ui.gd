extends CanvasLayer

# 节点引用
@onready var health_value = $HealthContainer/HealthValue
@onready var score_value = $ScoreContainer/ScoreValue

# 游戏数据
var score = 0

func _ready():
	# 初始化UI
	update_health(3)  # 初始生命值
	update_score(0)   # 初始分数

func update_health(value):
	health_value.text = str(value)

func update_score(value):
	score = value
	score_value.text = str(score)

func add_score(value):
	update_score(score + value) 
