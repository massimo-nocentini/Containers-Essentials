Class {
	#name : 'CTConditionValueable',
	#superclass : 'CTCondition',
	#category : 'Containers-Essentials-Conditions',
	#package : 'Containers-Essentials',
	#tag : 'Conditions'
}

{ #category : 'accessing' }
CTConditionValueable >> falsehood [

	Error signal
]

{ #category : 'accessing' }
CTConditionValueable >> value: object [

	^ self cull: object
]
