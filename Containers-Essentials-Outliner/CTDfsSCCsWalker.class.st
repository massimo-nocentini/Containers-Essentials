"
I also take care of Strongly Connected Components (also see 
Tarjan, R. E. (1972), ""Depth-first search and linear graph algorithms"", 
SIAM Journal on Computing, 1 (2): 146–160).
"
Class {
	#name : 'CTDfsSCCsWalker',
	#superclass : 'CTDfsWalker',
	#instVars : [
		'sccShapeStack',
		'sccs'
	],
	#category : 'Containers-Essentials-Outliner-Walkers',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Walkers'
}

{ #category : 'shapes' }
CTDfsSCCsWalker >> addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape [

	super addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape.

	aDescriptor addHighlightInteractionOnShape: aShape
]

{ #category : 'DFS' }
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

{ #category : 'DFS' }
CTDfsSCCsWalker >> entering: data [

	| s |
	super entering: data.

	s := self push: data shape.

	s
		propertyDfsObjectStack: sccShapeStack;
		propertyDfsLowlink: dfsClock
]

{ #category : 'DFS' }
CTDfsSCCsWalker >> exiting: data [

	super exiting: data.

	self createStronglyConnectedComponentIfNecessaryOnShape: data shape
]

{ #category : 'DFS' }
CTDfsSCCsWalker >> hasBeenVisited: child childShape: childShape parentShape: parentShape [

	| shapeEntryTime |
	super
		hasBeenVisited: child
		childShape: childShape
		parentShape: parentShape.

	shapeEntryTime := childShape propertyDfsEntryTime.

	(childShape propertyDfsIsOnObjectStack and: [ 
		 shapeEntryTime < parentShape propertyDfsEntryTime ]) ifTrue: [ 
		parentShape propertyDfsLowlinkUpdate: [ :lowlink | 
			lowlink min: shapeEntryTime ].

		self assert: parentShape model ~~ childShape model ]
]

{ #category : 'DFS' }
CTDfsSCCsWalker >> hasntBeenVisited: object descriptor: descriptor data: data [

	| childShape |
	super hasntBeenVisited: object descriptor: descriptor data: data.

	childShape := toShapes at: object.

	data shape propertyDfsLowlinkUpdate: [ :lowlink | 
		lowlink min: childShape propertyDfsLowlink ]
]

{ #category : 'initialization' }
CTDfsSCCsWalker >> initialize [

	super initialize.
	
	sccShapeStack := nil.

	self stronglyConnectedComponents: OrderedCollection new
]

{ #category : 'copying' }
CTDfsSCCsWalker >> postCopy [

	super postCopy.

	sccShapeStack := nil.

	self stronglyConnectedComponents: sccs class new
]

{ #category : 'accessing' }
CTDfsSCCsWalker >> push: aShape [

	sccShapeStack := ValueLink new
		                 value: aShape;
		                 nextLink: sccShapeStack;
		                 yourself.

	^ aShape
]

{ #category : 'accessing' }
CTDfsSCCsWalker >> stronglyConnectedComponents: aCollection [

	sccs := aCollection
]

{ #category : 'API' }
CTDfsSCCsWalker >> value: rootObject [

	| shape |
	shape := super value: rootObject.

	self assert: sccShapeStack isNil.

	^ shape
]
