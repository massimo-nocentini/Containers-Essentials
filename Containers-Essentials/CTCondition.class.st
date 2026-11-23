"
I am an abstract condition: an object that takes the place of both blocks of a test, as I answer `cull:`, for the branch where the test holds, and `value`, for the other one. My subclasses say what to do:

- `truthWitness:`, sent by `cull:`, takes the object that the test found.
- `falsehood`, sent by `value`, takes no argument.

I make the test too:

- `ifTrueIfFalse:` tests a Boolean, with nil as the witness, and `ifTrueIfFalse:truthWitness:` with the given one.
- `ifEmptyIfNotEmpty:` tests whether a collection is not empty; the witness is the collection.
- `lookupInDictionary:at:` tests whether a dictionary has a key; the witness is its value.

```smalltalk
| condition |
condition := (CTCondition newAnonymousSubclass
	compile: 'truthWitness: anObject ^ anObject squared';
	compile: 'falsehood ^ 0';
	yourself) requestor: nil data: nil.
condition lookupInDictionary: { #a -> 3 } asDictionary at: #a.
	""9""
condition lookupInDictionary: { #a -> 3 } asDictionary at: #b
	""0""
```

`requestor:data:` makes me. I keep both arguments in my instance variables, and none of my methods reads them.
"
Class {
	#name : 'CTCondition',
	#superclass : 'Object',
	#instVars : [
		'requestor',
		'data'
	],
	#category : 'Containers-Essentials-Conditions',
	#package : 'Containers-Essentials',
	#tag : 'Conditions'
}

{ #category : 'instance creation' }
CTCondition class >> requestor: requestor data: data [

	^ self basicNew
		  requestor: requestor;
		  data: data;
		  initialize;
		  yourself
]

{ #category : 'accessing' }
CTCondition >> cull: anObject [

	^ self truthWitness: anObject
]

{ #category : 'accessing' }
CTCondition >> data: anObject [

	data := anObject
]

{ #category : 'accessing' }
CTCondition >> falsehood [

	self subclassResponsibility
]

{ #category : 'API' }
CTCondition >> ifEmptyIfNotEmpty: collection [

	^ collection ifEmpty: self ifNotEmpty: self
]

{ #category : 'API' }
CTCondition >> ifTrueIfFalse: bool [

	^ self ifTrueIfFalse: bool truthWitness: nil
]

{ #category : 'API' }
CTCondition >> ifTrueIfFalse: bool truthWitness: anObject [

	^ bool
		  ifTrue: [ self cull: anObject ]
		  ifFalse: self
]

{ #category : 'API' }
CTCondition >> lookupInDictionary: dict at: key [

	^ dict at: key ifPresent: self ifAbsent: self
]

{ #category : 'accessing' }
CTCondition >> requestor: anObject [

	requestor := anObject
]

{ #category : 'accessing' }
CTCondition >> truthWitness: anObject [

	self subclassResponsibility
]

{ #category : 'accessing' }
CTCondition >> value [

	^ self falsehood
]
