"
A BinomialHeapTest is a test class for testing the behavior of BinomialHeap
"
Class {
	#name : #BinomialHeapTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Collections-Sequenceable-BinomialHeap-Tests'
}

{ #category : #utilities }
BinomialHeapTest >> imagesPath [
	^ self iceWorkingDirectory / 'images' / 'binomial-heaps'
]

{ #category : #tests }
BinomialHeapTest >> testPushAndPop [
	<gtExample>
	| elements finalHeap popping count n |
	n := 20.
	elements := (1 to: n) shuffled.

	"First build the complete binomial heap."
	finalHeap := (elements withIndexCollect: #->)
		inject: BinomialHeap empty
		into: [ :anHeap :assoc | 
			self
				export: (anHeap push: assoc key)
				path:
					self imagesPath
						/ ('{1}-push-{2}.png' format: (Array with: n with: assoc value))
				selector: #gtInspectorTreesUsingMondrianBuilder: ].

	"The go backward and empty it."
	popping := finalHeap.
	count := elements size.
	[ popping isEmpty ]
		whileFalse: [ count := count - 1.
			popping := self
				export: popping pop
				path:
					self imagesPath
						/ ('{1}-pop-{2}.png' format: (Array with: n with: count))
				selector: #gtInspectorTreesUsingMondrianBuilder: ].

	"Finally, return the full heap."
	^ finalHeap
]
