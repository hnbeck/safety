require 'gl2'
coinsert 'jgl2'

MAIN =: 0 : 0
pc gl2demo closeok;
bin h; 
minwh 800 600;cc g isigraph flush;
minwh 200 600 ;cc nodes listbox;
bin z;
)

a=.'"Item one" "Item two" "Item three"'
moveHandler =:  3 : 0 
redraw 0&". sysdata
)

strategy =: 3 : 0
glrgb 10 10 10
glpen 2 1
glrgb 255 255 10
glbrush''
data =. ({. y) , (1 { y) , 200 , 80
glrect data

)

redraw =: 3 : 0
 glfill 255 255 255 255
 strategy y
 glpaint''
)

gl2demo_g_mbldown =: 3 : 0
redraw 0&". sysdata
gl2demo_g_mmove =: moveHandler
i. 0 0 
) 

gl2demo_g_mblup =: 3 : 0
smoutput 'erase move'
erase 'gl2demo_g_mmove'
)

wd MAIN
wd 'set nodes items ' , a
wd 'pshow'

erase 'gl2demo_g_mmove'


strategy 200 300 0 0 0 

