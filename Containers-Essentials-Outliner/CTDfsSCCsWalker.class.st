Class {
	#name : #CTDfsSCCsWalker,
	#superclass : #CTDfsWalker,
	#instVars : [
		'sccShapeStack',
		'sccs'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #shapes }
CTDfsSCCsWalker >> addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape [

	super addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape.

	aDescriptor addHighlightInteractionOnShape: aShape
]

{ #category : #DFS }
CTDfsSCCsWalker >> createStronglyConnectedComponentIfNecessaryOnShape: aShape [

	self
		assert: aShape propertyDfsEntryTime isNotNil;
		assert: aShape propertyDfsLowlink isNotNil.

	aShape propertyDfsEntryTime = aShape propertyDfsLowlink ifTrue: [ 
		| scc |
		scc := sccs add: OrderedCollection new.

		[ 
		sccShapeStack isNotNil and: [ 
			sccShapeStack value propertyDfsEntryTime
			>= aShape propertyDfsEntryTime ] ] whileTrue: [ 
			| shape |
			shape := sccShapeStack value
				         propertyDfsSCC: scc;
				         propertyDfsObjectStack: nil;
				         yourself.

			scc add: shape.

			sccShapeStack := sccShapeStack nextLink ].

		self assert: aShape propertyDfsSCC == scc ]
]

{ #category : #DFS }
CTDfsSCCsWalker >> hasBeenVisited: childShape childOfShape: parentShape [

	| shapeEntryTime |
	super hasBeenVisited: childShape childOfShape: parentShape.

	shapeEntryTime := childShape propertyDfsEntryTime.

	(childShape propertyDfsIsOnObjectStack and: [ 
		 shapeEntryTime < parentShape propertyDfsEntryTime ]) ifTrue: [ 
		parentShape propertyDfsLowlinkUpdate: [ :lowlink | 
			lowlink min: shapeEntryTime ].

		self assert: parentShape model ~~ childShape model ]
]

{ #category : #DFS }
CTDfsSCCsWalker >> hasntBeenVisited: object descriptor: descriptor data: data [

	| childShape |
	childShape := super
		              hasntBeenVisited: object
		              descriptor: descriptor
		              data: data.

	data shape propertyDfsLowlinkUpdate: [ :lowlink | 
		lowlink min: childShape propertyDfsLowlink ].

	^ childShape
]

{ #category : #initialization }
CTDfsSCCsWalker >> initialize [

	super initialize.
	
	sccShapeStack := nil.

	self stronglyConnectedComponents: OrderedCollection new
]

{ #category : #copying }
CTDfsSCCsWalker >> postCopy [

	super postCopy.

	sccShapeStack := nil.

	self stronglyConnectedComponents: sccs class new
]

{ #category : #accessing }
CTDfsSCCsWalker >> push: aShape [

	sccShapeStack := ValueLink new
		                 value: aShape;
		                 nextLink: sccShapeStack;
		                 yourself
]

{ #category : #DFS }
CTDfsSCCsWalker >> recordDfsTimingsOnShape: aShape [

	super recordDfsTimingsOnShape: aShape.

	self createStronglyConnectedComponentIfNecessaryOnShape: aShape
]

{ #category : #accessing }
CTDfsSCCsWalker >> stronglyConnectedComponents: aCollection [

	sccs := aCollection
]

{ #category : #API }
CTDfsSCCsWalker >> value: rootObject [

	| shape |
	shape := super value: rootObject.

	self assert: sccShapeStack isNil.

	^ shape
]

{ #category : #shapes }
CTDfsSCCsWalker >> visiting: object shape: shape [

	super visiting: object shape: shape.

	self push: shape.

	shape
		propertyDfsObjectStack: sccShapeStack;
		propertyDfsLowlink: dfsClock
]