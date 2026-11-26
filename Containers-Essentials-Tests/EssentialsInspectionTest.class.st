"
I test the inspector tabs of Containers-Essentials as the inspector makes them: their contexts come from the pragmas of the inspected object, and their methods are sent with a presenter builder, since Pharo 13 and later refuse an inspection method without one (with the warning 'Inspections made without presenter builder are no longer supported').
"
Class {
	#name : 'EssentialsInspectionTest',
	#superclass : 'TestCase',
	#category : 'Containers-Essentials-Tests-Tests',
	#package : 'Containers-Essentials-Tests',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EssentialsInspectionTest >> defaultTimeLimit [
	"The slots graphs of a class take half a second each"

	^ 1 minute
]

{ #category : 'helpers' }
EssentialsInspectionTest >> essentialsContextsOf: anObject [
	"The active tabs of an inspector on anObject that Containers-Essentials adds"

	^ (StInspectionCollector new
		   inspectedObject: anObject;
		   collectInspectionContexts) select: [ :each |
		  (anObject class lookupSelector: each methodSelector) package name
			  beginsWith: 'Containers-Essentials' ]
]

{ #category : 'helpers' }
EssentialsInspectionTest >> presenterOf: aContext [
	"The presenter of the tab of aContext, made as the inspector makes it"

	self assert: aContext methodSelectorNeedsBuilder.
	^ aContext inspectedObject
		  perform: aContext methodSelector
		  with: aContext newPresenterBuilder
]

{ #category : 'tests' }
EssentialsInspectionTest >> testInspectionsTakeABuilder [

	| methods |
	methods := (Pragma allNamed: #inspectorPresentationOrder:title:)
		           collect: [ :each | each method ]
		           thenSelect: [ :each | each package name beginsWith: 'Containers-Essentials' ].
	self assert: methods size >= 11.
	self assert: (methods reject: [ :each | each numArgs = 1 ]) asArray equals: #(  )
]

{ #category : 'tests' }
EssentialsInspectionTest >> testSccTabOfHeap [
	"A known bug: CTSccDfsPainter signals 'Logical inconsistency: a backward edge is trying to exit from its SCC.' for a Heap. The painter finds back edges to the heap from the shapes of objects under it, while CTDfsSCCsWalker made the heap a component of its own: its walk did not lower the lowlinks along those edges"

	<expectedFailure>
	| context |
	context := (self essentialsContextsOf: (Heap withAll: #( 3 1 2 ))) detect: [ :each |
		           each title = 'SCCs of Slots graph' ].
	self shouldnt: [ self presenterOf: context ] raise: Error
]

{ #category : 'tests' }
EssentialsInspectionTest >> testSlotsGraphOfObject [
	"The tabs of the slots graph of the class Object, as an inspector on it shows them"

	| contexts |
	contexts := self essentialsContextsOf: Object.
	#( 'Slots graph' 'SCCs of Slots graph' 'Slots graph, topologically sorted.' 'Layered slots graph' ) do: [ :title |
		| presenter |
		presenter := self presenterOf: (contexts detect: [ :each | each title = title ]).
		self assert: (presenter isKindOf: SpRoassalInspectorPresenter).
		self assert: presenter canvas shapes notEmpty ]
]

{ #category : 'tests' }
EssentialsInspectionTest >> testSubclassesTreeOnlyOfFewSubclasses [
	"The tree of all the subclasses of a class is a tab for at most 500 subclasses"

	| titles |
	titles := (self essentialsContextsOf: Object) collect: [ :each | each title ].
	self deny: (titles includes: 'All subclasses tree').
	titles := (self essentialsContextsOf: OrderedCollection) collect: [ :each | each title ].
	self assert: (titles includes: 'All subclasses tree')
]

{ #category : 'tests' }
EssentialsInspectionTest >> testTabs [
	"Every tab of Containers-Essentials for some objects draws a canvas"

	{
		Object new.
		(3 / 4).
		42.
		(Heap withAll: #( 3 1 2 )).
		#[ 1 2 3 ].
		OrderedCollection } do: [ :each |
		| contexts |
		contexts := self essentialsContextsOf: each.
		self assert: contexts notEmpty.
		"(the SCCs of the slots graph of a Heap fail: testSccTabOfHeap)"
		(contexts reject: [ :context |
			 (each isKindOf: Heap) and: [ context title = 'SCCs of Slots graph' ] ]) do: [ :context |
			| presenter |
			presenter := self presenterOf: context.
			self
				assert: (presenter isKindOf: SpRoassalInspectorPresenter)
				description: context title , ' of ' , each printString.
			self
				assert: presenter canvas shapes notEmpty
				description: context title , ' of ' , each printString ] ]
]
