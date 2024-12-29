 NB. read the file
load 'graphics/graphviz'

dir =: 'C:\Users\hanbeck\OneDrive - Daimler Truck\Konzepte\Data\'
lines1 =: (, ;. _2) LF  fread dir , 'nodeTypes.txt'

NB. prepare result file
('digraph myGraph', LF) fwrite dir,'graph.dot'
('{' ,LF) fappend dir,'graph.dot'

NB. ###################################################
NB. defining verbs
readLine =: (, ;. _2) & (LF fread dir , ])

NB. get rid of empty lines
cleanup =:  #~ ( [: 0&< [: +/"1 [: -. ' '&=) 

NB. Selektion of first blank
NB. call: ' ' select lines; x is delimiter, y linelist
NB. select =: 4 : 0
NB. y (i." 1 0) x
NB. )

NB. take only the node definitions in lines2
NB. find the -> and drop them from list
NB. y ist die boxed matrix
select2 =:[: -. (<'->') e."1 ]

NB. create boxed matrix
doMatrix =: <;._1"1@([ ,"1 ])

NB. helpers to get head and body of a line, comma is separator
ix =: [: i. (',' select ])
h1 =:  < @ {~ ix 
b1 =: < @ }.~ 2 + ix 

NB. lines head and body vec, box it
head =: 4 : 0 
 <"1 x ({.~ " 1 0) y
)

body =: 4 : 0
 <"1 x (}.~ " 1 0) 1 + {:"1 > y
)

NB. for writing the non changing parts - get rid of blanks
defline =: (';' , LF) ,~ & dtb; 


NB. Node in der Nodetype ta
NB. call firstCol table
firstCol =: > @: {."1 

selectNum =: 3 : 0
 1 i.~"0 1 e.&' 0123456789' ]"1 y
)

NB. aufruf 'G' find2 mNT
find2 =: [: , 1 > [ i. [: > [: {."1 ]

NB. y ist binärvector über zeilen, x boxed type zeilenliste
takeline =: 4 : 0
{: {. y # x
)

NB. y ist hier eine Zeile, aufruf takeType"1 mN
takeType=:3 : '{&(;y) @ i. @ selectNum @ ; y'

NB. get the index of type in node type table
ixvec =: [ find2~ [: takeType ]

NB. mNT take 3 { mN 
NB. funktioniert nur zeilenweise
take =: 4 : 0
x takeline x ixvec y
)

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
(dir, 'graph.dot') fappend~ r
end.
NB. wrap up the dot file
(dir,'graph.dot') fappend~ defline"1 mTail
('}' ,LF) fappend dir,'graph.dot'
)

writeGraph =: 3 : 0
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
mNT rewrite mN
)

NB. call writeGraph <filename w/o dir>
NB.   setID =: ,&'</b>' @: ('<b>'&, )
