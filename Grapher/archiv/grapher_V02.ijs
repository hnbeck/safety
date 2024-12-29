 NB. read the file
load 'graphics/graphviz'
dir =: '~user/safety/data/'
NB. wird später von caller gesetzt
ntFile =: 'nodeTypesFTA.txt'
NB. graphFile =: 'nodesFTA.txt'
graphFile =: 'nodesGSN.txt'
ntFile =: 'nodeTypesGSN.txt'

NB. ################## Helpers ########################

NB. find first comma and divide line in chars before and after that comma
NB. helpers to get head and body of a line from line1, comma is separator
ix =:  i."0 @ (' ' (i." 1 0)~ ])
h1 =:  < @ ({"1 1)~ ] @ ix
b1 =: < @ dlb @ (}."1 1)~ ] @ 2 + {:"1 @ ix 

NB. get rid of empty lines
cleanup =:  #~ ( [: 0&< [: +/"1 [: -. ' '&=) 

NB. take only the node definitions in lines2
NB. find the -> and drop them from list
NB. y is the boxed matrix
selEdges =:[: -. (<'->') e."1 ]
NB. preparation for search: make a line boxed by ' '
prepCut =: ' ',"1 ]
prepLine =:  <;._1"1 @ prepCut @ > @ {:"1  

selectNum =: 3 : 0
 1 i.~"0 1 e.&' 0123456789' ]"1 y
)

NB. ################### IO ################################

NB. y = filename without dir for type file
readTypes =: 3 : 0
NB. load the node types
lines =. (, ;. _2) LF  fread dir , y
NB. create node type table
(h1"1 ,. b1"1) lines
)

NB. read the graph definition file
readGraph =: 3 : 0
NB. read in file as a list of lines (=array)
readGraphDesc =: (, ;. _2) & (LF fread dir , ])
NB. process graph def
lines =. cleanup @: readGraphDesc y
(h1"1 ,. b1"1) lines
)

NB. generiert einen Markervektor
marks =: 3 : 0
lines =. prepLine y
selEdges lines
)

NB. gibt die knoten oder kanten zurück, Aufruf vec edges linelist
edges =:  [ # ]
NB. entsprechendes für nodes aufruf wie edges
nodes =:  (-. [) # ]

NB. ##################### Formatation ###########################

NB. for writing the non changing parts - get rid of blanks
defline =: (';' , LF) ,~ & dtb; 

NB. define replace text: setID <'G1' ergibt <b>G1</b>
NB. setBr $ -> </br>
setID =: ,&'</b>' @: ('<b>'&, )
setBr =: '</br>'
NB. replace # by <b>ID</b> in bodys , x is heads, y is bodys
fillID =: 4 : 0 
('#' ; (setID x ) ) stringreplace y
 )

fillBr =: ('$' ; setBr)& stringreplace @ ]


getID =:  > @ {. 
getBody =:  > @ {: 

NB. replaces the "#" by the ID, call fillAllID"1 linesList
fillSymbols =: 3 : 0
head =. {. y
body =. < @ fillBr @ (getID fillID getBody) y
head ,. body
)

NB. ############### helpers for writing the dot file ##########

NB. Node in der Nodetype ta
NB. call firstCol table
NB. firstCol =: > @: {."1 

NB. aufruf findID mNT
findID =: [: > [: {."1 ]
NB. aufruf takeTypeStr listOfIDs
NB., takeTypeStr =: [: < [: i. selectNum

takeTypes =: 3 : 0
a =: findID y
NB. b =: takeTypeStr"1 a
(selectNum a) ({."0 1) a
)

NB. y ist hier eine Zeile, aufruf takeType"1 mN
takeType=:3 : '{&(;y) @ i. @ selectNum @ ; y'

NB. get the index of type in node type table
ixvec =: [ findType~ [: takeType ]

NB. mNT take 3 { mN 
NB. funktioniert nur zeilenweise
take =: 4 : 0
{: {. x #~ (x ixvec y)
)

NB. ############get###########################################
NB. Generate File
NB. take the definition string from node type table
subs =: [: > [ take ]
formatLine =: ' ['&,  @: ] ,&('];' , LF)



