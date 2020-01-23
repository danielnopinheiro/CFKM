from matplotlib.pyplot import show,subplot,plot,title
import numpy as np
from sklearn.decomposition import PCA
import fuzzykmedoids as fkm
import plots

## Load data
from synthetic import data

for sim in data:
	## Set the number of clusters and fuzziness and compute the distance matrix
	k = sim['k']
	h = 1.5
	g = 1.5
	d = [[sum([(i[s]-j[s])**2 for s in range(len(i))]) for j in sim['x']] for i in sim['x']]
	
	## Solve FKM, FMMdd, CFKM
	Z_fkm,e_fkm = fkm.FKM(d,k,h)
	Z_fmmdd,e_fmmdd,v_fmmdd = fkm.FMMdd(d,k,h)
	Z_cfkm,e_cfkm = fkm.CFKM(d,k,h)
	
	## Plot FKM, FMMdd and CFKM solutions
	# Compute the PCA-projected points in two dimensions
	if len(sim['x'][0]) == 2:
		x = np.array(sim['x'])
	else:
		pca = PCA(n_components=2)
		x = pca.fit_transform(np.array(sim['x']))
	idx = np.array(sim['id'])
	
	# Plot actual points and clusters
	subplot(221)
	for i in range(sim['k']):
		plot(x[idx==i,0],x[idx==i,1],'.')
	title('Points and clusters')
	
	# Plot FKM solution
	subplot(222)
	plots.FKM_points(x,e_fkm)
	title('FKM')
	
	# Plot FMMdd solution
	subplot(223)
	plots.FMMdd_points(x,e_fmmdd,v_fmmdd)
	title('FMMdd')
	
	# Plot CFKM solution
	subplot(224)
	plots.CFKM_points(x,e_cfkm)
	title('CFKM')
	show()

