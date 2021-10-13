extends Area2D

var count := 0


func _on_stand_area_body_entered(body):
	count+=1


func _on_stand_area_body_exited(body):
	count-=1
