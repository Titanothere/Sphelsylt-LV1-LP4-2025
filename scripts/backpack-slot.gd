class_name AspectDroppableSlot extends PanelContainer

enum AspectSlotType { WEAPON, BACKPACK }
@export var slot_type: AspectSlotType

## Connecting with new slot. Remove from self and stop listening to this signal
func _on_aspect_dragged_away(aspect: DraggableAspect) -> void:
	aspect.dragged_away.disconnect(_on_aspect_dragged_away)
	remove_child(aspect)

## New Slot. Connected to signal to be able to remove draggable later.
func add_aspect(aspect: DraggableAspect) -> void:
	aspect.dragged_away.connect(_on_aspect_dragged_away)
	add_child(aspect)
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return (data is DraggableAspect)

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var aspect: DraggableAspect = data as DraggableAspect
	aspect.dragged_away.emit(aspect)
	aspect.aspect_source = slot_type
	add_aspect(aspect)
