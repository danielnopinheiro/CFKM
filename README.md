# CFKM
Codes and implementations of the Convex Fuzzy k-Medoids problem

## Matlab
We provide the Matlab implementation used in the [Convex fuzzy k-medoids clustering](https://doi.org/10.1016/j.fss.2020.01.001) article. You may start with files [example.m](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/example.m) and [example2.m](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/example2.m) in order to understand how to use the functions. Following we briefly describe each function present in our implementation.

### Problem solving functions
* [CFKM](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/CFKM.m): solves the Convex Fuzzy k-Medoids problem;
  * [fun_e_grad](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/fun_e_grad.m): returns the cost and gradient of a given CFKM solution;
* [FKM](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/FKM.m): heuristic for the Fuzzy k-Medoids problem;
* [FMMdd](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/FMMdd.m): heuristic for the Fuzzy Clustering with Multi-Medoids problem;
  * [membership](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/membership.m): computes the optimal assignments given the representativeness;
  * [prot_weight](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/prot_weight.m): computes the optimal representativeness given the assignments;

### Graphics functions
* [plotMatrix](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/plotMatrix.m): displays a square matrix with indexes sorted in a given order;
* [plotFKM](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/plotFKM.m): displays a FKM solution matrix with indexes sorted in a given order;
* [plotFMMdd](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/plotFMMdd.m): displays FMMdd solution matrices (memberships and representativeness) with indexes sorted in a given order;
* [points_CFKM](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/points_CFKM.m): plots 2D points and a CFKM solution represented by lines between points whose intensity is proportional to the assignment;
* [points_FKM](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/points_FKM.m): plots 2D points and a FKM solution represented by lines between points whose intensity is proportional to the assignment;
* [points_FMMdd](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/points_FMMdd.m): plots 2D points and a FMMdd solution represented by lines between points whose intensity is proportional to the assignment and representativeness;

### Miscellaneous
* [MinWLA](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/MinWLA.m): aims to solve the [Minimum Weighted Linear Arrangement problem](https://doi.org/10.1016/0166-218X(93)E0168-X), which sorts the indexes of a matrix so that the elements with higher values get close to the diagonal;
  * [plotMatrix](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/plotMatrix.m): described above;
  * [roulette](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/roulette.m): returns an index randomly with a weighted probability;
* [foods.mat](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/foods.mat): Matlab workspace with the "foods" data set used in the paper;
* [synthetic.mat](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/synthetic.mat): Matlab workspace with the synthetic data sets used in the paper.

## Python 2.7/3.6
We provide a Python implementation for the [Convex fuzzy k-medoids clustering](https://doi.org/10.1016/j.fss.2020.01.001) problem. You may start with files [example.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/example.py) and [example2.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/example2.py) in order to understand how to use the functions. Following we briefly describe each function present in our implementation.

Required external libraries:
* [NumPy](https://www.numpy.org/): package for scientific computing with Python;
* [Matplotlib](https://matplotlib.org/): Python 2D plotting library;
* [CVXOPT](https://cvxopt.org/): Python software for convex optimization;
* [Scikit-learn](https://scikit-learn.org/stable/index.html): open source machine learning library that supports supervised and unsupervised learning;

### [fuzzykmedoids.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/fuzzykmedoids.py):
* **CFKM**: solves the Convex Fuzzy k-Medoids problem;
  ```
  def CFKM(d,k,h):
  # This function solves the Convex Fuzzy k-Medoids problem:
  # minimize Z = sum{i}sum{j}d{ij}*e{ij}^h
  # subject to
  # sum{j}e{ij} = 1 for all i
  # sum{j}e{jj} = k
  # e{ij} <= e{jj} for all i,j
  # 0 <= e{ij} <= 1 for all i,j
  # 
  # Inputs:
  # d: n x n dissimilarity matrix
  # k: number of clusters
  # h: fuzziness factor
  # 
  # Outputs:
  # Z: solution cost
  # e: n x n membership matrix
  ```
* **FKM**: heuristic for the Fuzzy k-Medoids problem;
  ```
  def FKM(d,k,h):
  # This function aims to solve the Fuzzy k-Medoids problem:
  # minimize Z = sum{i}sum{j}d{ij}*e{ij}^h
  # subject to
  # sum{j}e{ij} = 1 for all i
  # sum{j}e{jj} = k
  # e{ij} <= e{jj} for all i,j
  # 0 <= e{ij} <= 1 for all i ~= j
  # e{jj} binary for all j
  # 
  # Inputs:
  # d: n x n dissimilarity matrix
  # k: number of clusters
  # h: membership fuzziness factor
  # 
  # Outputs:
  # Z: solution cost
  # e: k x n membership matrix
  ```
* **FMMdd**: heuristic for the Fuzzy Clustering with Multi-Medoids problem;
  ```
  def FMMdd(dd,k,h,g=None):
  # This function aims to solve the Fuzzy Clustering with Multi-Medoids
  # problem:
  # minimize Z = sum{c}sum{i}sum{j}d{ij}*e{ci}^h*v{cj}^g
  # subject to
  # sum{c}e{ci} = 1 for all i
  # sum{j}v{cj} = 1 for all c
  # 0 <= e{ci},v{cj} <= 1 forall c,i,j
  # 
  # Inputs:
  # d: n x n dissimilarity matrix
  # k: number of clusters
  # h: membership fuzziness factor
  # g: representativeness fuzziness degree (optional). If not provided, g=h
  # 
  # Outputs:
  # Z: solution cost
  # e: k x n membership matrix
  # v: k x n representativeness matrix
  ```
  * **membership**: computes the optimal assignments given the representativeness;
  * **prot_weight**: computes the optimal representativeness given the assignments;

### [plots.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/plots.py):
* **CFKM**: displays a square matrix with indexes sorted in a given order;
  ```
  def CFKM(matrix,permutation,names,drawnow=False,finalPlot=True):
  # This function plots "matrix" with indexes sorted by "permutation"
  #
  # Inputs:
  # matrix: n x n matrix displayed
  # permutation: indexes' permutation
  # names: list with label names
  # drawnow: defines whether the plot should be drawn immediately (optional)
  # finalPlot: if False, the grid, label names and colorbar won't be displayed (optional)
  ```
* **FKM**: displays a FKM solution matrix with indexes sorted in a given order;
  ```
  def FKM(matrix,permutation,names,drawnow=False):
  # This function plots a FKM solution with indexes sorted by "permutation"
  # 
  # Inputs:
  # e: n x n matrix of memberships
  # permutation: indexes permutation
  # names: list with label names
  # drawnow: defines whether the plot should be drawn immediately (optional)
  ```
* **FMMdd**: displays FMMdd solution matrices (memberships and representativeness) with indexes sorted in a given order;
  ```
  def FMMdd(e,v,permutation,names,drawnow=False):
  # This function plots a FMMdd solution (e,v) with indexes sorted by "permutation"
  # 
  # Inputs:
  # e: k x n matrix of memberships
  # v: k x n matrix of representativeness
  # permutation: indexes permutation
  # names: list with label names
  # drawnow: defines whether the plot should be drawn immediately (optional)
  ```
* **CFKM_points**: plots 2D points and a CFKM solution represented by lines between points whose intensity is proportional to the assignment;
  ```
  def CFKM_points(x,e):
  # This function plots 2D points "x" and a CFKM solution represented by
  # lines between points whose intensity is proportional to the assignment
  # 
  # Inputs:
  # x: n x 2 matrix of data points
  # e: n x n matrix of memberships
  ```
* **FKM_points**: plots 2D points and a FKM solution represented by lines between points whose intensity is proportional to the assignment;
  ```
  def FKM_points(x,e):
  # This function plots 2D points "x" and a FKM solution represented by lines
  # between points whose intensity is proportional to the assignment
  # 
  # Inputs:
  # x: n x 2 matrix of data points
  # e: n x n matrix of memberships
  ```
* **FMMdd_points**: plots 2D points and a FMMdd solution represented by lines between points whose intensity is proportional to the assignment and representativeness;
  ```
  def FMMdd_points(x,e,v):
  # This function plots 2D points "x" and a FMMdd solution represented by
  # lines between points whose intensity is proportional to the assignment and representativeness
  # 
  # Inputs:
  # x: n x 2 matrix of data points
  # e: k x n matrix of memberships
  # v: k x n matrix of representativeness
  ```

### Miscellaneous
* [MinWLA.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/MinWLA.py):
  * **sort**: aims to solve the [Minimum Weighted Linear Arrangement problem](https://doi.org/10.1016/0166-218X(93)E0168-X), which sorts the indexes of a matrix so that the elements with higher values get close to the diagonal;
    ```
    def sort(matrix,maxTime=300,names=None,showCosts=False,showImages=False):
    # This function aims to solve the Minimum Weighted Linear Arrangement problem, which sorts the indexes of "matrix" so that the elements with higher values get close to the diagonal
    # 
    # Inputs:
    # matrix: n x n matrix to be sorted
    # maxTime: maximum time in seconds
    # names: list with label names
    # showCosts: toggles on/off the display of costs at each iteration (logical)
    # showImages: toggles on/off the display of images at each iteration (logical)
    # 
    # Outputs:
    # bestBestPerm: best index permutation found
    # bestBestCost: solution cost
    ```
* [foods.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/foods.py): contains the "foods" data set used in the paper;
* [synthetic.py](https://github.com/danielnopinheiro/CFKM/blob/master/python/synthetic.py): contains the four synthetic data sets used in the paper.
