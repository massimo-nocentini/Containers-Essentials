Extension { #name : 'CTArray2D' }

{ #category : '*Containers-Essentials' }
CTArray2D class >> catalan: size [

	^ self
		  width: size
		  height: size
		  tabulate: [ :n :k | n - 1 catalan: k - 1 ]
]

{ #category : '*Containers-Essentials' }
CTArray2D class >> pascal: size [

	^ self
		  width: size
		  height: size
		  tabulate: [ :n :k | n - 1 choose: k - 1 ]
]
