 NB. read the file
load 'graphics/graphviz'
dir =: '~user/safety/data/'

NB. ###################################################
NB. read in file as a list of lines (=array)
readLine =: (, ;. _2) & (LF fread dir , ])

NB. get rid of empty lines
cleanup =:  #~ ( [: 0&< [: +/"1 [: -. ' '&=) 

NB. take only the node definitions in lines2
NB. find the -> and drop them from list
NB. y is the boxed matrix
select2 =:[: -. (<'->') e."1 ]

NB. create boxed matrix
NB. call separator doMatrix lines
doMatrix =: <;._1"1@([ ,"1 ])

NB. helpers to get head and body of a line from line1, comma is separator
ix =: [: i. (',' (i." 1 0)~ ])
h1 =:  < @ {~ ix 
b1 =: < @ }.~ 2 + ix 

NB. lines2 head and body vec, box it
head =: 4 : 0 
 <"1 x ({.~ " 1 0) y
)

body =: 4 : 0
 <"1 x (}.~ " 1 0) y NB. 1 + {:"1 > y
)

NB. for writing the non changing parts - get rid of blanks
defline =: (';' , LF) ,~ & dtb; 

NB. define replace text: setID <'G1' ergibt <b>G1</b>
setID =: ,&'</b><br/>' @: ('<b>'&, ) @ >
NB. replace # by <b>ID</b> in bodys , x is heads, y is bodys
fillID =: 4 : '(''#'' ; (setID x ) ) stringreplace >y'
fillAllID =: [: <  ({. @ ]) fillID"0 ({: @ ])

NB. Node in der Nodetype ta
NB. call firstCol table
NB. firstCol =: > @: {."1 

selectNum =: 3 : 0
 1 i.~"0 1 e.&' 0123456789' ]"1 y
)

NB. aufruf 'G' find2 mNT
findType =: [: , 1 > [ i. [: > [: {."1 ]

NB. y ist hier eine Zeile, aufruf takeType"1 mN
takeType=:3 : '{&(;y) @ i. @ selectNum @ ; y'

NB. get the index of type in node type table
ixvec =: [ findType~ [: takeType ]

NB. mNT take 3 { mN 
NB. funktioniert nur zeilenweise
take =: 4 : 0
{: {. x #~ (x ixvec y)
)

NB. #######################################################
NB. Generate File
NB. take the definition string from node type table
subs =: [: > [ take ]
formatLine =: ' ['&,  @: ] ,&('];' , LF)

NB. ######################################################
NB. write graph

NB. mN is the boxed list of lines of the graph definition
NB. mNT is the boxe list of lines of node types

NB. writes the graph file if y is mN x is mNT
rewrite =: 4 : 0
r =: 0 2 $ ' '
for_line. y do. 
hh =. > ({. line)
ll =. > ( {: line)
bb =. dtb 'label = ', (dtb ll), ', ', x subs line
r =. hh , (formatLine bb)
(dir, outfile) fappend~ r
end.
NB. wrap up the dot file
(dir,outfile) fappend~ defline"1 mTail
('}' ,LF) fappend dir, outfile
)

writeGraph =: 4 : 0

outfile =: x
NB.Preparations
lines1 =: (, ;. _2) LF  fread dir , 'nodeTypesGSN.txt'

NB. prepare result file
('digraph myGraph', LF) fwrite dir,outfile
('{' ,LF) fappend dir,outfile

NB. create node type table
mNT =: (h1"1 ,. b1"1) lines1

NB. process graph def
lines2 =: cleanup @: readLine y

NB. index vector of first blanks per line
ixBlank =: ' ' (i."1 0)~ lines2 NB. lines2

NB. build the table
selVec =: select2 ' ' doMatrix lines2
mNraw =: lines2 (head ,.body) ixBlank
NB. strip out the lines with graph definitions (Lines containing ->)
mN =: selVec # mNraw
mTail =: (-. selVec) # mNraw
NB. write the dot file from the definitions
NB. replace IDs
mN2 =: ({."1 mN ) ,. (fillAllID"1 mN)
mNT rewrite mN2
)

NB. call <outfilename> writeGraph <infilename w/o dir>
NB.   