"
I am a condition that answers `value:` too, as `cull:`, so that I can take the place of a block with one argument. My other branch is an error: `falsehood` signals it. My subclasses define `truthWitness:`.
"
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
