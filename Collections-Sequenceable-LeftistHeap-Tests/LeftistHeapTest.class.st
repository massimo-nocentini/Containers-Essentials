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

{ #category : #tests }
LeftistHeapTest >> testDescending [
	<gtExample>
	^ (1 to: 40) reversed
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				filename:
					'pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/reversed.png' ]
]

{ #category : #tests }
LeftistHeapTest >> testEmpty [
	<gtExample>
	^ self
		exportLeftistHeap: LeftistHeap empty
		filename:
			'pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/empty.png'
]

{ #category : #tests }
LeftistHeapTest >> testShuffled [
	<gtExample>
	^ (1 to: 40) shuffled
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				filename:
					'pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/shuffled.png' ]
]

{ #category : #tests }
LeftistHeapTest >> testSorted [
	<gtExample>
	^ (1 to: 40)
		inject: LeftistHeap empty
		into: [ :anHeap :each | 
			self
				exportLeftistHeap: (anHeap add: each)
				filename:
					'pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/sorted.png' ]
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
				filename:
					('pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/wikipedia-add-{1}.png'
						format: {assoc value}) ].

	"The go backward and empty it."
	popping := finalHeap.
	count := elements size.
	[ popping isEmpty ]
		whileFalse: [ count := count - 1.
			popping := self
				exportLeftistHeap: popping pop
				filename:
					('pharo-local/iceberg/massimo-nocentini/dsst/images/leftist-heaps/wikipedia-pop-{1}.png'
						format: {count}) ].

	"Finally, return the full heap."
	^ finalHeap
]
