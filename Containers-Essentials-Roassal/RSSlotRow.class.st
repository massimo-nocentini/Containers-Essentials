Class {
	#name : #RSSlotRow,
	#superclass : #RSGroup,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #creating }
RSSlotRow class >> var: varLabel box: valueBox labelOrNil: valueLabel [

	| shapes |
	shapes := (Array with: varLabel with: valueBox)
	          ,
	          (valueLabel ifNil: [ #(  ) ] ifNotNil: [ { valueLabel } ]).

	^ self withAll: shapes
]

{ #category : #accessing }
RSSlotRow >> box [

	^ self at: 2
]

{ #category : #accessing }
RSSlotRow >> label [

	^ self at: 3 ifAbsent: [ nil ]
]

{ #category : #accessing }
RSSlotRow >> var [

	^ self at: 1
]
