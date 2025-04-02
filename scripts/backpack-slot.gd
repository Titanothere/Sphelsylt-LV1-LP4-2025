class_name AspectDroppableSlot extends PanelContainer

enum AspectSlotType { WEAPON, BACKPACK, NEW_STAT, TRASH }
@export var slot_type: AspectSlotType

## Connecting with new slot. Remove from self and stop listening to this signal
func _on_aspect_dragged_away(aspect: DraggableAspect) -> void:
	aspect.dragged_away.disconnect(_on_aspect_dragged_away)
	remove_child(aspect)

## New Slot. Connected to signal to be able to remove draggable later.
func add_aspect(aspect: DraggableAspect) -> void:
	aspect.dragged_away.connect(_on_aspect_dragged_away)
	add_child(aspect)
	
func clear_stat() -> bool:
	var children = get_children()
	if len(children) == 0:
		return false
	for child in children:
		if child is DraggableAspect:
			var aspect = child as DraggableAspect
			aspect.dragged_away.disconnect(_on_aspect_dragged_away)
		remove_child(child)
	return true
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var backpack = $".."
	if backpack.disableMove:
		return false
	if (data is DraggableAspect):
		var aspect = data as DraggableAspect
		if (aspect.aspect_source != AspectSlotType.NEW_STAT 
		  && slot_type == AspectSlotType.NEW_STAT):
			return false
		else:
			return true
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var aspect: DraggableAspect = data as DraggableAspect
	aspect.dragged_away.emit(aspect)
	aspect.aspect_source = slot_type
	add_aspect(aspect)
