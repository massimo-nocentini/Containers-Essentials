Class {
	#name : #RSBottomEndVerticalAttachPoint,
	#superclass : #RSVerticalAttachPoint,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'public - hooks' }
RSBottomEndVerticalAttachPoint >> basicEndingPointOf: anEdge [
	^ self 
		positionFor: anEdge to 
		in: anEdge 
		point: anEdge to encompassingRectangle bottomCenter + (0@endOffset)
]
