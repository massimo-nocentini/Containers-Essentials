Class {
	#name : #CTConditionDfsWalkerCollectDescriptors,
	#superclass : #CTConditionValueable,
	#instVars : [
		'object',
		'level',
		'shape',
		'widths_Association',
		'metaExtent',
		'rows',
		'walker'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> metaExtent: anObject [

	metaExtent := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> rows: anObject [

	rows := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> shouldntSkip: child descriptor: descriptor [

	| slotsRow |
	slotsRow := walker
		            child: child
		            descriptor: descriptor
		            at: level
		            parent: object
		            shape: shape
		            widths_Association: widths_Association
		            metaExtent: metaExtent.

	rows add: slotsRow
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> truthWitness: descriptor [

	| child |
	child := descriptor on: object walker: walker.

	^ CTConditionDfsWalkerShouldSkip new
		  caller: self;
		  child: child;
		  descriptor: descriptor;
		  ifTrueIfFalse: (walker shouldSkip: child)
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> walker: anObject [

	walker := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerCollectDescriptors >> widths_Association: anObject [

	widths_Association := anObject
]
