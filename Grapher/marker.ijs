NB. implements marking of a node
NB. remove blanks and add a colon
NB. needed for formating
ff =: ',' ,~ dltb 

NB.  > <;. _2> 12 { subs
NB.  ',' cut"1 a
NB. y is formatstr.
marking =: 3 : 0
 NB. replace strings of interest by token
 a=. ('fillcol'; '!') stringreplace y
 b=. ('color'; '*') stringreplace a
 NB. make to table of attributes
 c =. (> ',' cut b) , 'color=red'
 NB. search the token for "color" and drop line from table
 ixx =.  ({: $c) > '*' i."1~ c
 res =. ff "1 (-. ixx) # c
 ('!'; 'fillcol') stringreplace res
)

NB. mark a node by giving a red border
NB. call markNode nodeID
markNode =: 3 :0
index =. y findIX mNn
fstr =: index { subs 
fstr2 =: marking fstr
a =. fstr2 ,~ index {. subs
subs =: a , (1+index - # subs ) {. subs
graph =: formatGraph mNn
writeFile graph
)