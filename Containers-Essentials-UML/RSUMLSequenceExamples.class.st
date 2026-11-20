"
I have examples of UML sequence diagrams, drawn by `RSUMLSequenceBuilder` from plain data: `RSUMLTimedMessageSend`s, written by hand here where MethodTracker would trace them.
"
Class {
	#name : 'RSUMLSequenceExamples',
	#superclass : 'RSAbstractExamples',
	#category : 'Containers-Essentials-UML-Examples',
	#package : 'Containers-Essentials-UML',
	#tag : 'Examples'
}

{ #category : 'examples' }
RSUMLSequenceExamples >> example01SortingSequence [

	<script: 'self new example01SortingSequence open'>
	^ self sequenceBuilder: self sortingSequence
]

{ #category : 'examples' }
RSUMLSequenceExamples >> example02SortingSequenceWithReturnsOnly [
	"The same sends, without the self send of the sorted collection"

	<script: 'self new example02SortingSequenceWithReturnsOnly open'>
	^ self sequenceBuilder: (self sortingSequence reject: [ :each |
			   each messageSend selector = #reSort ])
]

{ #category : 'data' }
RSUMLSequenceExamples >> sequenceBuilder: timedMessageSends [

	| builder |
	builder := RSUMLSequenceBuilder new
		           messagesSends: timedMessageSends;
		           yourself.

	builder build.

	^ builder canvas
		  zoomToFit;
		  yourself
]

{ #category : 'data' }
RSUMLSequenceExamples >> sortingSequence [
	"The sends of `#(3 1 2) asSortedCollection`, simplified, as MethodTracker would trace them from this method: the timespan of each send, and its return after the returns of the sends it makes"

	| array sorted start sends timed asSorted addAll reSort |
	array := #( 3 1 2 ) copy.
	sorted := array asSortedCollection.
	start := DateAndTime year: 2026 month: 11 day: 20.

	sends := OrderedCollection new.
	timed := [ :aSend :begin :duration |
	         sends add: (RSUMLTimedMessageSend
			          messageSend: aSend
			          timespan:
			          (Timespan
				           starting: start + begin milliSeconds
				           duration: duration milliSeconds)) ].

	asSorted := (RSFullMessageSend
		             receiver: array
		             selector: #asSortedCollection
		             arguments: #(  ))
		            client: self;
		            callerSelector: #sortingSequence;
		            yourself.

	addAll := (RSFullMessageSend
		           receiver: sorted
		           selector: #addAll:
		           arguments: { array })
		          client: array;
		          callerSelector: #asSortedCollection;
		          yourself.

	reSort := (RSFullMessageSend
		           receiver: sorted
		           selector: #reSort
		           arguments: #(  ))
		          client: sorted;
		          callerSelector: #addAll:;
		          yourself.

	timed
		value: asSorted value: 0 value: 9;
		value: addAll value: 2 value: 6;
		value: reSort value: 3 value: 4;
		value: (reSort asReturnMessageSend return: sorted) value: 7 value: 0;
		value: (addAll asReturnMessageSend return: array) value: 8 value: 0;
		value: (asSorted asReturnMessageSend return: sorted) value: 9 value: 0.

	^ sends asArray
]
