 NB. read the file
dir =: 'C:\Users\hanbeck\OneDrive - Daimler Truck\Konzepte\Data\'
lines1 =: (, ;. _2) LF  fread dir , 'nodeTypes.txt'
lines2 =: (, ;. _2) LF  fread dir , 'nodes.txt'

NB. leerzeilrn raus
cleanup =:  #~ ( [: 0&< [: +/"1 [: -. ' '&=) 
lines2 =: cleanup lines2

NB. prepare result file
('digraph myGraph', LF) fwrite dir,'graph.dot'
('{' ,LF) fappend dir,'graph.dot'

NB. Selektion
NB. ' ' select lines; x is delimiter, y linelist
select =: 4 : 0
y (i." 1 0) x
)

NB. take first column and all but first column (tail)
NB. h =: < @ ; @ {."1
NB. t =: < @ ; @ }."1

NB. t =: 3 : 0 
NB. <"1  ;"1  ,"1 &',' each }."1 y
NB. )

doMatrix =: <;._1"1@([ ,"1 ])

NB. ALTERNATIVE

ix =: [: i. (',' select ])
h1 =:  < @ {~ ix 
b1 =: < @ }.~ 2 + ix 

NB. ','&,~"1 each

NB. build two column type table
NB. table =: (h ,. t)

NB. mNT =: table ','  doMatrix lines1

mNT =: (h1"1 ,. b1"1) lines1

NB. create table of graph definition



vec =: ' ' select lines2
NB. lines head and body vec
head =: 4 : 0 
 <"1 x ({.~ " 1 0) y
)

body =: 4 : 0
 <"1 x (}.~ " 1 0) 1 + {:"1 > y
)
NB. build the table
mNraw =: lines2 (head ,.body) vec

NB. take only the node definitions in lines2
NB. find the -> and drop them from list
NB. y ist die boxed matrix
select2 =:[: -. (<'->') e."1 ]
selVec =: select2 ' ' doMatrix lines2

mN =: selVec # mNraw
mTail =: (-. selVec) # mNraw

NB. write the non changing parts
defline =: (';' , LF) ,~ & dtb; 

NB.

NB. Node in der Nodetype ta
NB. call firstCol table
firstCol =: > @: {."1 

selectNum =: 3 : 0
 1 i.~"0 1 e.&' 0123456789' ]"1 y
)

NB. y ist hier eine Zeile, aufruf takeType"1 mN
takeType=:3 : '{&(;y) @ i. @ selectNum @ ; y'

NB. creates a binary find vector
find =: 4 : 0
(x select y )</ ({: $  y)
)

NB. aufruf 'G' find2 mNT
find2 =: [: , 1 > [ i. [: > [: {."1 ]

NB. y ist binärvector über zeilen, x boxed type zeilenliste
takeline =: 4 : 0
{: {. y # x
)

ixvec =: [ find2~ [: takeType ]

NB. mNT take 3 { mN 
NB. funktioniert nur zeilenweise
take =: 4 : 0
x takeline x ixvec y
)

NB. Generate File

subs =: [: > [ take ]
formatLine =: ' ['&,  @: ] ,&('];' , LF)

NB. y is mN x is mNT
rewrite =: 4 : 0
r =: 0 2 $ ' '
for_line. y do. 
hh =. > ({. line)
ll =. > ( {: line)
bb =. dtb 'label = "', (dtb ll), '", ', x subs line
r =. hh , (formatLine bb)
(dir, 'graph.dot') fappend~ r
end.
(dir,'graph.dot') fappend~ defline"1 mTail
('}' ,LF) fappend dir,'graph.dot'
)

