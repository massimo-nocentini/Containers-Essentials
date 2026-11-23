"
I am a controller of the control points of a Bezier line with three of them. The middle one is 40% of the distance between the two ends away from the start, along the line, and 40% of it away from the line, on the other side with respect to my superclass: the curve bends the opposite way.

```smalltalk
RSDirectedBezierConcavityCPAPController new
	controlPointsFrom: 0 @ 0
	to: 100 @ 0
	""{ 0@0. 40.0@40.0. 100@0 }""
```

`CTDfsPainter` and `CTTopologicalSortDfsPainter` use me for the lines of the outliners.
"
Class {
	#name : 'RSDirectedBezierConcavityCPAPController',
	#superclass : 'RSDirectedBezierCPAPController',
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'hooks' }
RSDirectedBezierConcavityCPAPController >> controlPointsFrom: fromPoint to: toPoint [

	| vector u unit midPoint height width dist |
	dist := fromPoint distanceTo: toPoint.
	height := dist * 0.40.
	width := dist * 0.40.
	vector := fromPoint - toPoint.
	u := vector normal.
	unit := vector / (vector r max: 1).
	midPoint := fromPoint - (unit * height) - (u * width).
	^ { 
		  fromPoint.
		  midPoint.
		  toPoint }
]
