from matplotlib.pyplot import show
import fuzzykmedoids as fkm
import MinWLA
import plots

# Load data and set the number of clusters and fuzziness
from foods import d,n,names
k = 5
h = 1.5

# Solve FKM, FMMdd and CFKM
Z_fkm,e_fkm = fkm.FKM(d,k,h)
Z_fmmdd,e_fmmdd,v_fmmdd = fkm.FMMdd(d,k,h)
Z_cfkm,e_cfkm = fkm.CFKM(d,k,h)

# Sort indexes and plot CFKM solution
time = 2*60
perm,cost = MinWLA.sort(e_cfkm,maxTime=time,names=names,showImages=True)
#plots.CFKM(e_cfkm,perm,names)
#show()

# Plot FKM and FMMdd solutions
plots.FKM(e_fkm,perm,names)
show()
plots.FMMdd(e_fmmdd,v_fmmdd,perm,names)
show()
