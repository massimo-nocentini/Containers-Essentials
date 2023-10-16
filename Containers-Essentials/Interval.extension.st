Extension { #name : 'Interval' }

{ #category : '*Containers-Essentials' }
Interval >> chebyshev: samples [

	| sum diff denominator knots |
	sum := (start + stop) halved.
	diff := (stop - start) halved.
	denominator := samples << 1.

	knots := Array new: samples.

	1 to: samples do: [ :k | 
		| knot |
		knot := diff * (Float π * (k << 1 - 1) / denominator) cos.
		knots atLast: k put: sum + knot ].

	^ knots
]

{ #category : '*Containers-Essentials' }
Interval >> chebyshevInclusive: samples [

	| n array |
	n := samples - 2.

	array := Array new: samples.

	^ array
		  at: 1 put: start;
		  replaceFrom: 2 to: samples - 1 with: (self chebyshev: n);
		  atLast: 1 put: stop;
		  yourself
]

{ #category : '*Containers-Essentials' }
Interval >> linspace: n [

	^ n < 2
		  ifTrue: [ self ]
		  ifFalse: [ start to: stop by: stop - start / (n - 1) ]
]

{ #category : '*Containers-Essentials' }
Interval >> unitAt: t [

	^ (t min: stop max: start) - start / (stop - start)
]
