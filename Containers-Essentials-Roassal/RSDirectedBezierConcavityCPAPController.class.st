Class {
	#name : #RSDirectedBezierConcavityCPAPController,
	#superclass : #RSDirectedBezierCPAPController,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #hooks }
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
