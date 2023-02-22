"
I am a variant that stops the visit and provides an already built shape to be referenced in a slot.
"
Class {
	#name : #CTQuoteSlotDescriptor,
	#superclass : #CTDecorateSlotDescriptor,
	#instVars : [
		'shape',
		'quoteBlock',
		'witness'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTQuoteSlotDescriptor >> quoteBlock: aBlock [

	quoteBlock := aBlock
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	| value |
	value := super valueOn: anObject walker: aDfsWalker.

	"We need to pass a copy of the original walker because of the
	 intermediate data structures populated during the search: such
	 data structures should be fresh when we start a quotation."
	shape := quoteBlock value: value value: aDfsWalker copy.

	self assert: (shape isKindOf: RSShape).

	witness := Object new.

	aDfsWalker addQuotedShape: shape model: witness.

	^ witness
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> valueShapeOf: anObject walker: aDfsWalker [

	^ shape
]
