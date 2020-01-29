Class {
	#name : #BitArray,
	#superclass : #Object,
	#instVars : [
		'nbits',
		'bits'
	],
	#classInstVars : [
		'lomask',
		'himask'
	],
	#category : #'Collections-Native-BitArray'
}

{ #category : #initialization }
BitArray class >> booleans: aSequenceableCollection [
	| ba len |
	len := aSequenceableCollection size.
	ba := self new: len withAll: false.
	self
		fillByteArray: ba bits
		with: aSequenceableCollection asValueLink
		index: 1.
	^ ba
]

{ #category : #initialization }
BitArray class >> byteOf: i [
	^ i >> 3
]

{ #category : #initialization }
BitArray class >> empty [
	^ self new: 0 withAll: false
]

{ #category : #initialization }
BitArray class >> fillByteArray: aByteArray with: aValueLink index: idx [
	aValueLink
		ifNotNil: [ | assoc byte |
			assoc := self getValueLink: aValueLink byte: 1 byte: 0.
			byte := assoc value.
			byte = 0
				ifFalse: [ aByteArray byteAt: idx put: byte ].
			self fillByteArray: aByteArray with: assoc key index: idx + 1 ]
]

{ #category : #initialization }
BitArray class >> getValueLink: aValueLink byte: bit byte: b [
	^ aValueLink
		ifNil: [ nil -> b ]
		ifNotNil: [ bit = 0
				ifTrue: [ aValueLink -> b ]
				ifFalse: [ | rest sbit |
					rest := aValueLink nextLink.
					sbit := bit << 1 bitAnd: 16rff.
					aValueLink value
						ifTrue: [ self getValueLink: rest byte: sbit byte: (b bitOr: bit) ]
						ifFalse: [ self getValueLink: rest byte: sbit byte: b ] ] ]
]

{ #category : #initialization }
BitArray class >> hibits: i [
	^ himask byteAt: i
]

{ #category : #'class initialization' }
BitArray class >> initialize [
	lomask := #[16r00 16r01 16r03 16r07 16r0f 16r1f 16r3f 16r7f 16rff].
	himask := #[16rff 16rfe 16rfc 16rf8 16rf0 16re0 16rc0 16r80 16r00]
]

{ #category : #initialization }
BitArray class >> lobits: i [
	^ lomask byteAt: i
]

{ #category : #initialization }
BitArray class >> new: len bits: aCollection [
	| ba |
	ba := self new: len withAll: false.
	ba bits
		in: [ :bits | 
			aCollection
				do: [ :i | 
					| idx b j |
					j := i - 1.	"since Smalltalk indices are 1-based we first shift them back by one."
					idx := (self byteOf: j) + 1.	"and increase then again to be used with ByteArray>>#at:"
					b := 1 << (j bitAnd: 7).
					bits byteAt: idx put: ((bits byteAt: idx) bitOr: b) ] ].
	^ ba
]

{ #category : #initialization }
BitArray class >> new: len withAll: aBoolean [
	^ self new
		nbits: len;
		bits:
			(len
				ifZero: [ ByteArray empty ]
				ifNotZero: [ | sz |
					sz := self sizeOf: len.
					aBoolean
						ifTrue: [ | bits |
							bits := ByteArray new: sz withAll: 16rff.
							len \\ 8
								ifZero: [ "nothing to do" ]
								ifNotZero: [ :idx | bits byteAt: sz put: (self lobits: idx + 1) ].
							bits ]
						ifFalse: [ ByteArray new: sz ] ]);
		yourself
]

{ #category : #initialization }
BitArray class >> sizeOf: n [
	^ n + 7 >> 3
]

{ #category : #initialization }
BitArray >> bit: i [
	^ 1 << (self wmask7: i)
]

{ #category : #accessing }
BitArray >> bits [
	^ bits
]

{ #category : #accessing }
BitArray >> bits: anObject [
	bits := anObject
]

{ #category : #initialization }
BitArray >> mask7: i [
	^ self wmask7: i
]

{ #category : #accessing }
BitArray >> nbits [
	^ nbits
]

{ #category : #accessing }
BitArray >> nbits: anObject [
	nbits := anObject
]

{ #category : #initialization }
BitArray >> wmask7: i [
	^ i & 8r7
]
