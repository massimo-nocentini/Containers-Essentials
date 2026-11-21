Extension { #name : 'PointArray' }

{ #category : '*Containers-Essentials-Visualizations' }
PointArray >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPointArray: self
]

{ #category : '*Containers-Essentials-Visualizations' }
PointArray >> asShapeDots [

	^ RSComposite new shapes: (RSChart new
			   add: (RSScatterPlot new
					    points: self;
					    color: Color gray translucent;
					    yourself);
			   addDecoration: (RSHorizontalTick new
					    integer;
					    yourself: [ :tick | 
						    tick configuration numberOfTicks: self size ]);
			   addDecoration: (RSVerticalTick new
					    integer;
					    yourself: [ :tick | 
						    tick configuration numberOfTicks: self size ]);
			   build;
			   shapes)
]
