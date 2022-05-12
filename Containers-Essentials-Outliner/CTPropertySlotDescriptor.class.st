"
I describe a single slot in an outline shape.
"
Class {
	#name : #CTPropertySlotDescriptor,
	#superclass : #Object,
	#category : #'Containers-Essentials-Outliner-Slots'
}

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
CTPropertySlotDescriptor >> enabled [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> header: aBlock [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> header: anObject walker: aShapeBuilder [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> headerWithAllSuperclasses [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> headerWithClass [

	self subclassResponsibility
]

{ #category : #delegating }
CTPropertySlotDescriptor >> ifHasFollowers: block walker: walker [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	self subclassResponsibility
]

{ #category : #testing }
CTPropertySlotDescriptor >> isOneToMany: anObject walker: aDfsWalker [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> noHeader [

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
CTPropertySlotDescriptor >> quoteGroupWithModel: anObject [

	^ self quote: [ :aGroup :aDfsWalker | aGroup asShapeFor: anObject ]
]

{ #category : #accessing }
CTPropertySlotDescriptor >> quoteUsingSelector [

	^ self quote: [ :anObject :aDfsWalker | 
		  anObject perform: self selector with: aDfsWalker ]
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
CTPropertySlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	self subclassResponsibility
]

{ #category : #accessing }
CTPropertySlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	self subclassResponsibility
]
