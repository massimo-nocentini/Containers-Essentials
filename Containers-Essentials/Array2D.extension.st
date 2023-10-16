Extension { #name : 'Array2D' }

{ #category : '*Containers-Essentials' }
Array2D >> asArrayOfLinks [

	^ Array streamContents: [ :aStream | 
		  | link r |
		  r := 1.
		  link := nil.
		  self withIndicesDo: [ :each :row :column | 
			  r < row ifTrue: [ 
				  aStream nextPut: link reversed.
				  link := nil.
				  r := row ].
			  link := each ~~> link ].
		  aStream nextPut: link reversed ]
]

{ #category : '*Containers-Essentials' }
Array2D class >> catalan: size [

	^ Array2D
		  rows: size
		  columns: size
		  tabulate: [ :n :k | n - 1 catalan: k - 1 ]
]

{ #category : '*Containers-Essentials' }
Array2D class >> pascal: size [

	^ Array2D
		  rows: size
		  columns: size
		  tabulate: [ :n :k | n - 1 choose: k - 1 ]
]
