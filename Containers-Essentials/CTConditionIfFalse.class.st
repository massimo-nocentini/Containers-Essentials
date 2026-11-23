"
I am a condition without the branch where the test holds: my `truthWitness:` answers nil, as `ifFalse:` does when the receiver is true. My subclasses define `falsehood`.
"
Class {
	#name : 'CTConditionIfFalse',
	#superclass : 'CTCondition',
	#category : 'Containers-Essentials-Conditions',
	#package : 'Containers-Essentials',
	#tag : 'Conditions'
}

{ #category : 'accessing' }
CTConditionIfFalse >> truthWitness: anObject [

	"According to False>>#ifTrue:"

	^ nil
]
