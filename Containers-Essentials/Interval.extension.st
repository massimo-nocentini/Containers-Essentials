Extension { #name : #Interval }

{ #category : #'*Containers-Essentials' }
Interval >> chebyshev: samples [

	^ samples < 2
		  ifTrue: [ self ]
		  ifFalse: [ 
			  | sum diff denominator domain |
			  sum := (start + stop) halved.
			  diff := (stop - start) halved.
			  denominator := samples << 1.

			  domain := Array new: samples.

			  1 to: samples do: [ :k | 
				  | knot |
				  knot := diff * (Float π * (k << 1 - 1) / denominator) cos.
				  domain atLast: k put: sum + knot ].

			  domain ]
]

{ #category : #'*Containers-Essentials' }
Interval >> chebyshevInclusive: samples [

	| n array |
	n := samples - 2.

	array := Array new: samples.

	^ array
		  at: 1 put: start;
		  replaceFrom: 2 to: n + 1 with: (self chebyshev: n);
		  atLast: 1 put: stop;
		  yourself
]

{ #category : #'*Containers-Essentials' }
Interval >> linspace: n [

	^ n < 2
		  ifTrue: [ self ]
		  ifFalse: [ start to: stop by: stop - start / (n - 1) ]
]

{ #category : #'*Containers-Essentials' }
Interval >> unitAt: t [

	^ (t min: stop max: start) - start / (stop - start)
]
