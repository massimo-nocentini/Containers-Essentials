Class {
	#name : #RSSlotRow,
	#superclass : #RSComposite,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #creating }
RSSlotRow class >> var: varLabel box: valueBox label: valueLabel [

	^ self new
		  shapes: (Array with: varLabel with: valueBox)
			  , (valueLabel ifNil: [ #(  ) ] ifNotNil: [ { valueLabel } ]);
		  yourself
]

{ #category : #accessing }
RSSlotRow >> box [

	^ self shapes second
]

{ #category : #accessing }
RSSlotRow >> label [

	^ self shapes at: 3 ifAbsent: [ nil ]
]

{ #category : #accessing }
RSSlotRow >> var [

	^ self shapes first
]
