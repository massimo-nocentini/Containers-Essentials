Class {
	#name : #RSVerticalLineLayoutWithGoldenGaps,
	#superclass : #RSVerticalLineLayout,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #applying }
RSVerticalLineLayoutWithGoldenGaps >> applyOn: elements [

	| gap |
	gap := elements size < 2
		       ifTrue: [ 0 ]
		       ifFalse: [ 
			       | height ratio |
			       height := (elements allButLast collect: [ :each | 
				                  each height ]) sum.
			       ratio := (elements size + 1) goldenRatiosLower last
			                / (elements size - 1).
			       height * ratio ].

	self verticalGap: gap.

	^ super applyOn: elements
]
