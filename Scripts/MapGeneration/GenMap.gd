extends Node
class_name Generator

const STEP := [Vector2.LEFT, Vector2.LEFT, Vector2.RIGHT, Vector2.RIGHT, Vector2.DOWN]

export (PackedScene) var Rooms := preload("res://Scenes/Generation_Rooms/PackedRoomScene.tscn")
export var grid_size := Vector2(8,6)

var _rng := RandomNumberGenerator.new()
var _rooms: Rooms = null
var _player: KinematicBody2D = null
var _state := {}
var _horiz_chance := 0.0
var _cam_limits := {}
var _resolution := OS.window_size
var _running := false

onready var camera: Camera2D = $Camera2D
onready var tween: Tween = $Camera2D/Tween
