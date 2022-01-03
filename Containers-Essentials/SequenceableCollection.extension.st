Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> asLinkedList [
	^ self asValueLink asLinkedList
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> asValueLink [

	^ self foldr: [ :each :aValueLink | each ~~> aValueLink ] init: nil
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> bisect: mergeBlock baseBlock: baseBlock [
	^ self
		bisect: mergeBlock
		from: 1
		to: self size
		baseBlock: baseBlock
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> bisect: mergeBlock from: low to: high baseBlock: baseBlock [
	| diff |
	diff := high - low.
	^ diff = 0
		ifTrue: [ baseBlock value: (self at: high)	"Because `high` equals `low`." ]
		ifFalse: [ | middle left right |
			middle := diff // 2 + low.
			left := self
				bisect: mergeBlock
				from: low
				to: middle
				baseBlock: baseBlock.
			right := self
				bisect: mergeBlock
				from: middle + 1
				to: high
				baseBlock: baseBlock.
			mergeBlock value: left value: right ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> doubleExponentiallyWeighted: beta [

	^ self doubleExponentiallyWeighted: beta init: 0
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> doubleExponentiallyWeighted: beta init: init [

	"I collect according to https://en.wikipedia.org/wiki/Double_exponential_moving_average"

	"(#(1.2 2.3 4.5 5.6) doubleExponentiallyWeighted: 0.9) >>> #(1.2 2.053185595567867 3.5896389439714946 4.755154869449235)"

	| ewa ewaOfEwa |
	ewa := self exponentiallyWeighted: beta init: init.
	ewaOfEwa := ewa exponentiallyWeighted: beta init: init.
	^ ewa with: ewaOfEwa collect: [ :e :ee | 2 * e - ee ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> estrin: x [

	^ self reversed estrin: x init: 0
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> estrin: base init: init [

	^ self ifEmpty: [ init ] ifNotEmpty: [ 
		  self size = 1
			  ifTrue: [ self first ]
			  ifFalse: [ 
				  | odd even squared |
				  even := self class streamContents: [ :evenStream | 
					          odd := self class streamContents: [ :oddStream | 
						                 self withIndexDo: [ :each :i | 
							                 (i - 1) even
								                 ifTrue: [ evenStream nextPut: each ]
								                 ifFalse: [ oddStream nextPut: each ] ] ] ].

				  squared := base squared.

				  (even estrin: squared init: init) addNumber:
					  ((odd estrin: squared init: init) multiplyNumber: base) ] ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> exponentiallyWeighted: beta [

	^ self exponentiallyWeighted: beta init: 0
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> exponentiallyWeighted: beta init: init [

	"This message collects according to https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average."

	"(#(1.2 2.3 4.5 5.6) exponentiallyWeighted: 0.9 init: 0) >>> #(1.2 1.7789473684210526 2.783025830258303 3.602151788310556)"

	| betaComplement |
	betaComplement := 1 - beta.
	^ self class new: self size streamContents: [ :aStream | 
		  | w |
		  w := init.
		  self withIndexDo: [ :each :index | 
			  | wCorrected |
			  w := beta * w + (betaComplement * each).
			  wCorrected := w / (1 - (beta ** index)).
			  aStream nextPut: wCorrected ] ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> foldr1: aBlock [

	| folded |
	folded := self last.

	self size - 1 to: 1 by: -1 do: [ :index | 
	folded := aBlock value: (self at: index) value: folded ].

	^ folded
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> foldr: aBlock init: init [
	| cell |
	cell := init.
	self reverseDo: [ :each | cell := aBlock value: each value: cell ].
	^ cell
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> greatestCommonIndex: aCollection [

	| index stop |
	stop := false.
	index := 1.

	[ stop or: [ index > self size or: [ index > aCollection size ] ] ] 
		whileFalse: [ 
			(self at: index) == (aCollection at: index)
				ifTrue: [ index := index + 1 ]
				ifFalse: [ stop := true ] ].

	^ index - 1
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> halves [

	^ self
		  halvesAtIncluding: self size // 2
		  in: [ :prefix :suffix | Array with: prefix with: suffix ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> halvesAtIncluding: anIndex in: aBlock [

	| prefix suffix |
	prefix := self class streamContents: [ :aStream | 
		          1 to: anIndex do: [ :index | 
		          aStream nextPut: (self at: index) ] ].
	suffix := self class streamContents: [ :aStream | 
		          anIndex + 1 to: self size do: [ :index | 
		          aStream nextPut: (self at: index) ] ].

	^ aBlock value: prefix contents value: suffix contents
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> horner: base init: init [

	^ self
		  inject: init
		  into: [ :acc :each | (acc multiplyNumber: base) addNumber: each ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> hornerBase10 [
	^ self horner: 10 init: 0
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> hornerBase2 [
	^ self horner: 2 init: 0
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> injectBRGC: anObject intoIn: iBlock intoOut: oBlock [

	^ ((1 to: self size) inject: 0 -> anObject into: [ :anAssoc :each | 
		   | nextCode index code block acc |
		   code := anAssoc key.
		   acc := anAssoc value.
		   nextCode := each bitBRGC.
		   index := (code bitXor: nextCode) highBit.
		   block := (nextCode bitAt: index) = 0
			            ifTrue: [ oBlock ]
			            ifFalse: [ iBlock ].
		   acc := block cull: acc cull: (self at: index) cull: index.
		   nextCode -> acc ]) value
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> inversions: lessThan [

	^ Array streamContents: [ :invStream | 
		  self
			  bisect: [ :lAssoc :rAssoc | 
				  self class streamContents: [ :aStream | 
					  lAssoc readStream
						  merge: rAssoc readStream
						  sortBlock: lessThan
						  on: aStream
						  inversionsOrNil: invStream ] ]
			  baseBlock: [ :each | { each } ] ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> lastButOne [

	^ self
		  emptyCheck;
		  at: self size - 1
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> scan: aBlock init: aValue [

	^ self class new: self size + 1 streamContents: [ :aStream | 
		  | acc |
		  acc := aStream nextPut: aValue.
		  self do: [ :each | 
			  acc := aBlock value: acc value: each.
			  aStream nextPut: acc ] ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> zip: aSequenceable [
	^ self zip: aSequenceable with: [ :s :o | s -> o ]
]

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> zip: aSequenceable with: aBlock [

	| l size |
	size := self size min: aSequenceable size.
	l := (1 to: size) collect: [ :_ | nil ] as: self class.
	1 to: size do: [ :i | 
		| v |
		v := aBlock value: (self at: i) value: (aSequenceable at: i).
		l at: i put: v ].
	^ l
]
