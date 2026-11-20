"
I test the UML sequence diagrams of `RSUMLSequenceBuilder` on the plain data of `RSUMLSequenceExamples`, and render them without a window.
"
Class {
	#name : 'RSUMLSequenceBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'examples'
	],
	#category : 'Containers-Essentials-Tests-Tests',
	#package : 'Containers-Essentials-Tests',
	#tag : 'Tests'
}

{ #category : 'utilities' }
RSUMLSequenceBuilderTest >> builderOn: timedMessageSends seen: anIdentityDictionary [

	^ RSUMLSequenceBuilder new
		  objectsSeenSoFar: anIdentityDictionary;
		  messagesSends: timedMessageSends;
		  build;
		  yourself
]

{ #category : 'utilities' }
RSUMLSequenceBuilderTest >> paintedPixelsOf: aCanvas [
	"Render aCanvas off screen, with Cairo, and count the pixels, one every three, that differ from the top left one"

	| surface renderer form background painted |
	aCanvas extent: 600 @ 450.
	aCanvas zoomToFit.
	surface := AthensCairoSurface extent: aCanvas extent.
	renderer := RSAthensRenderer new.
	surface drawDuring: [ :athensCanvas |
		renderer
			surface: surface;
			canvas: athensCanvas.
		aCanvas accept: renderer ].
	form := surface asForm.
	background := form colorAt: 0 @ 0.
	painted := 0.
	0 to: form height - 1 by: 3 do: [ :y |
		0 to: form width - 1 by: 3 do: [ :x |
			(form colorAt: x @ y) = background ifFalse: [ painted := painted + 1 ] ] ].
	^ painted
]

{ #category : 'running' }
RSUMLSequenceBuilderTest >> setUp [

	super setUp.
	examples := RSUMLSequenceExamples new
]

{ #category : 'tests' }
RSUMLSequenceBuilderTest >> testExamplesRender [

	(RSUMLSequenceExamples selectors select: [ :each |
		 each beginsWith: 'example' ]) do: [ :each |
		self assert: (self paintedPixelsOf: (examples perform: each)) > 100 ]
]

{ #category : 'tests' }
RSUMLSequenceBuilderTest >> testSortingSequence [

	| sends seen builder descriptor array sorted durationLabel |
	sends := examples sortingSequence.
	array := sends first messageSend receiver.
	sorted := (sends detect: [ :each | each messageSend selector = #addAll: ])
		          messageSend receiver.

	seen := IdentityDictionary new.
	builder := self builderOn: sends seen: seen.
	descriptor := builder modelDescriptor.

	"One column for each object, in the order they are seen: the client of the first send first"
	self
		assert: descriptor columns asArray
		equals: { examples. array. sorted }.

	"Their nicknames come from these indexes (Integer>>#asStringaz)"
	self
		assert: (seen associations collect: [ :each | each key -> each value ]) asSet
		equals: {
				(examples -> 1).
				(array -> 2).
				(sorted -> 3) } asSet.

	"The self send of the sorted collection, from its send to its return"
	self
		assert: ((descriptor selfMessageSends at: sorted) collect: [ :each |
				 each messageSend selector ]) asArray
		equals: #( reSort reSort ).
	self deny: (descriptor selfMessageSends includesKey: array).

	"The label of the duration of the first send"
	durationLabel := (descriptor durationLabelOf: sends first) shapes detect: [
		                 :each | each class == RSLabel ].
	self
		assert: durationLabel text
		equals: 9 milliSeconds asStringScaledUptoHours.

	self assert: builder canvas shapes notEmpty.
	self assert: (self paintedPixelsOf: builder canvas) > 100
]

{ #category : 'tests' }
RSUMLSequenceBuilderTest >> testTimedMessageSend [

	| send timespan timed |
	send := RSFullMessageSend receiver: 3 selector: #+ arguments: #( 4 ).
	timespan := Timespan
		            starting: (DateAndTime year: 2026 month: 11 day: 20)
		            duration: 1 second.
	timed := RSUMLTimedMessageSend messageSend: send timespan: timespan.

	self
		assert: timed messageSend identicalTo: send;
		assert: timed timespan identicalTo: timespan
]
