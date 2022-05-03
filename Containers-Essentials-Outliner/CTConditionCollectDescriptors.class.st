Class {
	#name : #CTConditionCollectDescriptors,
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
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionCollectDescriptors >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> metaExtent: anObject [

	metaExtent := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> rows: anObject [

	rows := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> shouldntSkip: child descriptor: descriptor [

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
CTConditionCollectDescriptors >> truthWitness: descriptor [

	| child |
	child := descriptor on: object walker: walker.

	^ CTConditionShouldSkip new
		  caller: self;
		  child: child;
		  descriptor: descriptor;
		  ifTrueIfFalse: (walker shouldSkip: child)
]

{ #category : #accessing }
CTConditionCollectDescriptors >> walker: anObject [

	walker := anObject
]

{ #category : #accessing }
CTConditionCollectDescriptors >> widths_Association: anObject [

	widths_Association := anObject
]
