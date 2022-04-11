Move2 = trotx(180,'deg')* transl([1.5,0.8,0]) 

Move = troty(180,'deg') * transl([0.8,0,1.5])

tranimate(Move, Move2, "fps", 25)