class_name PositionLerp
extends CameraControllerBase

@export var crosshair_length: float = 5
@export var follow_speed: float = 10.0
@export var hyper_follow_speed: float = 28.0
@export var catchup_speed: float = 6.0
@export var leash_distance: float = 300.0


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	#var direction_to_target: Vector3 = (target.global_position - global_position).normalized()
	#if target.hyperspeed_active:
		#leash_distance *= 2
	#if global_position.distance_to(target.global_position) > leash_distance:
		#global_position = target.global_position - direction_to_target * leash_distance
		#
	#var target_position:Vector3 = target.position
	#var speed = 0.0
	#
	#if target.velocity != Vector3.ZERO:
		#if target.hyperspeed_active:
			#speed = hyper_follow_speed * 10
		#else:
			#speed = follow_speed * 70
	#else:
		#speed = catchup_speed * 50
		#
	#var distance = position.distance_to(target_position)
	#var move_step = speed * delta
	#
	#if move_step < distance:
		#position += direction_to_target * move_step
	#else:
		#position = target_position

	var direction_to_target: Vector3 = (target.global_position - global_position).normalized()
	
	var leash: float = leash_distance
	if target.hyperspeed_active:
		leash = leash_distance * 3
	
	if position.distance_to(target.global_position) > leash:
		#global_position = target.global_position - direction_to_target * leash
		global_position = global_position.lerp(target.global_position - direction_to_target * leash, target.speed * delta)

	if target.velocity != Vector3.ZERO and target.hyperspeed_active:
		global_position = global_position.lerp(target.global_position, hyper_follow_speed * delta)
	elif target.velocity != Vector3.ZERO and not target.hyperspeed_active:
		global_position = global_position.lerp(target.global_position, follow_speed * delta)
	elif target.velocity == Vector3.ZERO:
		global_position = global_position.lerp(target.global_position, catchup_speed * delta)
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var horizontal: float = -crosshair_length
	var vertical: float = crosshair_length

	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(vertical, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-vertical, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, horizontal))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -horizontal))


	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
