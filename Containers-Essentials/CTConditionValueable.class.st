Class {
	#name : #CTConditionValueable,
	#superclass : #CTCondition,
	#category : #'Containers-Essentials-Conditions'
}

{ #category : #accessing }
CTConditionValueable >> falsehood [

	Error signal
]

{ #category : #accessing }
CTConditionValueable >> value: object [

	^ self cull: object
]
