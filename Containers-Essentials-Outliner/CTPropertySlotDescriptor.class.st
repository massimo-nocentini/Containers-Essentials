"
I describe a single slot in an outline shape.
"
Class {
	#name : #CTPropertySlotDescriptor,
	#superclass : #Object,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTPropertySlotDescriptor >> addDraggableInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> addHighlightInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> addPopupInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> noHeader [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> on: anObject walker: aDfsWalker [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> quote [

	^ self quote: [ :aShape :aDfsWalker | aShape ]
]

{ #category : #accessing }
CTPropertySlotDescriptor >> quote: aBlock [

	^ CTQuoteSlotDescriptor new
		  quoteBlock: aBlock;
		  descriptor: self;
		  yourself
]

{ #category : #accessing }
CTPropertySlotDescriptor >> selector [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> shape: anObject walker: aDfsWalker [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	self subclassResponsibility
]
