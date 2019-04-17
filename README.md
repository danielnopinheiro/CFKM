# CFKM
Codes and implementations of the Convex Fuzzy k-Medoids problem

Files were removed while the paper is in review process.

## Matlab
We provide the Matlab implementation used in [(paper link)](https://). You may start with files [example.m](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/example.m) and [example2.m](https://github.com/danielnopinheiro/CFKM/blob/master/matlab/example2.m) in order to understand how to use the functions. Following we briefly describe each function present in our implementation.

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

## Python 2.7
