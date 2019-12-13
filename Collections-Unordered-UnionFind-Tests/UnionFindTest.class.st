"
An UnionFindTest is a test class for testing the behavior of UnionFind
"
Class {
	#name : #UnionFindTest,
	#superclass : #TestCase,
	#category : #'Collections-Unordered-UnionFind-Tests'
}

{ #category : #tests }
UnionFindTest >> testPapadimitriou [
	<gtExample>
	^ (UnionFind withAll: #(a b c d e f g)) useCompressingFind
		union: #a with: #d;
		union: #b with: #e;
		union: #c with: #f;
		union: #c with: #g;
		union: #e with: #a;
		union: #b with: #g;
		yourself
]
