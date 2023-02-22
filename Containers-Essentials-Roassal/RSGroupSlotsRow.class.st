Class {
	#name : #RSGroupSlotsRow,
	#superclass : #RSGroup,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #creating }
RSGroupSlotsRow class >> var: varLabel box: valueBox [

	^ self withAll: (Array with: varLabel with: valueBox)
]

{ #category : #accessing }
RSGroupSlotsRow >> box [

	^ self at: 2
]

{ #category : #accessing }
RSGroupSlotsRow >> label [

	^ self at: 3 ifAbsent: [ nil ]
]

{ #category : #accessing }
RSGroupSlotsRow >> label: aShape [

	self assert: self size = 2.

	self add: aShape
]

{ #category : #accessing }
RSGroupSlotsRow >> var [

	^ self at: 1
]
