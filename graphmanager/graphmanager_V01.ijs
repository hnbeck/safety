NB. managing graph data structure
noCol =. 5
maxCol =: noCol - 1

empty =: 0 (;^:maxCol) 0
nodes =: 1 5 $ <0
places =: _1 , 0

NB. example 'G 200 400 Ein beliegiger Test '

addNode =: 3 : 0
NB. add a node, x should be list of nodes, y sting
line =: ;: y
NB. take all fields from index 2 up to the end
d =:  (2 +  i. (2 -~ #line)) { line
NB. collect all boxes with sting to one string
desc =: ; < @ (' ' ,~ ]) @ > @ ] d
NB. Take the numbers
c =: ". > 1 {"1 line
NB. back in table
(<c) 1} line
line2 =: ({. line) , (<c) , (<desc) , (<0), (<0)

if. (# places) >: 2 do.
  nodes =: line2 ( ({: places)}) nodes
  places =: }: places
  nodes
else.
  nodes =: nodes , line2
end.
)

deleteNode =: 3 : 0
NB. add index to places
places =: places , y
NB. delete line in node table
nodes =: empty (y}) nodes
NB. i. 0 0 
)

NB. addEdge =: 3 : 0 
NB. add edge, x a node pair ,y should be list of edges
NB. i. 0 0 
NB. )
