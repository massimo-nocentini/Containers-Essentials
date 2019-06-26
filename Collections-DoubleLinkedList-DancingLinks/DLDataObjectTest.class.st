Class {
	#name : #DLDataObjectTest,
	#superclass : #TestCase,
	#category : #'Collections-DoubleLinkedList-DancingLinks-testing'
}

{ #category : #tests }
DLDataObjectTest >> emptySudokuIndicators [
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

{ #category : #tests }
DLDataObjectTest >> knuthFirstExampleIndicators [
	^ {(1 @ 3).
	(1 @ 5).
	(1 @ 6).
	(2 @ 1).
	(2 @ 4).
	(2 @ 7).
	(3 @ 2).
	(3 @ 3).
	(3 @ 6).
	(4 @ 1).
	(4 @ 4).
	(5 @ 2).
	(5 @ 7).
	(6 @ 4).
	(6 @ 5).
	(6 @ 7)} collect: [ :each | each -> each x ]
]

{ #category : #tests }
DLDataObjectTest >> testDLXonSudoku [
	| grid setOfSets matrices |
	grid := DLDataObject
		gridOn: DLDataObjectTest new emptySudokuIndicators.
	setOfSets := AlgorithmX new solutionsFor: (grid at: #root).
	matrices := setOfSets
		collect: [ :sol | 
			| matrix |
			matrix := Array2D rows: 9 columns: 9.
			sol
				do: [ :model | 
					matrix
						at: (model at: #x) + 1
						at: (model at: #y) + 1
						put: (model at: #v) + 1 ].
					matrix ]
]

{ #category : #tests }
DLDataObjectTest >> testGridCreationOnFirstKnuthMatrix [
	| grid setOfSets |
	grid := DLDataObject gridOn: self knuthFirstExampleIndicators.
	setOfSets := AlgorithmX new solutionsFor: (grid at: #root).
	self assert: setOfSets equals: (Set with: {1 . 4 . 5} asSet).
	setOfSets := AlgorithmX new
		solutionsFor: (grid at: #root)
		withPost: [ :aDLDataObject | aDLDataObject asColumnsSet ].
	self
		assert: setOfSets
		equals:
			(Set
				with:
					{{(5 @ 7).
					(5 @ 2)} asSet.
					{(4 @ 4).
					(4 @ 1)} asSet.
					{(1 @ 6).
					(1 @ 3).
					(1 @ 5)} asSet} asSet).
	self assert: setOfSets size equals: 1.
	self
		assert:
			(setOfSets atRandom
				flatCollectAsSet: [ :aSet | (aSet collect: #x) asSet ])
		equals: {1 . 4 . 5} asSet.
	self
		assert: (setOfSets atRandom flatCollectAsSet: [ :aSet | aSet collect: #y ])
		equals: (1 to: 7) asSet
]

{ #category : #tests }
DLDataObjectTest >> viewGrid: aGrid [
	| b |
	b := RTMondrian new.
	b shape circle.
	b nodes: aGrid values.
	b edges
		connectToAll: [ :aValue | 
			{aValue left.
			aValue right.
			aValue up.
			aValue down} ].
	b layout circle.
	b build.
	^ b view
]

{ #category : #tests }
DLDataObjectTest >> writeArray2D: matrix intoFileReference: aFileReference [
|stream|
stream := aFileReference writeStream.
matrix printOn:stream.
stream close.
]
