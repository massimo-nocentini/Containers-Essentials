Extension { #name : 'RSdeCasteljauExamples' }

{ #category : '*Containers-Essentials-Roassal' }
RSdeCasteljauExamples >> example44deCasteljauLineJunctionRightLongVerticalLine [

	<script:
	'self new example44deCasteljauLineJunctionRightLongVerticalLine open'>
	| aLine anotherLine random |
	random := RandomBoxMullerBivariateGaussian seed:
		          Number firstCarmichaelNumber.

	aLine := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: {
				         (0 @ 0 + random next).
				         (0 @ 50 + random next).
				         (0 @ 100 + random next).
				         (0 @ 200 + random next) };
		         yourself.

	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: {
				               (10 @ 200 + random next).
				               (50 @ 200 + random next).
				               (100 @ 200 + random next) };
		               yourself.

	^ aLine junction: anotherLine right: [ :lineC0 :lineC1 :lineC2 |
		  RSCanvas new
			  addAll: (aLine asGroupWithControlNetColoured: Color gray);
			  addAll: (anotherLine asGroupWithControlNetColoured: Color brown);
			  addAll: (lineC0 asGroupWithControlNetColoured: Color red);
			  addAll: (lineC1 asGroupWithControlNetColoured: Color blue);
			  addAll: (lineC2 asGroupWithControlNetColoured: Color green);
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : '*Containers-Essentials-Roassal' }
RSdeCasteljauExamples >> example44deCasteljauLineNoteBoxTopLeftCornerJunction [

	<script: 'self new example44deCasteljauLineNoteBoxTopLeftCornerJunction open'>
	| aLine anotherLine random juncted offsetPoint |
	random := RandomBoxMullerBivariateGaussian new.

	offsetPoint := 5 @ -5 * 5.

	aLine := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: { 
				         (0 @ 0 - offsetPoint).
				         (0 @ 300) };
		         elevate: 5.


	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: { 
				               (300 @ 0).
				               (0 @ 0 + offsetPoint) };
		               elevate: 5.

	juncted := anotherLine junction: aLine right: [ :c0 :c1 :c2 | c1 ].

	^ RSCanvas new
		  addAll: (aLine asGroupWithControlNetColoured: Color red);
		  addAll: (anotherLine asGroupWithControlNetColoured: Color blue);
		  addAll: (juncted asGroupWithControlNetColoured: Color green);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : '*Containers-Essentials-Roassal' }
RSdeCasteljauExamples >> example44deCasteljauLinePenOrthogonalHorizontalLine [

	<script:
	'self new example44deCasteljauLinePenOrthogonalHorizontalLine open'>
	| b1 random |
	random := RandomBoxMullerBivariateGaussian seed:
		          Number firstCarmichaelNumber.

	b1 := RSdeCasteljauLine new
		      samplesLinspace: 100;
		      pen: [ :aBezier |
			      | a c |
			      a := 100.
			      c := a + 100.
			      aBezier
				      addPoint: 0 @ 0 + random next;
				      addPoint: a @ 0 + random next;
				      "
				      addPoint: b @ 0 + random next;"addBezierPoint:
					      c @ 100 + random next;
				      addPoint: c @ 200 + random next;
				      addBezierPoint: c + 100 @ 300 + random next;
				      addPoint: c + 200 @ 300 + random next ";
				      addPoint: c + 300 @ 300 + random next" ];
		      yourself.

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]
