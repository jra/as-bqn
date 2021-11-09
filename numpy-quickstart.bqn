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
ARange ← {(⊑𝕩)+𝕨×↕⌈(-´⌽𝕩)÷𝕨}
5 ARange 10‿30
#⟨ 10 15 20 25 ⟩
# a + c×↕⌊c÷˜b - a  dutchie, BQN message board: packing params in list poor BQN, just write as needed, like
10 + 5×↕⌊5÷˜30 - 10
# c×↕⌊b÷c  if a is 0, just this
# a+c×↕l  if length is known, this (see first BQN ex for this problem)
#>>> np.arange(0, 2, 0.3)  # it accepts float arguments
#array([0. , 0.3, 0.6, 0.9, 1.2, 1.5, 1.8])
(1.8÷6)×↕7
#⟨ 0 0.3 0.6 0.8999999999999999 1.2 1.5 1.8 ⟩
0.3 ARange 0‿2
#⟨ 0 0.3 0.6 0.8999999999999999 1.2 1.5 1.8 ⟩
