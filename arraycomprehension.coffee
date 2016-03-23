#
# this is a test to see if you can do multiple argument array comprehensions
#

square = (x) -> x * x

#squareelse = (x, y) -> x * x if y else x                   #doesnt work
squareelse = (x, y) -> if y % 2 then x * x else x
squareif = (x, y) -> x * x if y                        #returns no value if not y

list = [1, 2, 3, 4, 5, 6, 7, 8]

squares = (square num for num in list)

squareifs = (squareif num, 1 for num in list)
#squareifnots = (squareif num, 0 for num in list)          #array of undefs because there was no value returned
#squareifno = (squareif num for num in list)                #array of undefs because there was no value returned

squareelses = (squareelse num, 1 for num in list)
squareelsenots = (squareelse num, 0 for num in list)

j = 0
squareelsepp = (squareelse num, j++ for num in list)        #loooooool unfortunately this resolves to 1 for all indices

k = 0
kplus1 = (x) -> k++
squareelsepp2 = (squareelse num, kplus1 k for num in list)      # this works!

w = 0
wplus1 = (x) -> ++k
squareelsepp3 = (squareelse num, wplus1 w for num in list)      # same thing, off by one index obvs


#time to try something else

squareelsepp4 = (squareelse num, [0..list.length] for num in list)      # holy shit this compiles weird. but it...makes sense

indices = [0..list.length]
squareelsepp5 = (squareelse num, indices for num in list)      # passes the array, nothing fancy

# i have an idea

squareinvoke = (x, f) ->
    if (f z) % 2 then x * x else x
    
z = 0
zplus1 = (x) -> ++z
squareinvokes = (squareinvoke num, zplus1 for num in list)      #works the same as w

squareelse6 = (squareelse num, zplus1 [0..list.length] for num in list)      #this works too


#
# so this is cool and all, but its nothing really different from this
#
manual_squares = []
manual_squares2 = []
list.forEach (i) ->
    manual_squares.push if i % 2 then square i else i
    if i % 2 then manual_squares2.push square i else manual_squares2.push i         #both work the same

#
# or this, since there is no async, so it would be easy to include multiple args
#
mapped = list.map (i) -> square i
mapped2 = [0..list.length].map (i) -> square i

console.log squares, squareifs
console.log squareifs#, squareifnots, squareifno
console.log squareelses, squareelsenots                 # this works like expected!
console.log squareelsepp, squareelsepp2, squareelsepp3
console.log squareelsepp4, indices
console.log squareinvokes, squareelse6
console.log manual_squares, manual_squares2
console.log mapped, mapped2