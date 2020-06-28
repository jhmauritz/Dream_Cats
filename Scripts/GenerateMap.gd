extends TileMap

var grid = []

func _ready():
	grid.resize(24)
	for n in 24:
		grid[n] = []
		grid [n].resize(24)
		for m in 24:
			if (n%15 == 0 or m%8 == 0) and randi()%20 != 0:
				grid[n][m] = 0
			else:
				grid[n][m] = -1
	
	for n in range (0, 23):
		for m in range (0, 23): 
			set_cell(n, m, grid[n][m])
