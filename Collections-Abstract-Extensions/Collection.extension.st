Extension { #name : #Collection }

{ #category : #'*Collections-Abstract-Extensions' }
Collection >> topologicalSortOnCycleDo: cBlock [
	"Implementation of the *ALgorithm T* in TAOCP by Donald Knuth, Volume 1 page 264.
	
	 # Complexity
		`O(m + n)` where 	`m` is the number of input relations and 
								`n` is the number of (unique) objects represented by naturals.
									
	 # Message send
		`c topologicalSortOnCycleDo: b` 
			where `c` is a collection of associations `j -> k`, for `j, k in [1, n]` no holes allowed,
						 namely every natural *has* to be used in at least one input relation. And,
					`b` is a block consuming a collection of associations forming a cycle.
	 "

	| objs n table r qlink f sort |
	objs := self
		        flatCollect: [ :association | 
			        { 
				        association key.
				        association value } ]
		        as: IdentitySet.
	n := objs size.
	table := (1 to: n) collect: [ :k | 
		         Association new
			         key: 0;
			         value: nil;
			         yourself ].
	self do: [ :association | 
		| countTopAssoc k aValueLink sourceAssoc |
		sourceAssoc := table at: association key.
		k := association value.
		countTopAssoc := table at: k.
		countTopAssoc key: countTopAssoc key + 1.
		aValueLink := ValueLink new
			              value: k;
			              nextLink: sourceAssoc value;
			              yourself.
		sourceAssoc value: aValueLink ].
	qlink := Dictionary new
		         at: 0 put: 0;
		         yourself.
	r := 0.
	1 to: n do: [ :k | 
	(table at: k) key = 0 ifTrue: [ r := qlink at: r put: k ] ].
	f := qlink at: 0.
	sort := Array streamContents: [ :array | 
		        [ f = 0 ] whileFalse: [ 
			        | p |
			        array nextPut: f.
			        n := n - 1.
			        p := (table at: f) in: [ :assoc | 
				             assoc value ignoreBlock: [ assoc value: nil ] ].
			        [ p ] whileNotNil: [ 
				        | assoc suc |
				        suc := p value.
				        assoc := table at: suc.
				        assoc key: assoc key - 1.
				        assoc key = 0 ifTrue: [ r := qlink at: r put: suc ].
				        p := p nextLink ].
			        f := qlink at: f ifAbsent: [ 0 ] ] ].
	^ n > 0
		  ifTrue: [ 
			  | kk cycle |
			  0 to: n do: [ :k | qlink at: k put: 0 ].
			  1 to: n do: [ :k | 
				  | assoc p |
				  assoc := table at: k.
				  p := assoc value ignoreBlock: [ assoc value: 0 ].
				  [ p ] whileNotNil: [ 
					  qlink at: p value put: k.
					  p := p nextLink ] ].
			  kk := (qlink select: [ :value | value ~= 0 ]) anyAssociation key.
			  [ 
			  (table at: kk) value: 1.
			  kk := qlink at: kk.
			  (table at: kk) value = 0 ] whileTrue.
			  cycle := Array streamContents: [ :array | 
				           [ 
				           array nextPut: kk.
				           (table at: kk) value: 0.
				           kk := qlink at: kk.
				           (table at: kk) value = 1 ] whileTrue.
				           array nextPut: kk ].
			  cBlock value: (cycle overlappingPairsCollect: [ :a :b | b -> a ]) ]
		  ifFalse: [ sort ]
]
