class_name DraggableAspect extends Control

signal dragged_away(aspect: DraggableAspect)

@onready var texture_rect: TextureRect = $TextureRect

@export var aspect_source: AspectDroppableSlot.AspectSlotType = AspectDroppableSlot.AspectSlotType.WEAPON

func getPreview() -> Control:
	return texture_rect.duplicate()
	
func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(getPreview())
	return self
