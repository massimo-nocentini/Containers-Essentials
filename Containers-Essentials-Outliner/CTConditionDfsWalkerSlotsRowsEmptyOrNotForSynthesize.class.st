Class {
	#name : #CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize,
	#superclass : #CTCondition,
	#instVars : [
		'quotedShapes',
		'object',
		'shapeBuilder'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize >> falsehood [

	^ quotedShapes
		  at: object
		  ifAbsent: [ shapeBuilder multilineLabel: object ]
]

{ #category : #accessing }
CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize >> quotedShapes: anObject [

	quotedShapes := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize >> shapeBuilder: anObject [

	shapeBuilder := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize >> truthWitness: useless [

	^ RSComposite new
		  model: object;
		  shapes: RSGroup new;
		  extent: 0 @ 0;
		  yourself
]
