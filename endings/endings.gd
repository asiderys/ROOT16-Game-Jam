extends Node2D

enum outcomes {
	GOOD = 0,
	NEUTRAL = 1,
	BAD = 2
}
var msgs = [
	"Overall you did great, and improved upon the model of community stores in this galaxy.",
	"While your store was beneficial it could have improved upon existing model more through stronger connections with the community",
	"Your store did not have strong enough connections with the community to create a large impact in this galaxy."
]
var soundfx = [
	"res://sound_effects/goodending.mp3",
	"res://sound_effects/neutralending.mp3",
	"res://sound_effects/badending.mp3"
]
var good_profits = 700
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ending
	if (global.trust > 60) and (global.money > good_profits):
		ending = outcomes.GOOD
	elif (global.trust <= 60) and (global.trust >= 40):
		ending = outcomes.NEUTRAL
	else:
		ending = outcomes.BAD
	
	$GoomiGami.play()
	$PT.play()
	$sausage.play()
	$StrangeSteve.play()
	$SimpleStats/TrustLbl.text = "Total trust: " + str(global.trust)
	$SimpleStats/ProfitsLbl.text = "Total profits: " + str(global.money)
	var final_path = ""
	if ending == outcomes.GOOD:
		final_path = " 1"
	elif ending == outcomes.NEUTRAL:
		final_path = "_neutral"
	else:
		final_path = "_sad"
	for alien in $Dynamic.get_children():
		print("res://art/aliens/" + alien.name + "/" + alien.name + final_path + ".png")
		alien.texture = load("res://art/aliens/" + alien.name + "/" + alien.name + final_path + ".png")
	$SoundEffect.stream = load(soundfx[ending])
	$SoundEffect.play()
	$Fade.play("fade_in")
	await $SoundEffect.finished
	$Music.play()
	await get_tree().create_timer(3.5).timeout
	$SimpleStats.visible = false
	$StatsMsg.visible = true
	if (ending == outcomes.GOOD):
		$StatsMsg.text = "Congrats! You did a great job. You finished with a trust meter of " + str(global.trust) +  "% and positive profits!"
		await get_tree().create_timer(6).timeout
		$StatsMsg.size.x = 732
		$StatsMsg.position.x -= (731-531)/2
		$StatsMsg.text = "You successfully developed great community relations, so your store was trusted enough by your customers to support and fulfill the community’s needs to aid in their issues with accessibility to healthy and affordable food."
		await get_tree().create_timer(9).timeout
		$StatsMsg.position.x += (731-531)/2
		$StatsMsg.size.x = 531
		$StatsMsg.text = "Thank you for coming to this planet, we can now follow your store framework to implement impactful and effective community stores!"
		await get_tree().create_timer(6).timeout
		$StatsMsg.visible = false
		$LogoAnimator.play("logo")
	elif (ending == outcomes.NEUTRAL):
		var neutralMsg = ""
		if (global.trust > 60) and (global.money > good_profits):
			neutralMsg = ["Good job. You finished with a trust meter of " + str(global.trust) + " and positive profits.",
				"You kept the store going with smart business decisions and did a decent job of developing customer relations. "
			]
		elif (global.trust <= 60) and (global.trust >= 40):
			neutralMsg = [
				"You did an ok job of creating customer relationships and community engagement but were not successful in maintaining your shop’s profits.",
				"Well it is important to sustain community relationships, maybe you can find some new strategies to balance relationships with buisiness."
			]
		else:
			neutralMsg = [
				"You were successful with making good business decisions but could’ve done a better job of creating customer relations and catering to the community.",
				"It is important to focus not only on profit, but also engaging the community through policy and outreach if you want to make an impact."
			]
		$StatsMsg.text = neutralMsg[0]
		await get_tree().create_timer(7).timeout
		
		$StatsMsg.text = neutralMsg[1]
		await get_tree().create_timer(7).timeout
		$StatsMsg.size.x = 732
		$StatsMsg.position.x -= (731-531)/2
		$StatsMsg.text = "Thank you for coming to our planet, you've left us with some help in getting food. Maybe if you play again you can think of more solutions improve community stores."
		await get_tree().create_timer(7).timeout
		$StatsMsg.visible = false
		$LogoAnimator.play("logo")
	elif (ending == outcomes.BAD):
		$StatsMsg.text = "Sorry, it looks like your business was not able to succeed well."
		await get_tree().create_timer(5).timeout
		$StatsMsg.size.x = 732
		$StatsMsg.position.x -= (731-531)/2
		$StatsMsg.text = "Your store was not able to create a strong enough relationship with the community to been seen as benefical, and also did not make enough profit to be sustainabe."
		await get_tree().create_timer(9).timeout
		$StatsMsg.position.x += (731-531)/2
		$StatsMsg.size.x = 531
		$StatsMsg.text = "Maybe next time you can consider things such as policy, community involvment, and meeting customers needs to create a longer lasting impact on this planet."
		await get_tree().create_timer(7).timeout
		$StatsMsg.visible = false
		$LogoAnimator.play("logo")
