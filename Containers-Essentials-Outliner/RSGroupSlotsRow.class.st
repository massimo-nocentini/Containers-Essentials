"
I am a variant of RSGroup that takes care of a row of shapes that appears in an outliner `RSComposite` shape.
"
Class {
	#name : 'RSGroupSlotsRow',
	#superclass : 'RSGroup',
	#instVars : [
		'descriptor'
	],
	#category : 'Containers-Essentials-Outliner-Roassal',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Roassal'
}

{ #category : 'creating' }
RSGroupSlotsRow class >> var: varLabel box: valueBox [

	^ self withAll: (Array with: varLabel with: valueBox)
]

{ #category : 'accessing' }
RSGroupSlotsRow >> box [

	^ self at: 2
]

{ #category : 'accessing' }
RSGroupSlotsRow >> descriptor [

	^ descriptor
]

{ #category : 'accessing' }
RSGroupSlotsRow >> descriptor: anObject [

	descriptor := anObject
]

{ #category : 'accessing' }
RSGroupSlotsRow >> label [

	^ self at: 3 ifAbsent: [ nil ]
]

{ #category : 'accessing' }
RSGroupSlotsRow >> label: aShape [

	self assert: self size = 2.

	self add: aShape
]

{ #category : 'accessing' }
RSGroupSlotsRow >> var [

	^ self at: 1
]
