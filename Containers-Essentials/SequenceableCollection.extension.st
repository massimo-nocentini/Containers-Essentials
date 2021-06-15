Extension { #name : #SequenceableCollection }

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
SequenceableCollection >> horner: base init: init [
	^ self inject: init into: [ :acc :each | base * acc + each ]
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
SequenceableCollection >> lastButOne [

	^ self
		  emptyCheck;
		  at: self size - 1
]
