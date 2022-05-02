Class {
	#name : #CTConditionQuotedShapeBackgroundColor,
	#superclass : #CTCondition,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionQuotedShapeBackgroundColor >> falsehood [

	
]

{ #category : #accessing }
CTConditionQuotedShapeBackgroundColor >> truthWitness: valueBox [

	valueBox color: Color transparent
]
