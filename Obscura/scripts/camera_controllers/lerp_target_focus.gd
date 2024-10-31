class_name LerpTargetFocus
extends CameraControllerBase


@export var crosshair_length: float = 5
@export var lead_speed: float = 11.0
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 10.0
@export var catchup_delay_duration: float = 1.0

var timer: float = 0.0

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()
	
	var direction_to_target: Vector3 = (target.global_position - global_position).normalized()
	
	if timer > 0:
		timer -= delta
	
	if global_position.distance_to(target.global_position) > leash_distance:
		# Position the camera ahead of the target, along its velocity direction
		var lead_position = target.global_position + (target.velocity.normalized() * leash_distance)
		global_position = global_position.lerp(lead_position, lead_speed * delta)
		timer = catchup_delay_duration
	
	elif target.velocity != Vector3.ZERO:
		var lead_position = target.global_position + (target.velocity.normalized() * leash_distance)
		global_position = global_position.lerp(lead_position, lead_speed * delta)
		timer = catchup_delay_duration
	elif target.velocity == Vector3.ZERO and timer <= 0:
		global_position = global_position.lerp(target.global_position, catchup_speed * delta)
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var horizontal:float = -crosshair_length
	var vertical:float = crosshair_length
	
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
