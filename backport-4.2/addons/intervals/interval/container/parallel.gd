@icon("res://addons/intervals/icons/interval_container.png")
extends IntervalContainer
class_name Parallel
## An IntervalContainer that plays all of its elements simultaneously.

func _onto_tween(tween: Tween):
	if not intervals:
		return
	if OS.has_feature("editor"):
		for ival in intervals:
			# 4.2 backport: 'foo is not Type' isn't supported in 4.2.
			#assert(ival is not IntervalContainer, "Parallels cannot contain other containers (bug)")
			assert(!(ival is IntervalContainer), "Parallels cannot contain other containers (bug)")
	intervals[0]._onto_tween(tween)
	for ival in intervals.slice(1):
		tween.parallel()
		ival._onto_tween(tween)