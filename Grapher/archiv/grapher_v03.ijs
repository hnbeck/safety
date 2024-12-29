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
h1 =:  < @ dltb @ ({"1 1)~ ] @ ix
b1 =: < @ dltb @ (}."1 1)~ ] @ 2 + {:"1 @ ix 

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
NB. call marker mN
marker =: 3 : 0
lines =. prepLine y
selEdges lines
)

NB. gibt die knoten oder kanten zurück, Aufruf vec edges mN
nodes =:  [ # ]
NB. entsprechendes für nodes aufruf wie edges
edges =: ] (#~ -.) [

NB. ##################### Formatierung ###########################

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

NB. erstelle eine List der IDs in der Tabelle
NB. aufruf findID mNT oder findID mN
findID =: [: > [: {."1 ]

NB. suche die Zeile in der Typtabelle 
NB. call e.g. 'G' findIX mNT
findIX =:  (< @ ('#'&, @ dtb @[)) i.~  [: {."1 ]

NB. Aufruf takeTypes mN
takeTypes =: 3 : 0
a =: findID y
(selectNum a) ({."0 1) a
)

NB. ermittle alle indices der types 
NB. call nt ixvec nm
ixvec =: [ (findIX"1 _)~ [: takeTypes ]

NB. gibt ne boxed liste der Formatstrings aus der Typtabelle
NB. mNT take 3 mN 
take =: 4 : 0
{:"1 x ({"0 _)~ (x ixvec y)
)

NB. ############ format the result ######################################
NB. take the definition string from node type table

NB. format line according .dot syntax
formatL =: ' ['&,  @: ] ,&('];' , LF)
NB. fügt subs (x) und text (y) zusammen (text aus mNT)
pl =: [ (, ', '&, ) ]
NB. bereited definitionstext vor (2. Spalte von mN)
ph =: [: dtb [: > [: {: ]
prepL =: [: dtb [: 'label = '&(,)  [ (pl~ ph )]





