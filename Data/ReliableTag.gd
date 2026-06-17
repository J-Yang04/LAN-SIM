class_name ReliableTag extends Tag

func _init(Val:int) -> void:
	name = "Reliable"
	description = "This weapon has some degree of self-correction or is simply powerful enough to cause damage even with a glancing blow. It always does {VAL} damage, even if it misses its target or rolls less damage. Reliable damage inherits other tags (such as AP) and base damage type but not tags that require a hit, such as Knockback."
	val = Val
