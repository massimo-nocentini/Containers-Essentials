"
I am a condition with only the branch where the test holds: my `falsehood` answers nil, as `ifTrue:` does when the receiver is false. My subclasses define `truthWitness:`.
"
Class {
	#name : 'CTConditionIfTrue',
	#superclass : 'CTCondition',
	#category : 'Containers-Essentials-Conditions',
	#package : 'Containers-Essentials',
	#tag : 'Conditions'
}

{ #category : 'accessing' }
CTConditionIfTrue >> falsehood [

	"According to True>>#ifFalse:"

	^ nil
]
