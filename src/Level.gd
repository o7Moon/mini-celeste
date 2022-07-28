extends TileMap

signal complete

var playerobj: PackedScene = preload("res://src/Player.tscn")
var strawberry: PackedScene = preload("res://src/strawberry.tscn")

var player = null

func complete()->void:
	emit_signal("complete")

func _ready()->void:
	for tile in get_used_cells():
		var id: int = get_cell(tile.x, tile.y)
		if id == 2:
			#set_cell(tile.x,tile.y,-1)
			var berry = strawberry.instance()
			berry.transform.origin = map_to_world(tile)
			berry.connect("collected",self,"complete")
			add_child(berry)
		if id == 3:
			set_cell(tile.x, tile.y, -1)
			player = playerobj.instance()
			player.transform.origin = map_to_world(tile)
			add_child(player)
		if id == 1:
			$SpikeLayer.set_cell(tile.x, tile.y, 0,is_cell_x_flipped(tile.x,tile.y),is_cell_y_flipped(tile.x,tile.y),is_cell_transposed(tile.x,tile.y))
