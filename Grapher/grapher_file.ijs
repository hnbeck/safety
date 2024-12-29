require '~user/safety/Grapher/grapher.ijs'
require '~user/safety/Grapher/show_graph.ijs'
require '~user/safety/Grapher/do_graph.ijs'
require '~user/safety/Grapher/marker.ijs'

NB. write a dot file from definitions 
NB. call _nodeTypesFile writeGraph _definitionFile
NB. Outfile ist Definitionfile, nur statt ".txt" ".dot"
NB. Autor hans n. beck
writeGraph =: 4 : 0
mNT =: readTypes x
mNraw =. readGraph y
outF =: dir, '.dot',~  _4 }. y 
outPNG =: dir, '.png',~ _4 }. y 

NB. replace placeholders with content
mN =. fillSymbols"1 mNraw

NB. divide node def from edge def
mNn =: mN nodes~ marker mN
mNe =: mN edges~ marker mN 

NB. add format info according node type
subs =: > mNT take mNn

graph =: formatGraph mNn
writeFile graph
)

NB. call formatGraph mNn
formatGraph =: 3 : 0
result =. subs (formatL"1 @: (prepL"1 1)) y
(> {."1 y) ,. result
)

NB. write the dot file
NB. call writeFile linesOfDotFile
writeFile =: 3 : 0

NB. open and setup file
 ('digraph myGraph', LF) fwrite outF
 ('{' ,LF) fappend outF

NB. write out the formated lines
for_line. y do. 
	outF fappend~ line
end.
outF fappend~ defline"1 mNe
('}' ,LF) fappend outF
)

NB. call graphviz and show the graph
NB.  call createGraph ''
createGraph =: 3 : 0
outF doGraph outPNG
showGraph outPNG
)

NB. writes the definition block without substitution of symbols back to disk
dumpDef =: 3 : 0
 sp =. (({. $ mNraw) , 1 ) $ <' '
 dump =: ({."1 mNraw) ,. sp ,. ({:"1 mNraw)
 out =. dir, y
 (LF) fwrite out
for_line. dump do. 
	out fappend~ (; line) , LF
end.
)