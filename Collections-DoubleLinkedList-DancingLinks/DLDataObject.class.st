Class {
	#name : #DLDataObject,
	#superclass : #Object,
	#instVars : [
		'ns',
		'we',
		'column',
		'point',
		'model'
	],
	#category : #'Collections-DoubleLinkedList-DancingLinks-dancing objects'
}

{ #category : #'instance creation' }
DLDataObject class >> gridOn: aCollection [
	| rootObj columns rows headers allObjs |
	aCollection
		sort: [ :vAssoc :wAssoc | 
			| v w |
			v := vAssoc key.
			w := wAssoc key.
			v y <= w y and: [ v x <= w x ] ].
	allObjs := Dictionary new.
	headers := DoubleLinkedList new.
	columns := Dictionary new.
	rows := Dictionary new.
	rootObj := DLRootObject new
		addInDoubleLinkedList: headers direction: #we;
		yourself.
	allObjs at: #root put: rootObj.
	aCollection
		do: [ :anAssociation | 
			| aPoint columnObj dataObj column row |
			aPoint := anAssociation key.
			column := columns
				at: aPoint y
				ifAbsentPut: [ | headerObj newColumn |
					headerObj := DLColumnObject new
						size: 0;
						root: rootObj;
						yourself.
					newColumn := DoubleLinkedList new.
					headerObj
						addInDoubleLinkedList: newColumn direction: #ns;
						addInDoubleLinkedList: headers direction: #we.
					allObjs at: aPoint y put: headerObj.
					newColumn ].
			columnObj := column first.
			dataObj := DLDataObject new
				column: columnObj;
				point: aPoint;
				model: anAssociation value;
				yourself.
			row := rows at: aPoint x ifAbsentPut: [ DoubleLinkedList new ].
			dataObj
				addInDoubleLinkedList: column direction: #ns;
				addInDoubleLinkedList: row direction: #we.
			columnObj updateSize: [ :s | s + 1 ].
			allObjs at: aPoint put: dataObj ].
	headers makeCircular.
	columns valuesDo: #makeCircular.
	rows valuesDo: #makeCircular.
	^ allObjs
]

{ #category : #accessing }
DLDataObject >> addInDoubleLinkedList: aDoubleLinkedList direction: aSymbol [ 
	|doubleLink|
	doubleLink := aDoubleLinkedList add: self.
	aSymbol = #ns ifTrue:[ ns := doubleLink ] ifFalse: [ we := doubleLink  ]
]

{ #category : #accessing }
DLDataObject >> asColumnsSet [
	| set r getter |
	getter := [ :o | o point ].
	r := self.
	set := Set with: (getter value: r).
	[ r := r right.
	r == self ] whileFalse: [ set add: (getter value: r) ].
	^ set
]

{ #category : #accessing }
DLDataObject >> column [
	^ column
]

{ #category : #accessing }
DLDataObject >> column: aDLColumnObject [ 
	column := aDLColumnObject
]

{ #category : #accessing }
DLDataObject >> down [
	^ ns nextLink value
]

{ #category : #querying }
DLDataObject >> isFixPointOf: aSelector [
	
	^ self == (aSelector value: self)
]

{ #category : #accessing }
DLDataObject >> left [
	^ we previousLink value
]

{ #category : #accessing }
DLDataObject >> model [
	^ model
]

{ #category : #accessing }
DLDataObject >> model: anObject [
	model := anObject
]

{ #category : #accessing }
DLDataObject >> nsLink [
	^ ns
]

{ #category : #accessing }
DLDataObject >> point [
	^ point
]

{ #category : #accessing }
DLDataObject >> point: anObject [
	point := anObject
]

{ #category : #accessing }
DLDataObject >> right [
	^ we nextLink value
]

{ #category : #iterating }
DLDataObject >> untilFixPointOf: aSelector do: aBlockClosure [ 
	|j|
	j := (aSelector value: self).
	[   j == self ] whileFalse: [ aBlockClosure value: j . j := aSelector value: j ]
]

{ #category : #accessing }
DLDataObject >> up [
	^ ns previousLink value
]
