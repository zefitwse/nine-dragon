extends ColorRect

func _ready():
	# 控制显示隐藏
	$clue1.visible = true
	$clue2.visible = true
	$clue3.visible = true
	$clue4.visible = true
	$clue5.visible = true
	$clue6.visible = true
	
	# 设置文本内容
	$clue1.text = "1、孙、钱二人怎么会在客厅里？而且还都死了？"
	$clue2.text = "2、李翔是自杀还是他杀?"
	$clue3.text = "3、笔记里写的东西为什么如此奇怪、没有逻辑？"
	$clue4.text = "4、对比赵刚的笔记和杜蓉的笔记，它们好像有一处矛盾了？"
	$clue5.text = "5、李翔又是谁杀的？"
	$clue6.text = "6、这四个人又是怎么死的？"
