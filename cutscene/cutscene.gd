extends Control
var slides = [
	"Welcome to ____ galaxy! We are happy to have you here.",
	"Over the last few years, the galaxy has been struggling to maintain consistent access to healthy and affordable food for planets that are farther from the galaxy hub.",
	"Misson driven and healthy community food stores have been implemented in these areas but have failed to see success in terms of improving food purchasing and consumption patterns.",
	"A new strategy of focusing on community engagement and developing customer relationships through buy-in has been devised.",
	"You have hired on as the manager of a mobile community food store to put these strategies into action."
]
var cur_slide = 0
var walk_time = 3
var clickable = true
enum side {
	LEFT,
	RIGHT
}
var guide_pos = side.RIGHT
func _ready() -> void:
	var x_size = get_viewport().get_visible_rect().size.x
	$AnimationPlayer/Guide.position.x =  x_size  - 150
	$AnimationPlayer/Guide.position.y = get_viewport().get_visible_rect().size.y
	$CutsceneMusic.play()
	$SpeachBubble/InfoLbl.text = slides[cur_slide]
	$AnimationPlayer/Guide.play()

func next_slide() -> void:
	if clickable == false:
		return
	clickable = false
	if cur_slide > (len(slides) - 2):
		global.music_pos = $CutsceneMusic.get_playback_position()
		get_tree().change_scene_to_file("res://character_selection/character_selection.tscn")
	if (cur_slide + 2) % walk_time == 0:
		if guide_pos == side.RIGHT:
			$AnimationPlayer.play("WalkLeft")
			guide_pos = side.LEFT
		else:
			$AnimationPlayer.play("WalkRight")
			guide_pos = side.RIGHT
		await $AnimationPlayer.animation_finished

	cur_slide += 1
	$SpeachBubble/InfoLbl.text = ""
	$AlienVoice.speak(slides[cur_slide])
	var letter = 0
	while letter < len(slides[cur_slide]):
		$SpeachBubble/InfoLbl.text += slides[cur_slide][letter]
		await get_tree().create_timer(0.02).timeout
		letter += 1
	clickable = true
