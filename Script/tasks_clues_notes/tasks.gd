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
	$task1.text = "1、目的地是孤岛上的别墅，船只每隔两天才会前往一次。"
	$task2.text = "2、孙、钱二人的笔记暴露了二人相互指认。很有可能是二人折返的时候，撞见了，然后互相误会，扭打在一起。"
	$task3.text = "3、鼠标在桌子的右侧。右手腕被割腕了。桌子上由白色粉末痕迹。窗户上由细线划过的痕迹。"
	$task4.text = "4、对比赵刚的笔记和杜蓉的笔记，它们好像有一处矛盾了？"
	$task5.text = "5、李翔又是谁杀的？"
	$task6.text = "6、这四个人又是怎么死的？"
