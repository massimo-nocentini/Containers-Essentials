Extension { #name : #Point }

{ #category : #'*Kernel-Extensions' }
Point >> catalanTriangle [
	^ Array2D
		rows: self x
		columns: self y
		tabulate: [ :n :k | n - 1 catalan: k - 1 ]
]

{ #category : #'*Kernel-Extensions' }
Point >> pascalTriangle [
	^ Array2D
		rows: self x
		columns: self y
		tabulate: [ :n :k | n - 1 choose: k - 1 ]
]
