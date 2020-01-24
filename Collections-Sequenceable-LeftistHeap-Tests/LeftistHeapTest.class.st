"
A LeftistHeapTest is a test class for testing the behavior of LeftistHeap
"
Class {
	#name : #LeftistHeapTest,
	#superclass : #TestCase,
	#category : #'Collections-Sequenceable-LeftistHeap-Tests'
}

{ #category : #utilities }
LeftistHeapTest >> exportLeftistHeap: anHeap filename: filename [
	| mondrian |
	mondrian := RTMondrian new.
	anHeap gtInspectorTreeUsingMondrianBuilder: mondrian.
	mondrian build view exportPNGtoFilename: filename.
	^ anHeap
]

{ #category : #utilities }
LeftistHeapTest >> exportLeftistHeap: anHeap path: aPath [
	^ self exportLeftistHeap: anHeap filename: aPath fullName
]

{ #category : #utilities }
LeftistHeapTest >> iceWorkingDirectory [
	^ (IceRepository registry
		select: [ :repo | repo includesPackageNamed: self class category ])
		first location
]

{ #category : #'as yet unclassified' }
LeftistHeapTest >> leftistHeapImagesPath [
	^ self iceWorkingDirectory / 'images' / 'leftist-heaps'
]

{ #category : #tests }
LeftistHeapTest >> testAsLeftistHeap [
	| interval random heap t1 t2 |
	random := Random new.
	interval := (1 to: 20000000) collect: [ :i | random nextInt: i ].
	t1 := [ interval asOrderedCollection asLeftishHeap ] timeToRun.
	t2 := [ heap := interval asLeftishHeap ] timeToRun.
	self assert: t2 < t1.

	"If we like we can export it too."
	self
		exportLeftistHeap: heap
		path: self leftistHeapImagesPath / 'big.png'
]

{ #category : #tests }
LeftistHeapTest >> testEmpty [
	<gtExample>
	^ self
		exportLeftistHeap: LeftistHeap empty
		path: self leftistHeapImagesPath / 'empty.png'
]

{ #category : #tests }
LeftistHeapTest >> testReversed [
	<gtExample>
	^ (1 to: 40) reversed
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				path: self leftistHeapImagesPath / 'reversed.png' ]
]

{ #category : #tests }
LeftistHeapTest >> testShuffled [
	<gtExample>
	^ (1 to: 40) shuffled
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				path: self leftistHeapImagesPath / 'shuffled.png' ]
]

{ #category : #tests }
LeftistHeapTest >> testSorted [
	<gtExample>
	^ (1 to: 40)
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				path: self leftistHeapImagesPath / 'sorted.png' ]
]

{ #category : #tests }
LeftistHeapTest >> testWikipedia [
	<gtExample>
	| elements finalHeap popping count |
	elements := #(4 8 10 9 1 3 5 6 11).

	"First build the complete leftist heap."
	finalHeap := (elements withIndexCollect: #->)
		inject: LeftistHeap empty
		into: [ :anHeap :assoc | 
			self
				exportLeftistHeap: (anHeap add: assoc key)
				path:
					self leftistHeapImagesPath
						/ ('wikipedia-add-{1}.png' format: {assoc value}) ].

	"The go backward and empty it."
	popping := finalHeap.
	count := elements size.
	[ popping isEmpty ]
		whileFalse: [ count := count - 1.
			popping := self
				exportLeftistHeap: popping pop
				path: self leftistHeapImagesPath / ('wikipedia-pop-{1}.png' format: {count}) ].

	"We draw also the heap obtained by bisect folding."
	self
		exportLeftistHeap: elements asLeftishHeap
		path: self leftistHeapImagesPath / 'wikipedia-bisect.png'.

	"Finally, return the full heap."
	^ finalHeap
]