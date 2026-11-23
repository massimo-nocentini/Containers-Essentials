"
I am a vertical attach point whose lines end at the top center of their target shape, moved down by my `endOffset`, as those of my superclass do. `CTDfsPainter` ends the lines to postponed objects with me.
"
Class {
	#name : 'RSTopEndVerticalAttachPoint',
	#superclass : 'RSVerticalAttachPoint',
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'public - hooks' }
RSTopEndVerticalAttachPoint >> basicEndingPointOf: anEdge [

	^ self
		  positionFor: anEdge to
		  in: anEdge
		  point:
		  anEdge to encompassingRectangle topCenter + (0 @ endOffset)
]
