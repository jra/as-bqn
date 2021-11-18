# https://numpy.org/doc/stable/user/quickstart.html
# 2021-11-10

# NumPy quickstart
## Prerequisits
## The Basics

## An Example
# >>> a = np.arange(15).reshape(3, 5)
a ← ⟨3, 5⟩ ⥊ ↕15
a ← 3‿5 ⥊ ↕15
#┌─
#╵  0  1  2  3  4
#   5  6  7  8  9
#  10 11 12 13 14
#                 ┘
# >>> a
a
#┌─
#╵  0  1  2  3  4
#   5  6  7  8  9
#  10 11 12 13 14
#                 ┘
# >>> a.shape
≢a
#⟨ 3 5 ⟩
# >>> a.ndim
=a
#2
# >>> a.dtype.name
# BQN number type determined by implementation
# >>> a.itemsize
# >>> a.size
×´≢a
#15
# >>> type(a)
# >>> b = np.array([6, 7, 8])
b ← ⟨6, 7, 8⟩
b ← 6‿7‿8
# >>> b
b
#⟨ 6 7 8 ⟩
≢b
#⟨ 3 ⟩
=b
#1

## Array Creation
#>>> import numpy as np
#>>> a = np.array([2, 3, 4])
a ← ⟨2, 3, 4⟩
#>>> a
#array([2, 3, 4])
a
⟨2, 3, 4⟩
#>>> a.dtype
#dtype('int64')
#>>> b = np.array([1.2, 3.5, 5.1])
a ← ⟨1.2, 3.5, 5.1⟩
#>>> b.dtype
#dtype('float64')

#>>> b = np.array([(1.5, 2, 3), (4, 5, 6)])
b ← >⟨⟨1.5, 2, 3⟩, ⟨4, 5, 6⟩⟩
b ← >⟨1.5‿2‿3, 4‿5‿6⟩
b ← 2‿3 ⥊ 1.5‿2‿3‿4‿5‿6
#┌─
#╵ 1.5 2 3
#    4 5 6
#          ┘
#>>> b
#array([[1.5, 2. , 3. ],
#       [4. , 5. , 6. ]])
b
#┌─
#╵ 1.5 2 3
#    4 5 6
#          ┘

#>>> c = np.array([[1, 2], [3, 4]], dtype=complex)
#>>> c
#array([[1.+0.j, 2.+0.j],
#       [3.+0.j, 4.+0.j]])
# BQN no complex type yet

#>>> np.zeros((3, 4))
#array([[0., 0., 0., 0.],
#       [0., 0., 0., 0.],
#       [0., 0., 0., 0.]])
3‿4 ⥊ 0
#┌─
#╵ 0 0 0 0
#  0 0 0 0
#  0 0 0 0
#          ┘
#>>> np.ones((2, 3, 4), dtype=np.int16)
#array([[[1, 1, 1, 1],
#        [1, 1, 1, 1],
#        [1, 1, 1, 1]],
#
#       [[1, 1, 1, 1],
#        [1, 1, 1, 1],
#        [1, 1, 1, 1]]], dtype=int16)
2‿3‿4 ⥊ 1
#┌─
#╎ 1 1 1 1
#  1 1 1 1
#  1 1 1 1
#
#  1 1 1 1
#  1 1 1 1
#  1 1 1 1
#          ┘
#>>> np.empty((2, 3))
#array([[3.73603959e-262, 6.02658058e-154, 6.55490914e-260],  # may vary
#       [5.30498948e-313, 3.14673309e-307, 1.00000000e+000]])
# BQN no such thing as an uninitialized array?

#>>> np.arange(10, 30, 5)
#array([10, 15, 20, 25])
10+5×↕4
#⟨ 10 15 20 25 ⟩
5 {(⊑𝕩)+𝕨×↕⌈(-´⌽𝕩)÷𝕨} 10‿30  # dzaima, BQN message board, does not work for default w value
#⟨ 10 15 20 25 ⟩
#Range ← {(⊑𝕩)+𝕨×↕⌈(-´⌽𝕩)÷𝕨}
#Range ← ((⊑⊢)+(⊣×(↕∘⌈(-´(⌽⊢)÷⊣))))
#Range ← ((⊑⊢)+(⊣×(↕∘⌈(⊣÷˜(-´⌽⊢)))))
#Range ← ((⊑⊢)+(⊣×(↕∘⌈⊣÷˜-´∘(⌽⊢))))
Range ← {c𝕊a‿b: ↕∘⌈⌾((a+c×⊢)⁼)b}  # Marshal, see chat below ...
# BQN chat >>>>
#Marshall
#It can be simplified, but I don't think you'll end up improving over the block version.
#The outermost set of parens, and one of the inside sets, can be removed, and with · you could get rid of two more sets.
#Marshall
#Personally I would probably use this long version because I think it describes what's being done most clearly.
#Range ← {c𝕊a‿b: ↕∘⌈⌾((a+c×⊢)⁼)b}
#That is, you're going to produce a list of numbers with ↕∘⌈, and then apply a+c×⊢ to the results. And you want it to end after b. So you undo that transformation beforehand, then reapply it after.
#dzaima
#damn, ⌾(F⁼) is pretty nice. Had a header+under version, but without the ⁼, and as such it was pretty ugly
# <<<<
5 Range 10‿30
#⟨ 10 15 20 25 ⟩
# a + c×↕⌊c÷˜b - a  dutchie, BQN message board: packing params in list poor BQN, just write as needed, like
10 + 5×↕⌊5÷˜30 - 10
# c×↕⌊b÷c  if a is 0, just this
# a+c×↕l  if length is known, this (see first BQN ex for this problem)
#>>> np.arange(0, 2, 0.3)  # it accepts float arguments
#array([0. , 0.3, 0.6, 0.9, 1.2, 1.5, 1.8])
(1.8÷6)×↕7
#⟨ 0 0.3 0.6 0.8999999999999999 1.2 1.5 1.8 ⟩
0.3 Range 0‿2
#⟨ 0 0.3 0.6 0.8999999999999999 1.2 1.5 1.8 ⟩

#>>> np.linspace(0, 2, 9)                   # 9 numbers from 0 to 2
#array([0.  , 0.25, 0.5 , 0.75, 1.  , 1.25, 1.5 , 1.75, 2.  ])
0+(2÷8)×↕9
#⟨ 0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 ⟩
#Linspace ← {(⊑𝕩+((1⊑𝕩)÷(𝕨-1))×↕𝕨}  # probably not good BQN
#Linspace ← {(⊑𝕩)+ (1⊑𝕩)× ↕⊸÷⟜(-⟜1) 𝕨}  # another version, would like pure tacit version TODO
Linspace ← ((⊑⊢)+(↕⊣)×(-´∘⌽⊢)÷-⟜1)  # TODO rewrite like Marshall's Range above
9 Linspace 0‿2
#⟨ 0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 ⟩
#>>> x = np.linspace(0, 2 * pi, 100)        # useful to evaluate function at lots of points
#>>> f = np.sin(x)
0+(2×π÷99)×↕100
0+ (2×π)× ↕⊸÷⟜(-⟜1) 100
•math.Sin(↕100)×2×π÷99
x ← 100 Linspace 0‿2×π
f ← •math.Sin x

## Printing Arrays
#>>> a = np.arange(6)                    # 1d array
#>>> print(a)
#[0 1 2 3 4 5]
a ← ↕6
#⟨ 0 1 2 3 4 5 ⟩
a
#⟨ 0 1 2 3 4 5 ⟩
#>>>
#>>> b = np.arange(12).reshape(4, 3)     # 2d array
#>>> print(b)
#[[ 0  1  2]
# [ 3  4  5]
# [ 6  7  8]
# [ 9 10 11]]
b ← 4‿3 ⥊ ↕12
#┌─
#╵ 0  1  2
#  3  4  5
#  6  7  8
#  9 10 11
#          ┘
#>>>
#>>> c = np.arange(24).reshape(2, 3, 4)  # 3d array
#>>> print(c)
#[[[ 0  1  2  3]
#  [ 4  5  6  7]
#  [ 8  9 10 11]]
#
# [[12 13 14 15]
#  [16 17 18 19]
#  [20 21 22 23]]]
c ← 2‿3‿4 ⥊ ↕24
#┌─
#╎  0  1  2  3
#   4  5  6  7
#   8  9 10 11
#
#  12 13 14 15
#  16 17 18 19
#  20 21 22 23
#              ┘

#>>> print(np.arange(10000))
#[   0    1    2 ... 9997 9998 9999]
#>>>
#>>> print(np.arange(10000).reshape(100, 100))
#[[   0    1    2 ...   97   98   99]
# [ 100  101  102 ...  197  198  199]
# [ 200  201  202 ...  297  298  299]
# ...
# [9700 9701 9702 ... 9797 9798 9799]
# [9800 9801 9802 ... 9897 9898 9899]
# [9900 9901 9902 ... 9997 9998 9999]]
# BQN no abreviated output? format?

#>>> np.set_printoptions(threshold=sys.maxsize)  # sys module should be imported

## Basic Operations

#>>> a = np.array([20, 30, 40, 50])
a ← 20‿30‿40‿50
a ← 10 Range 20‿60
a ← 20+10×↕4
#⟨ 20 30 40 50 ⟩
#>>> b = np.arange(4)
#>>> b
#array([0, 1, 2, 3])
b ← ↕4
#⟨ 0 1 2 3 ⟩
#>>> c = a - b
#>>> c
#array([20, 29, 38, 47])
c ← a - b
⟨ 20 29 38 47 ⟩
#>>> b**2
#array([0, 1, 4, 9])
b ⋆ 2
#⟨ 0 1 4 9 ⟩
#>>> 10 * np.sin(a)
#array([ 9.12945251, -9.88031624,  7.4511316 , -2.62374854])
10 × •math.Sin a
⟨ 9.129452507276277 ¯9.880316240928618 7.451131604793488 ¯2.623748537039288 ⟩
#>>> a < 35
#array([ True,  True, False, False])
a < 35
⟨ 1 1 0 0 ⟩

#>>> A = np.array([[1, 1],
#...               [0, 1]])
a ← >⟨1‿1, 0‿1⟩
#┌─
#╵ 1 1
#  0 1
#      ┘
#>>> B = np.array([[2, 0],
#...               [3, 4]])
b ← >⟨2‿0, 3‿4⟩
#┌─
#╵ 2 0
#  3 4
#      ┘
#>>> A * B     # elementwise product
#array([[2, 0],
#       [0, 4]])
a × b
#┌─
#╵ 2 0
#  0 4
#      ┘
#>>> A @ B     # matrix product
#array([[5, 4],
#       [3, 4]])
a +˝∘×⎉1‿∞ b
#┌─
#╵ 5 4
#  3 4
#      ┘
#>>> A.dot(B)  # another matrix product
#array([[5, 4],
#       [3, 4]])

#>>> rg = np.random.default_rng(1)  # create instance of default random number generator
#>>> a = np.ones((2, 3), dtype=int)
a ← 2‿3 ⥊ 1
#┌─
#╵ 1 1 1
#  1 1 1
#        ┘
#>>> b = rg.random((2, 3))
b ← 2‿3 •rand.Range 0
#┌─
#╵ 0.5681749980335864 0.5240789810062436 0.04784389467423078
#   0.494469688429384  0.293539386932129 0.08746621407139887
#                                                            ┘
#>>> a *= 3
#>>> a
#array([[3, 3, 3],
#       [3, 3, 3]])
a ×↩ 3
#┌─
#╵ 3 3 3
#  3 3 3
#        ┘
#>>> b += a
#>>> b
#array([[3.51182162, 3.9504637 , 3.14415961],
#       [3.94864945, 3.31183145, 3.42332645]])
b +↩ a
#┌─
#╵ 3.568174998033586 3.524078981006244 3.047843894674231
#  3.494469688429384 3.293539386932129 3.087466214071399
#                                                        ┘
#>>> a += b  # b is not automatically converted to integer type
#Traceback (most recent call last):
#    ...
#numpy.core._exceptions._UFuncOutputCastingError: Cannot cast ufunc 'add' output from dtype('float64') to dtype('int64') with casting rule 'same_kind'
a +↩ b
#┌─
#╵ 6.568174998033586 6.524078981006244 6.047843894674231
#  6.494469688429384 6.293539386932129 6.087466214071399
#                                                        ┘

#>>> a = np.ones(3, dtype=np.int32)
a ← 3 ⥊ 1
⟨ 1 1 1 ⟩
#>>> b = np.linspace(0, pi, 3)
b ← 3 Linspace 0‿π
⟨ 0 1.570796326794897 3.141592653589793 ⟩
#>>> b.dtype.name
#'float64'
#>>> c = a + b
#>>> c
#array([1.        , 2.57079633, 4.14159265])
c ← a + b
⟨ 1 2.570796326794897 4.141592653589793 ⟩
#>>> c.dtype.name
#'float64'
#>>> d = np.exp(c * 1j)
#>>> d
#array([ 0.54030231+0.84147098j, -0.84147098+0.54030231j,
#       -0.54030231-0.84147098j])
d ← ⋆c  # no complex numbers yet :( in BQN
⟨ 2.718281828459045 13.07623325089137 62.90292428163998 ⟩
#>>> d.dtype.name
#'complex128'

#>>> a = rg.random((2, 3))
#>>> a
#array([[0.82770259, 0.40919914, 0.54959369],
#       [0.02755911, 0.75351311, 0.53814331]])
a ← 2‿3 •rand.Range 0
#┌─
#╵ 0.01699771436482989 0.2509270985708514 0.1082675942818685
#   0.6690983736891898 0.3032168815081075 0.3458953326929901
#                                                            ┘
#>>> a.sum()
#3.1057109529998157
+´⥊a
#1.694402995107837
#>>> a.min()
#0.027559113243068367
⌊´⥊a
#0.01699771436482989
#>>> a.max()
#0.8277025938204418
⌈´⥊a
#0.6690983736891898

#>>> b = np.arange(12).reshape(3, 4)
b ← 3‿4 ⥊ ↕12
#>>> b
#array([[ 0,  1,  2,  3],
#       [ 4,  5,  6,  7],
#       [ 8,  9, 10, 11]])
#>>>
#>>> b.sum(axis=0)     # sum of each column
#array([12, 15, 18, 21])
+˘b
#⟨ 12 15 18 21 ⟩
+˝⎉2 b
#⟨ 12 15 18 21 ⟩
#>>>
#>>> b.min(axis=1)     # min of each row
#array([0, 4, 8])
⌊˝⍉b  # probably a better way, TODO
⟨ 0 4 8 ⟩
⌊˝⎉1 b  # from BQNcrate
⟨ 0 4 8 ⟩
#>>>
#>>> b.cumsum(axis=1)  # cumulative sum along each row
#array([[ 0,  1,  3,  6],
#       [ 4,  9, 15, 22],
#       [ 8, 17, 27, 38]])
+`˘ b
#┌─
#╵ 0  1  3  6
#  4  9 15 22
#  8 17 27 38
#             ┘
+`⎉1 b
#┌─
#╵ 0  1  3  6
#  4  9 15 22
#  8 17 27 38
#             ┘

# https://aplwiki.com/wiki/Rank_%28operator%29
# https://mlochbaum.github.io/BQN/doc/leading.html
# rank docs in the JforC book to be very helpful in understanding rank and leading axis concepts.
#+˝⎉2 means to apply +˝ on cells of rank 2. With a rank-2 argument, the entire array is a cell, so it's the same as applying +˝ without any Rank modifier.
#With ⌊˝⎉1, you're applying to 1-cells, which are rows. So "minimum of each row" is basically a direct translation.
# https://www.jsoftware.com/help/jforc/loopless_code_i_verbs_have_r.htm#_Toc191734333
# https://www.jsoftware.com/docs/help807/jforc/contents.htm
#   cells rank
#One thing to watch out for if you're coming from Numpy is that numpy shapes are "trailing axis matching" whereas most array languages have "leading axis matching". IMO that's numpy's biggest design mistake.
#This shows up in situations like where you have 1 2 3 and 10 11 12 13 and you'd like to add them, resulting in a 3x4 matrix like this:
#11 12 13 14
#12 13 14 15
#13 14 15 16
#In numpy, you end up adding an axis to one or the other of the data. In array languages, you apply the function to a subset of the data (BQN uses "depth" for this I think).
#That's one of the best features of array langs, in my opinion. Modify the function to fit the data, rather than modify the data to fit weird broadcasting rules.


## Universal Functions

#>>> B = np.arange(3)
#>>> B
#array([0, 1, 2])
b ← ↕3
#⟨ 0 1 2 ⟩
#>>> np.exp(B)
#array([1.        , 2.71828183, 7.3890561 ])
⋆b
#⟨ 1 2.718281828459045 7.38905609893065 ⟩
#>>> np.sqrt(B)
#array([0.        , 1.        , 1.41421356])
√b
#⟨ 0 1 1.414213562373095 ⟩
#>>> C = np.array([2., -1., 4.])
c ← 2‿¯1‿4
⟨ 2 ¯1 4 ⟩
#>>> np.add(B, C)
#array([2., 0., 6.])
b + c
⟨ 2 0 6 ⟩

## Index, Slicing, and Iterating

#>>> a = np.arange(10)**3
#>>> a
#array([  0,   1,   8,  27,  64, 125, 216, 343, 512, 729])
a ← (↕10)⋆3
a ← 3⋆˜↕10
#⟨ 0 1 8 27 64 125 216 343 512 729 ⟩
#>>> a[2]
#8
2⊑a
#8
#>>> a[2:5]
#array([ 8, 27, 64])
3↑2↓a  # TODO, not quite. want to slice with original indicies
(2+↕3)⊏a  # better, still not quite, using first index + length
(2+↕5-2)⊏a  # now in terms of indicies, but not great
Slice ← (1 Range ⊣)⊏⊢  # might be ok, need Range with w default to 1
2‿5 Slice a
(↕⌾(-⟜2)5) ⊏ a  # thish should be pretty close to ok/good BQN
#⟨ 8 27 64 ⟩
#>>> # equivalent to a[0:6:2] = 1000;
#>>> # from start to position 6, exclusive, set every 2nd element to 1000
#>>> a[:6:2] = 1000
#>>> a
#array([1000,    1, 1000,   27, 1000,  125,  216,  343,  512,  729])
# TODO study / understand this
#a←3⋆˜↕10 ⋄ a 1000¨⌾((2×↕3)⊸⊏)
1000¨⌾((2×↕3)⊸⊏) a
a 1000¨⌾((2×↕3)⊸⊏)↩  # not perfect, probably want in terms of 2 and 6, but ok
⟨ 1000 1 1000 27 1000 125 216 343 512 729 ⟩

#>>> a[::-1]  # reversed a
#array([ 729,  512,  343,  216,  125, 1000,   27, 1000,    1, 1000])
⌽a
#>>> for i in a:
#...     print(i**(1 / 3.))
#...
#9.999999999999998
#1.0
#9.999999999999998
#3.0
#9.999999999999998
#4.999999999999999
#5.999999999999999
#6.999999999999999
#7.999999999999999
#8.999999999999998
(•Show 3⊸√)¨ a
#9.999999999999998
#1
#9.999999999999998
#3
#9.999999999999998
#4.999999999999999
#5.999999999999999
#6.999999999999999
#7.999999999999999
#8.999999999999998
#⟨ 9.999999999999998 1 9.999999999999998 3 9.999999999999998 4.999999999999999 5.999999999999999 6.999999999999999 7.999999999999999 8.999999999999998 ⟩

#>>> def f(x, y):
#...     return 10 * x + y
#...
F ← (⊢+10×⊣)
#>>> b = np.fromfunction(f, (5, 4), dtype=int)
#>>> b
#array([[ 0,  1,  2,  3],
#       [10, 11, 12, 13],
#       [20, 21, 22, 23],
#       [30, 31, 32, 33],
#       [40, 41, 42, 43]])
b ← (↕5)F⌜↕4
#┌─
#╵  0  1  2  3
#  10 11 12 13
#  20 21 22 23
#  30 31 32 33
#  40 41 42 43
#              ┘
#>>> b[2, 3]
#23
2‿3 ⊑ b
#23
#>>> b[0:5, 1]  # each row in the second column of b
#array([ 1, 11, 21, 31, 41])
((↕5)≍¨5⥊1) ⊑ b  # explicit rows, all rows below
#⟨ 1 11 21 31 41 ⟩
#>>> b[:, 1]    # equivalent to the previous example
#array([ 1, 11, 21, 31, 41])
1⊑˘b
#⟨ 1 11 21 31 41 ⟩
#>>> b[1:3, :]  # each column in the second and third row of b
#array([[10, 11, 12, 13],
#       [20, 21, 22, 23]])
1‿2⊏b
#┌─
#╵ 10 11 12 13
#  20 21 22 23
#              ┘

#>>> b[-1]   # the last row. Equivalent to b[-1, :]
#array([40, 41, 42, 43])
¯1⊏b
#⟨ 40 41 42 43 ⟩

#>>> c = np.array([[[  0,  1,  2],  # a 3D array (two stacked 2D arrays)
#...                [ 10, 12, 13]],
#...               [[100, 101, 102],
#...                [110, 112, 113]]])
c ← >>⟨⟨0‿1‿2, 10‿12‿13⟩, ⟨100‿101‿102, 110‿112‿113⟩⟩
#┌─
#╎   0   1   2
#   10  12  13
#
#  100 101 102
#  110 112 113
#              ┘
# TODO construct c more cleverly
#>>> c.shape
#(2, 2, 3)
≢c
#⟨ 2 2 3 ⟩
#>>> c[1, ...]  # same as c[1, :, :] or c[1]
#array([[100, 101, 102],
#       [110, 112, 113]])
1⊏c
1⊏⎉3 c  # more explicit
#┌─
#╵ 100 101 102
#  110 112 113
#              ┘
#>>> c[..., 2]  # same as c[:, :, 2]
#array([[  2,  13],
#       [102, 113]])
2⊏⎉1 c
#┌─
#╵   2  13
#  102 113
#          ┘

#>>> for row in b:
#...     print(row)
#...
#[0 1 2 3]
#[10 11 12 13]
#[20 21 22 23]
#[30 31 32 33]
#[40 41 42 43]
•Show˘ b
#⟨ 0 1 2 3 ⟩
#⟨ 10 11 12 13 ⟩
#⟨ 20 21 22 23 ⟩
#⟨ 30 31 32 33 ⟩
#⟨ 40 41 42 43 ⟩
#┌─
#╵  0  1  2  3
#  10 11 12 13
#  20 21 22 23
#  30 31 32 33
#  40 41 42 43
#              ┘

#>>> for element in b.flat:
#...     print(element)
#...
#0
#1
#2
#3
#10
#11
#12
#13
#20
#21
#22
#23
#30
#31
#32
#33
#40
#41
#42
#43
•Show¨ b
#0
#1
#2
#3
#10
#11
#12
#13
#20
#21
#22
#23
#30
#31
#32
#33
#40
#41
#42
#43
#┌─
#╵  0  1  2  3
#  10 11 12 13
#  20 21 22 23
#  30 31 32 33
#  40 41 42 43
#              ┘


#>>> a = np.floor(10 * rg.random((3, 4)))
#>>> a
#array([[3., 7., 3., 4.],
#       [1., 4., 2., 2.],
#       [7., 2., 4., 9.]])
#>>> a.shape
#(3, 4)

   a ← ⌊10×3‿4 •rand.Range 0
┌─
╵ 4 0 6 8
  6 3 2 0
  5 3 9 8
          ┘
   ≢a
⟨ 3 4 ⟩


#>>> a.ravel()  # returns the array, flattened
#array([3., 7., 3., 4., 1., 4., 2., 2., 7., 2., 4., 9.])
#>>> a.reshape(6, 2)  # returns the array with a modified shape
#array([[3., 7.],
#       [3., 4.],
#       [1., 4.],
#       [2., 2.],
#       [7., 2.],
#       [4., 9.]])
#>>> a.T  # returns the array, transposed
#array([[3., 1., 7.],
#       [7., 4., 2.],
#       [3., 2., 4.],
#       [4., 2., 9.]])
#>>> a.T.shape
#(4, 3)
#>>> a.shape
#(3, 4)

   ⥊a
⟨ 4 0 6 8 6 3 2 0 5 3 9 8 ⟩
   6‿2⥊a
┌─
╵ 4 0
  6 8
  6 3
  2 0
  5 3
  9 8
      ┘
   ⍉a
┌─
╵ 4 6 5
  0 3 3
  6 2 9
  8 0 8
        ┘
   ≢⍉a
⟨ 4 3 ⟩
   ≢a
⟨ 3 4 ⟩

#>>> a
#array([[3., 7., 3., 4.],
#       [1., 4., 2., 2.],
#       [7., 2., 4., 9.]])
#>>> a.resize((2, 6))
#>>> a
#array([[3., 7., 3., 4., 1., 4.],
#       [2., 2., 7., 2., 4., 9.]])

   a ← ⌊10×3‿4 •rand.Range 0
┌─
╵ 2 1 2 9
  1 5 5 5
  1 8 1 5
          ┘
   a (⥊˜)↩ 2‿6
┌─
╵ 2 1 2 9 1 5
  5 5 1 8 1 5
              ┘
   a
┌─
╵ 2 1 2 9 1 5
  5 5 1 8 1 5
              ┘

# Shape Manipulation

## Changing the shap of an array

#>>> a.reshape(3, -1)
#array([[3., 7., 3., 4.],
#       [1., 4., 2., 2.],
#       [7., 2., 4., 9.]])
   3‿4 ⥊ a  # I don't think BQN will auto-calc missing dims????
┌─
╵ 2 1 2 9
  1 5 5 5
  1 8 1 5
          ┘
## Stacking together different arrays

#>>> a = np.floor(10 * rg.random((2, 2)))
#>>> a
#array([[9., 7.],
#       [5., 2.]])
#>>> b = np.floor(10 * rg.random((2, 2)))
#>>> b
#array([[1., 9.],
#       [5., 1.]])
#>>> np.vstack((a, b))
#array([[9., 7.],
#       [5., 2.],
#       [1., 9.],
#       [5., 1.]])
#>>> np.hstack((a, b))
#array([[9., 7., 1., 9.],
#       [5., 2., 5., 1.]])

a ← ⌊10× 2‿2 •rand.Range 0
┌─
╵ 2 5
  6 7
      ┘
   b ← ⌊10× 2‿2 •rand.Range 0
┌─
╵ 1 2
  0 4
      ┘
   a ∾ b
┌─
╵ 2 5
  6 7
  1 2
  0 4
      ┘
   a ∾˘ b
┌─
╵ 2 5 1 2
  6 7 0 4
          ┘


#>>> from numpy import newaxis
#>>> np.column_stack((a, b))  # with 2D arrays
#array([[9., 7., 1., 9.],
#       [5., 2., 5., 1.]])
#>>> a = np.array([4., 2.])
#>>> b = np.array([3., 8.])
#>>> np.column_stack((a, b))  # returns a 2D array
#array([[4., 3.],
#       [2., 8.]])
#>>> np.hstack((a, b))        # the result is different
#array([4., 2., 3., 8.])
#>>> a[:, newaxis]  # view `a` as a 2D column vector
#array([[4.],
#       [2.]])
#>>> np.column_stack((a[:, newaxis], b[:, newaxis]))
#array([[4., 3.],
#       [2., 8.]])
#>>> np.hstack((a[:, newaxis], b[:, newaxis]))  # the result is the same
#array([[4., 3.],
#       [2., 8.]])

   a ∾˘ b
┌─
╵ 2 5 1 2
  6 7 0 4
          ┘
   a ← 4‿2
⟨ 4 2 ⟩
   b ← 3‿8
⟨ 3 8 ⟩
   ⍉>a‿b
┌─
╵ 4 3
  2 8
      ┘
   a∾b
⟨ 4 2 3 8 ⟩
   ⍉>⟨a⟩
┌─
╵ 4
  2
    ┘
   (⍉>⟨a⟩) ∾˘ ⍉>⟨b⟩
┌─
╵ 4 3
  2 8
      ┘

# Splitting one array into several smaller ones

#>>> a = np.floor(10 * rg.random((2, 12)))
#>>> a
#array([[6., 7., 6., 9., 0., 5., 4., 0., 6., 8., 5., 2.],
#       [8., 5., 5., 7., 1., 8., 6., 7., 1., 8., 1., 0.]])
#>>> # Split `a` into 3
#>>> np.hsplit(a, 3)
#[array([[6., 7., 6., 9.],
#       [8., 5., 5., 7.]]), array([[0., 5., 4., 0.],
#       [1., 8., 6., 7.]]), array([[6., 8., 5., 2.],
#       [1., 8., 1., 0.]])]
#>>> # Split `a` after the third and the fourth column
#>>> np.hsplit(a, (3, 4))
#[array([[6., 7., 6.],
#       [8., 5., 5.]]), array([[9.],
#       [7.]]), array([[0., 5., 4., 0., 6., 8., 5., 2.],
#       [1., 8., 6., 7., 1., 8., 1., 0.]])]

   a ← ⌊10×2‿12 •rand.Range 0
┌─
╵ 4 1 1 9 5 1 2 3 3 1 1 0
  2 9 8 1 9 4 3 4 1 8 1 1
                          ┘
   a
┌─
╵ 4 1 1 9 5 1 2 3 3 1 1 0
  2 9 8 1 9 4 3 4 1 8 1 1
                          ┘
   ⊏⟨⟨2⟩,3⥊4⟩ /¨⊸⊔ a  # explicit, knowing/using a dims
┌─
· ┌─          ┌─          ┌─
  ╵ 4 1 1 9   ╵ 5 1 2 3   ╵ 3 1 1 0
    2 9 8 1     9 4 3 4     1 8 1 1
            ┘           ┘           ┘
                                      ┘
#   ⊏⟨⟨⊑≢a⟩,3⥊⌈(1⊑≢a)÷3⟩ /¨⊸⊔ a  # in terms of number of partitions, create fn with this?
#┌─
#· ┌─          ┌─          ┌─
#  ╵ 4 1 1 9   ╵ 5 1 2 3   ╵ 3 1 1 0
#    2 9 8 1     9 4 3 4     1 8 1 1
#            ┘           ┘           ┘
#                                      ┘
#   ⍉¨(/3⥊4) ⊔ ⍉a  # my initial attempt
#┌─
#· ┌─          ┌─          ┌─
#  ╵ 4 1 1 9   ╵ 5 1 2 3   ╵ 3 1 1 0
#    2 9 8 1     9 4 3 4     1 8 1 1
#            ┘           ┘           ┘
#                                      ┘
## Marshal's responses on how to partition
#⟨2‿3,1‿2‿0‿1⟩ /¨⊸⊔ 'a'+⥊⟜(↕×´)5‿4
#(/1‿2‿0‿1)⊸⊔˘ 'a'+⥊⟜(↕×´)2‿4
## That's Cells (˘) to partition only the second axis.
#⟨2⥊0, (3⥊4)/↕3⟩ ⊔ 2‿12⥊"abcde"
## But note that the result has rank 2 rather than being a list, so you should probably apply ≍⁼ or ⊏ to it.
   ⊏⟨⟨2⟩,3‿1‿8⟩ /¨⊸⊔ a
┌─
· ┌─        ┌─    ┌─
  ╵ 4 1 1   ╵ 9   ╵ 5 1 2 3 3 1 1 0
    2 9 8     1     9 4 3 4 1 8 1 1
          ┘     ┘                   ┘
                                      ┘


# Copies and Views

## No Copy at All

#>>> a = np.array([[ 0,  1,  2,  3],
#...               [ 4,  5,  6,  7],
#...               [ 8,  9, 10, 11]])
#>>> b = a            # no new object is created
#>>> b is a           # a and b are two names for the same ndarray object
#True

   a ← 3‿4⥊↕12
┌─
╵ 0 1  2  3
  4 5  6  7
  8 9 10 11
            ┘
   b ← a
┌─
╵ 0 1  2  3
  4 5  6  7
  8 9 10 11
            ┘
   a 1000⌾(1‿2⊸⊑)↩  # is this the right way to change an element
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘
   a
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘
   b  # arrays are immutable
┌─
╵ 0 1  2  3
  4 5  6  7
  8 9 10 11
            ┘


#>>> def f(x):
#...     print(id(x))
#...
#>>> id(a)  # id is a unique identifier of an object
#148293216  # may vary
#>>> f(a)
#148293216  # may vary

   F ← {𝕩 999⌾(1‿2⊸⊑)↩}
(function block)
   F a
┌─
╵ 0 1   2  3
  4 5 999  7
  8 9  10 11
             ┘
   a  # looks like not pass by ref
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘

## View or Shallow Copy

#>>> c = a.view()
#>>> c is a
#False
#>>> c.base is a            # c is a view of the data owned by a
#True
#>>> c.flags.owndata
#False
#>>>
#>>> c = c.reshape((2, 6))  # a's shape doesn't change
#>>> a.shape
#(3, 4)
#>>> c[0, 4] = 1234         # a's data changes
#>>> a
#array([[   0,    1,    2,    3],
#       [1234,    5,    6,    7],
#       [   8,    9,   10,   11]])

   c ← a
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘
   c 2‿6⊸⥊↩
┌─
╵    0 1 2 3  4  5
  1000 7 8 9 10 11
                   ┘
   ≢a
⟨ 3 4 ⟩
   c 1234⌾(0‿4⊸⊑)↩
┌─
╵    0 1 2 3 1234  5
  1000 7 8 9   10 11
                     ┘
   a  # c is not a view of a, it is its own copy
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘

#>>> s = a[:, 1:3]
#>>> s[:] = 10  # s[:] is a view of s. Note the difference between s = 10 and s[:] = 10
#>>> a
#array([[   0,   10,   10,    3],
#       [1234,   10,   10,    7],
#       [   8,   10,   10,   11]])

   s ← 1‿2⊏⎉1 a
┌─
╵ 1    2
  5 1000
  9   10
         ┘
   s 10¨⌾(⟨↕3,↕2⟩⊸⊏)↩  # s gets a new array
┌─
╵ 10 10
  10 10
  10 10
        ┘
   s
┌─
╵ 10 10
  10 10
  10 10
        ┘
   a  # s is not a view of a, they are distinct
┌─
╵ 0 1    2  3
  4 5 1000  7
  8 9   10 11
              ┘

## Deep Copy

#>>> d = a.copy()  # a new array object with new data is created
#>>> d is a
#False
#>>> d.base is a  # d doesn't share anything with a
#False
#>>> d[0, 0] = 9999
#>>> a
#array([[   0,   10,   10,    3],
#       [1234,   10,   10,    7],
#       [   8,   10,   10,   11]])


#>>> a = np.arange(int(1e8))
#>>> b = a[:100].copy()
#>>> del a  # the memory of ``a`` can be released.


## Functions and Methods Overview

# Less Basic
## Broadcasting Rules

# Advanced indexing and index tricks
## Indexing with Arrays of Indicies
## Indexing with Boolean Arrays
## The ix_() function
## Indexing with strings

# Tricks and Tips
## "Automatic" Reshaping
## Vector Stacking
## Histograms

# Further reading
## The Python tutorial
## Command Reference
## SciPy Tutorial
## SciPy Lecture Notes
## A matlab, R, IDL, NumPy/SciPy dictionary
## Tutorial: Linear algebra on n-dimensional arrays
