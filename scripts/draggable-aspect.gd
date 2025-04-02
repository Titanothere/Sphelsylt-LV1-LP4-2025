class_name DraggableAspect extends Control

signal dragged_away(aspect: DraggableAspect)

@onready var texture_rect: TextureRect = $TextureRect

@export var aspect_source: AspectDroppableSlot.AspectSlotType = AspectDroppableSlot.AspectSlotType.WEAPON
@export var type: AspectType
var typeValue: float

func _ready() -> void:
	typeValue = randf()

enum AspectType {PROJECTILE_RANGE, PROJECTILE_SPEED, PROJECTILE_SPREAD, 
				 SWORD_SWING_ANGLE, SWORD_LIFE_STEAL,
				 ATTACK_SPEED, SIZE, DAMAGE, KNOCKBACK}

func updateTypeValue(val):
	typeValue = val
	updateLabel()
	

func showAspectType(aspectType: AspectType) -> String:
	match aspectType:
		AspectType.PROJECTILE_RANGE: return "Proj Range"
		AspectType.PROJECTILE_SPEED: return "Proj Speed"
		AspectType.PROJECTILE_SPREAD: return "Proj Spread"
		AspectType.SWORD_SWING_ANGLE: return "Swing Angle"
		AspectType.SWORD_LIFE_STEAL: return "Sword Lifesteal"
		AspectType.ATTACK_SPEED: return "Attack Speed"
		AspectType.SIZE: return "Size"
		AspectType.DAMAGE: return "Damage"
		AspectType.KNOCKBACK: return "Knockback"
		_: return ""

func updateLabel() -> void:
	$Label.clear()
	$Label.add_text(showAspectType(type))
	$TypeValueLabel.clear()
	$TypeValueLabel.add_text(str(typeValue).pad_decimals(2))

func getPreview() -> Control:
	return texture_rect.duplicate()
	
func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(getPreview())
	return self
