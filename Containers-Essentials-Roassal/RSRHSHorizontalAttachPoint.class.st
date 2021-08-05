Class {
	#name : #RSRHSHorizontalAttachPoint,
	#superclass : #RSHorizontalAttachPoint,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'public - hooks' }
RSRHSHorizontalAttachPoint >> basicEndingPointOf: edge [
	^ self 
		positionFor: edge to 
		in: edge 
		point: edge to encompassingRectangle rightCenter + (endOffset@0)
]
