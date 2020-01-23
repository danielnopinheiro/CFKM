import numpy as np
import time
import matplotlib.pyplot as plt
import plots

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
def sort(matrix,maxTime=300,names=None,showCosts=False,showImages=False):
	matrix = np.array(matrix)
	
	N = matrix.shape[0]
	
	permutation = np.random.permutation(N)
	
	bestBestCost = getCost(matrix,permutation)
	bestBestPerm = permutation.copy()
	
	stepMax = int(np.round(N/4.).tolist())
	
	if names==None:
		names = range(1,N+1)
	
	start = time.time()
	shakingStep = 1
	while time.time()-start < maxTime:
		permutation = bestBestPerm.copy()
		for shake in range(shakingStep):
			itemCosts = np.zeros(N)
			mat = matrix[permutation,:][:,permutation]
			for n in range(N):
				for m in range(N):
					itemCosts[n] += abs(n-m)*(mat[m,n]+mat[n,m])**2
			id1,id2 = np.random.choice(N, size=2, p=itemCosts/itemCosts.sum(), replace=False)
			tmp = permutation[id1]
			permutation[id1] = permutation[id2]
			permutation[id2] = tmp
		
		bestCost = getCost(matrix,permutation)
		bestPermutation = permutation.copy()
		
		step = 1
		while step < N and time.time()-start < maxTime:
			improved = False
			for n in np.random.permutation(N):
				if time.time()-start > maxTime:
					break
				permutation = move(bestPermutation,n,step)
				cost = getCost(matrix,permutation)
				if cost < bestCost:
					improved = True
					break
				permutation = move(bestPermutation,n,-step)
				cost = getCost(matrix,permutation)
				if cost < bestCost:
					improved = True
					break
			if improved:
				bestCost = cost
				bestPermutation = permutation
				step = 1
				if showCosts:
					if bestCost < bestBestCost:
						print(bestCost)
				if showImages:
					if bestCost < bestBestCost:
						plots.CFKM(matrix,permutation,names,drawnow=True,finalPlot=False)
			else:
				step += 1
		
		if bestCost < bestBestCost:
			shakingStep = 1
			bestBestCost = bestCost
			bestBestPerm = bestPermutation
		else:
			shakingStep = (shakingStep%stepMax)+1
	
	if showImages:
		plots.CFKM(matrix,permutation,names,drawnow=True,finalPlot=True)
		plt.show()
	return bestBestPerm,bestBestCost

def getCost(matrix,permutation):
	m = matrix[permutation,:][:,permutation]
	# print(permutation)
	# print(matrix)
	# print(m)
	cost = 0
	t = m.shape[0]
	for a in range(t):
		for b in range(t):
			cost += abs(a-b)*m[a,b]**2
	return cost

def move(perm,i,passo):
	newperm = perm.copy()
	N = newperm.shape[0]
	v = newperm[i]
	if passo >= 0:
		for j in range(1,passo+1):
			newperm[(i+j-1)%N] = newperm[(i+j)%N]
		newperm[(i+passo)%N] = v
	else:
		passo = -passo
		for j in range(1,passo+1):
			newperm[i-j+1] = newperm[i-j]
		newperm[i-passo] = v
	return newperm
