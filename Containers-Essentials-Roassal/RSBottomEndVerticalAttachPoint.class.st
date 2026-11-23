"
I am a vertical attach point whose lines end at the bottom center of their target shape, moved down by my `endOffset`, where the ones of my superclass end at the top center. They start as those, at the bottom center of the source shape.

`CTDfsPainter` ends its cross lines with me, and `CTTopologicalSortDfsPainter` its back lines.
"
Class {
	#name : 'RSBottomEndVerticalAttachPoint',
	#superclass : 'RSVerticalAttachPoint',
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'public - hooks' }
RSBottomEndVerticalAttachPoint >> basicEndingPointOf: anEdge [

	^ self
		  positionFor: anEdge to
		  in: anEdge
		  point:
		  anEdge to encompassingRectangle bottomCenter + (0 @ endOffset)
]
