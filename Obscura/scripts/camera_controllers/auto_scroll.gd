class_name AutoScroll
extends CameraControllerBase


@export var top_left := Vector2(-10, -8)
@export var bottom_right := Vector2(10, 8)
@export var autoscroll_speed := Vector3(-0.1, 0.0, 0.0)


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()
	
	target.position += autoscroll_speed
	position += autoscroll_speed
	
	#left boundary
	if (target.position.x - target.WIDTH / 2.0) < position.x + top_left.x:
		#print("hit left boundary")
		target.position.x = position.x + top_left.x + target.WIDTH / 2.0
	
	#right boundary
	if (target.position.x + target.WIDTH / 2.0) > position.x + bottom_right.x:
		#print("hit right boundary")
		target.position.x = position.x + bottom_right.x - target.WIDTH / 2.0
	
	#top boundary
	if (target.position.z - target.HEIGHT / 2.0) < position.z + top_left.y:
		#print("hit top boundary")
		target.position.z = position.z + top_left.y + target.HEIGHT / 2.0
	
	#bottom boundary
	if (target.position.z + target.HEIGHT / 2.0) > position.z + bottom_right.y:
		#print("hit bottom boundary")
		target.position.z = position.z + bottom_right.y - target.HEIGHT / 2.0
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left: float = top_left.x 
	var right: float = bottom_right.x
	var top: float = top_left.y
	var bottom: float = bottom_right.y 
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
