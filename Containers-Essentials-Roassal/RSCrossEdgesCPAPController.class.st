Class {
	#name : #RSCrossEdgesCPAPController,
	#superclass : #RSHorizontalCPAPController,
	#instVars : [
		'inner'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #hooks }
RSCrossEdgesCPAPController >> controlPointsFrom: from to: to [

	| x y offset mult random |
	random := RandomGaussian new mu: Float goldenRatio.
	offset := Float goldenRatio double double.
	x := from x + offset + random next abs.
	mult := inner
		        ifTrue: [ 1 ]
		        ifFalse: [ -1 ].
	y := to y + (mult * (offset half + random next abs)).
	^ Array
		  with: from
		  with: x @ from y
		  with: x @ y
		  with: to x @ y
		  with: to
]

{ #category : #initialization }
RSCrossEdgesCPAPController >> initialize [

	super initialize.

	inner := false
]

{ #category : #initialization }
RSCrossEdgesCPAPController >> inner [

	inner := true
]
