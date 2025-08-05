extends ColorRect

func _ready():
	# 控制显示隐藏
	$task1.visible = true
	$task2.visible = true
	$task3.visible = true
	$task4.visible = true
	$task5.visible = true
	$task6.visible = true
	
	# 设置文本内容
	$task1.text = "1、孙、钱二人怎么会在客厅里？而且还都死了？"
	$task2.text = "2、李翔是自杀还是他杀?"
	$task3.text = "3、笔记里写的东西为什么如此奇怪、没有逻辑？"
	$task4.text = "4、对比赵刚的笔记和杜蓉的笔记，它们好像有一处矛盾了？"
	$task5.text = "5、李翔又是谁杀的？"
	$task6.text = "6、这四个人又是怎么死的？"
	
