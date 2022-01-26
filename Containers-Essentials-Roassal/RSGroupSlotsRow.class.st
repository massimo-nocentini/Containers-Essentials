Class {
	#name : #RSGroupSlotsRow,
	#superclass : #RSGroup,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #creating }
RSGroupSlotsRow class >> var: varLabel box: valueBox labelOrNil: valueLabel [

	| shapes |
	shapes := (Array with: varLabel with: valueBox)
	          ,
	          (valueLabel ifNil: [ #(  ) ] ifNotNil: [ { valueLabel } ]).

	^ self withAll: shapes
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
RSGroupSlotsRow >> var [

	^ self at: 1
]
