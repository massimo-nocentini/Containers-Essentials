Class {
	#name : #CTConditionValueable,
	#superclass : #CTCondition,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionValueable >> falsehood [

	Error signal
]

{ #category : #accessing }
CTConditionValueable >> value: object [

	^ self cull: object
]
