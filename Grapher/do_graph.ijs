NB. triggers graphviz to create png from dot
NB. y is file for output w/o dir
NB. x is dot file w/o dir
doGraph =: 4 :0
 cmdline=: '-Tpng',' -o',(jpath y),' ', (jpath x)
 PROG=: '/opt/homebrew/bin/','dot'
 spawn_jtask_,PROG,' ',cmdline

)