Class {
	#name : #CTConditionSlotsRowsEmptyOrNotForSynthesize,
	#superclass : #CTCondition,
	#instVars : [
		'quotedShapes',
		'object',
		'shapeBuilder'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionSlotsRowsEmptyOrNotForSynthesize >> falsehood [

	^ quotedShapes
		  at: object
		  ifAbsent: [ shapeBuilder multilineLabel: object ]
]

{ #category : #accessing }
CTConditionSlotsRowsEmptyOrNotForSynthesize >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTConditionSlotsRowsEmptyOrNotForSynthesize >> quotedShapes: anObject [

	quotedShapes := anObject
]

{ #category : #accessing }
CTConditionSlotsRowsEmptyOrNotForSynthesize >> shapeBuilder: anObject [

	shapeBuilder := anObject
]

{ #category : #accessing }
CTConditionSlotsRowsEmptyOrNotForSynthesize >> truthWitness: useless [

	^ RSComposite new
		  model: object;
		  shapes: RSGroup new;
		  extent: 0 @ 0;
		  yourself
]
