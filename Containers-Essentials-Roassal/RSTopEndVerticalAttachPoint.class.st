Class {
	#name : #RSTopEndVerticalAttachPoint,
	#superclass : #RSVerticalAttachPoint,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'public - hooks' }
RSTopEndVerticalAttachPoint >> basicEndingPointOf: anEdge [

	^ self
		  positionFor: anEdge to
		  in: anEdge
		  point:
		  anEdge to encompassingRectangle topCenter + (0 @ endOffset)
]
