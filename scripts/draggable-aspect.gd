class_name DraggableAspect extends Control

signal dragged_away(aspect: DraggableAspect)

@onready var texture_rect: TextureRect = $TextureRect

@export var aspect_source: AspectDroppableSlot.AspectSlotType = AspectDroppableSlot.AspectSlotType.WEAPON
@export var type: AspectType

enum AspectType {KNOCKBACK, RANGE, SPREAD, CRIT_CHANCE, PROJECTILE_SIZE}

func showAspectType(aspectType: AspectType) -> String:
	match aspectType:
		AspectType.KNOCKBACK: return "Knockback"
		AspectType.RANGE: return "Range"
		AspectType.SPREAD: return "Spread"
		AspectType.CRIT_CHANCE: return "Crit Chance"
		AspectType.PROJECTILE_SIZE: return "Projectile Size"
		_: return ""

func updateLabel() -> void:
	var label = get_node("Label")
	label.clear()
	label.add_text(showAspectType(type))

func getPreview() -> Control:
	return texture_rect.duplicate()
	
func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(getPreview())
	return self
