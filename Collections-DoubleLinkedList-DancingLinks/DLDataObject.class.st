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

{ #category : #tests }
DLDataObject >> emptySudokuIndicators [
	| ones start end matrix |
	start := 0.
	end := 8.
	ones := LinkedList new.
	start to: end do: [ :row | 
		start to: end do: [ :column | 
			start to: end do: [ :value | 
				| rowIndex cellConstraint rowConstraint columnConstraint boxConstraint model |
				model := {(#x -> row).
				(#y -> column).
				(#v -> value)} asDictionary.
				rowIndex := 81 * row + (9 * column) + value.
				cellConstraint := rowIndex @ ((end + 1) * row + column).
				rowConstraint := rowIndex @ (9 * row + value + 81).
				columnConstraint := rowIndex @ (9 * column + value + (81 * 2)).
				boxConstraint := rowIndex
					@ (27 * (row // 3) + (9 * (column // 3)) + value + (81 * 3)).
				ones
					add: cellConstraint + 1 -> model;
					add: rowConstraint + 1 -> model;
					add: columnConstraint + 1 -> model;
					add: boxConstraint + 1  -> model] ] ].
	ones.
	matrix := Array2D rows: 9 ** 3 columns: 81 * 4 onesAt: (ones collect: #key).
	^ ones
]

{ #category : #querying }
DLDataObject >> isFixPointForDirection: aSelector [
	
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
DLDataObject >> untilFixPointForDirection: aSelector do: aBlockClosure [ 
	|j|
	j := (aSelector value: self).
	[   j == self ] whileFalse: [ aBlockClosure value: j . j := aSelector value: j ]
]

{ #category : #accessing }
DLDataObject >> up [
	^ ns previousLink value
]
