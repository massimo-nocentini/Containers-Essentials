Extension { #name : #ArrayedCollection }

{ #category : #'*Collections-Sequenceable-Sorting' }
ArrayedCollection >> countingSort: key [
	"From https://en.wikipedia.org/wiki/Counting_sort:
	
count = array of k+1 zeros
for x in input do
    count[key(x)] += 1

total = 0
for i in 0, 1, ... k do
    count[i], total = total, count[i] + total

output = array of the same length as input
for x in input do
    output[count[key(x)]] = x
    count[key(x)] += 1 

return output

"

	| count output |
	count := self class new: self size + 1 withAll: 0.
	self do: [ :each | count at: (key value: each) + 1 incrementBy: 1 ].
	count := count scan: [ :acc :each | acc + each ] init: 1.
	output := self class new: self size.
	self
		do: [ :each | 
			output at: (count at: (key value: each) + 1) put: each.
			count at: (key value: each) + 1 incrementBy: 1 ].
	^ output
]

{ #category : #'*Collections-Sequenceable-Sorting' }
ArrayedCollection >> countingSort: key maximum: k [
	| count output |
	count := self class new: k + 1 withAll: 0.
	self do: [ :each | count at: (key value: each) + 1 incrementBy: 1 ].
	count := count scan: [ :acc :each | acc + each ] init: 1.
	output := self class new: self size.
	self
		do: [ :each | 
			| i |
			i := (key value: each) + 1.
			output at: (count at: i) put: each.
			count at: i incrementBy: 1 ].
	^ output
]
