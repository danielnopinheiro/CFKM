import numpy as np
import random
import cvxopt as cv

def CFKM(d,k,h):
	n = len(d)
	
	coef = cv.matrix(d,(1,n*n))
	
	Aeq = cv.spmatrix([],[],[],(n+1,n*n))
	beq = []
	# sum{j}e{ij} = 1 for all i
	for i in range(n):
		for j in range(n):
			Aeq[i,i*n+j] = 1
	beq = [1.]*n
	# sum{j}e{jj} = k
	for j in range(n):
		Aeq[n,j*n+j] = 1
	beq += [float(k)]
	beq = cv.matrix(beq,(n+1,1))
	
	Aineq = cv.spmatrix([],[],[],(2*n*n,n*n))
	bineq = []
	# e{ij} - e{jj} <= 0 for all i,j
	for i in range(n):
		for j in range(n):
			if i!=j:
				Aineq[i*n+j,i*n+j] = 1
				Aineq[i*n+j,j*n+j] = -1
	bineq = [0.]*n*n
	# -e{ij} <= 0 for all i,j
	for i in range(n):
		for j in range(n):
			Aineq[n*n+i*n+j,i*n+j] = -1
	bineq += [0.]*n*n
	bineq = cv.matrix(bineq,(n*n*2,1))
	
	def F(x=None, z=None):
		if x is None:
			x0 = cv.matrix([(1.-float(k)/n)/(n-1)]*n*n,(n*n,1))
			for j in range(n):
				x0[j*n+j] = float(k)/n
			return (0,x0)
		if cv.min(x) < 0.: return None
		f = coef*x**h
		Df = cv.mul(h*coef,(x.T)**(h-1))
		if z is None: return (f,Df)
		H = cv.spdiag(cv.mul(z[0]*h*(h-1)*coef.T,x**(h-2)))
		return (f,Df,H)
	
	if h > 1:
		sol = cv.solvers.cp(F, G=Aineq, h=bineq, A=Aeq, b=beq)
	else:
		sol = cv.solvers.lp(coef.T, G=Aineq, h=bineq, A=Aeq, b=beq)
	x = sol['x']
	Z = sol['primal objective']
	e = [[]]*n
	for i in range(n):
		e[i] = [0.]*n
		for j in range(n):
			e[i][j] = x[i*n+j]
	return (Z,e)

def FMMdd(dd,k,h,g=None):
	if g is None:
		g = h
	d = np.array(dd)
	n = np.size(d,0)
	v = np.zeros((k,n))
	for c in range(k):
		j = random.randrange(n)
		while np.sum(v[:,j])==1.:
			j = random.randrange(n)
		v[c,j] = 1.
	e = membership(d,v,h,g)
	
	old_e = e.copy()
	old_v = v.copy()
	while True:
		v = prot_weight(d,e,h,g)
		e = membership(d,v,h,g)
		if np.sum((e-old_e)**2 + (v-old_v)**2) < 1e-15:
			break
		old_e = e.copy()
		old_v = v.copy()
		
	Z = 0.
	for c in range(k):
		for i in range(n):
			for j in range(n):
				Z += e[c,i]**h*v[c,j]**g*d[i,j]
	return Z,e.tolist(),v.tolist()

def FKM(dd,k,h):
	d = np.array(dd)
	n = np.size(d,0)
	
	medoids = np.random.choice(n,k,replace=False)
	
	uij = np.zeros((n,k))
	dij = d[:,medoids]
	if h==1:
		for i in range(n):
			j = np.argmin(dij[i,:])
			uij[i,j] = 1
	else:
		for i in range(n):
			soma = 0.
			for j in range(k):
				soma += 1./dij[i,j]**(1./(h-1))
			for j in range(k):
				if dij[i,j] == 0.:
					uij[i,j] = 1.
				else:
					uij[i,j] = 1./(soma*dij[i,j]**(1./(h-1)))
	Z = np.sum(dij*uij**h)
	m_bin = np.array([False]*n)
	m_bin[medoids] = True
	
	improved = True
	while improved:
		improved = False
		m = medoids.copy()
		m_bin2 = m_bin.copy()
		for idOut in np.random.permutation(k):
			mOut = m[idOut]
			for mIn in range(n):
				if m_bin2[mIn]:
					continue
				m[idOut] = mIn
				m_bin2[mOut] = False
				m_bin2[mIn] = True
				dij = d[:,m]
				u2 = np.zeros((n,k))
				if h==1:
					for i in range(n):
						j = np.argmin(dij[i,:])
						u2[i,j] = 1.
				else:
					for i in range(n):
						soma = 0.
						for j in range(k):
							soma += 1./dij[i,j]**(1./(h-1))
						for j in range(k):
							if dij[i,j] == 0.:
								u2[i,j] = 1.
							else:
								u2[i,j] = 1./(soma*dij[i,j]**(1./(h-1)))
				Z2 = np.sum(dij*u2**h)
				if Z2<Z:
					improved = True
					medoids = m.copy()
					m_bin = m_bin2.copy()
					Z = Z2
					uij = u2.copy()
				else:
					m = medoids.copy()
					m_bin2 = m_bin.copy()
	e = np.zeros((n,n))
	e[:,medoids] = uij
	return Z,e.tolist()

def membership(d,v,h,g):
	k,n = v.shape
	e = np.zeros((k,n))
	for c in range(k):
		for i in range(n):
			if v[c,i]==1.:
				e[c,i]=1.
			else:
				e[c,i]=((v[c,:]**g).dot(d[i,:]))**(-1./(h-1.))/np.sum(((v**g).dot(d[i,:]))**(-1./(h-1.)))
			if np.isnan(e[c,i]):
				e[c,i]=1.
	return e

def prot_weight(d,e,h,g):
	k,n = e.shape
	v = np.zeros((k,n))
	for c in range(k):
		for j in range(n):
			v[c,j]=((e[c,:]**h).dot(d[:,j]))**(-1./(g-1.))/np.sum(((e[c,:]**h).dot(d))**(-1./(g-1.)))
	return v
