NB. opens a window and shows the png of the graph

showGraph =: 3 : 0
wd 'pc Graph closeok escclose'
wd 'cc png image transparent keep'
wd 'set png image *', (jpath y)
NB. pure blue
wd 'pshow'
hwnd =: wd 'getp hwnd'
)