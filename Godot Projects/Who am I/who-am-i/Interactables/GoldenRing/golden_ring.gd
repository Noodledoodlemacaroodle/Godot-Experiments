extends StaticBody3D
@onready var list_of_lines: Node = $"List of Lines"
var current_label: Label
var player : CharacterBody3D





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_label = list_of_lines.get_child(0)
	player = get_tree().get_first_node_in_group("Player")
	#print(current_label)
	#max_lines = list_of_lines.get_child_count()
	##amount_of_lines = list_of_lines.get_children()
	#for i in list_of_lines.get_children():
		#amount_of_lines.get_or_add(i,i.text)
	#


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dialogue(label : RichTextLabel):
	var current_children : int = current_label.get_child_count()
	if current_children > 0:
		label.text = current_label.text
		current_label = current_label.get_child(0)
		print(current_label)
		
	else:
		label.text = current_label.text
		end_of_dialogue_event()
		
		
		
		
		
		
		##for i in amount_of_lines:
			#label.text = amount_of_lines.get(current_line)
			#current_line +=1
			##break
func end_of_dialogue_event():
	queue_free()
	
	
