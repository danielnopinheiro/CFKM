import matplotlib.pyplot as plt
import numpy as np

def CFKM_points(x,e):
	e = np.array(e)
	n = e.shape[0]
	for i in range(n):
		e[i,i] = 0.0
	e = e/e.max()
	plots = []
	ee = []
	for i in range(n):
		for j in range(n):
			if e[i,j] > 0.05:
				plots += [[x[i,:],x[j,:]]]
				ee += [e[i,j]]
	idx = np.argsort(ee)
	for i in idx:
		plt.plot([plots[i][0][0],plots[i][1][0]],[plots[i][0][1],plots[i][1][1]],color=(1-ee[i],1-ee[i],1-ee[i]),linewidth=1.0)
	plt.plot(x[:,0],x[:,1],'.k')

def FKM_points(x,e):
	e = np.array(e)
	n = e.shape[0]
	for i in range(n):
		e[i,i] = 0.0
	e = e/e.max()
	plots = []
	ee = []
	for i in range(n):
		for j in range(n):
			if e[i,j] > 0.05:
				plots += [[x[i,:],x[j,:]]]
				ee += [e[i,j]]
	idx = np.argsort(ee)
	for i in idx:
		plt.plot([plots[i][0][0],plots[i][1][0]],[plots[i][0][1],plots[i][1][1]],color=(1-ee[i],1-ee[i],1-ee[i]),linewidth=1.0)
	plt.plot(x[:,0],x[:,1],'.k')

def FMMdd_points(x,e,v):
	e = np.array(e)
	v = np.array(v)
	n = e.shape[1]
	plots = []
	ev = []
	for i in range(n):
		for j in range(n):
			plots += [[x[i,:],x[j,:]]]
			ev += [np.dot(e[:,i],v[:,j])]
	ev = np.array(ev)
	ev = ev/ev.max()
	idx = np.argsort(ev)
	for i in idx:
		if ev[i] > 0.05:
			plt.plot([plots[i][0][0],plots[i][1][0]],[plots[i][0][1],plots[i][1][1]],color=(1-ev[i],1-ev[i],1-ev[i]),linewidth=1.0)
	plt.plot(x[:,0],x[:,1],'.k')

def CFKM(matrix,permutation,names,drawnow=False,finalPlot=True):
	matrix = np.array(matrix)[permutation,:][:,permutation]
	if finalPlot:
		names = np.array(names)[permutation]
	N = matrix.shape[0]
	plt.clf()
	plt.jet()
	im = plt.matshow(matrix,fignum=0)
	if finalPlot:
		plt.colorbar(im)
		ticks = np.arange(0,N,step=1)
		tick_labels = names
		plt.xticks(ticks,tick_labels,rotation='vertical')
		plt.yticks(ticks,tick_labels)
		for i in np.arange(-.5,N-.5,step=1):
			plt.plot([-.5,N-.5],[i,i],color='black',linewidth=1)
			plt.plot([i,i],[-.5,N-.5],color='black',linewidth=1)
	else:
		plt.xticks([])
		plt.yticks([])
	if drawnow:
		plt.draw()
		plt.pause(0.001)

def FKM(matrix,permutation,names,drawnow=False):
	matrix = np.array(matrix)[permutation,:][:,permutation]
	names = np.array(names)[permutation]
	medoids = matrix.diagonal()==1
	matrix = matrix[:,medoids]
	names_medoids = names[medoids]
	N,K = matrix.shape
	plt.clf()
	plt.jet()
	im = plt.matshow(matrix,fignum=0)
	plt.colorbar(im)
	x_ticks = np.arange(0,K,step=1)
	x_tick_labels = names_medoids
	y_ticks = np.arange(0,N,step=1)
	y_tick_labels = names
	plt.xticks(x_ticks,x_tick_labels,rotation='vertical')
	plt.yticks(y_ticks,y_tick_labels)
	for i in np.arange(-.5,N-.5,step=1):
		plt.plot([-.5,K-.5],[i,i],color='black',linewidth=1)
	for i in np.arange(-.5,K-.5,step=1):
		plt.plot([i,i],[-.5,N-.5],color='black',linewidth=1)
	if drawnow:
		plt.draw()
		plt.pause(0.001)

def FMMdd(e,v,permutation,names,drawnow=False):
	e = np.array(e).T[permutation,:]
	v = np.array(v).T[permutation,:]
	names = np.array(names)[permutation]
	medoids = e.diagonal()==1
	N,K = e.shape
	plt.clf()
	plt.jet()
	ticks = np.arange(0,N,step=1)
	tick_labels = names
	
	plt.subplot(1,2,1)
	im = plt.matshow(e,fignum=0)
	plt.xticks([])
	plt.yticks(ticks,tick_labels)
	plt.colorbar(im)
	for i in np.arange(-.5,N-.5,step=1):
		plt.plot([-.5,K-.5],[i,i],color='black',linewidth=1)
	for i in np.arange(-.5,K-.5,step=1):
		plt.plot([i,i],[-.5,N-.5],color='black',linewidth=1)
	
	plt.subplot(1,2,2)
	im = plt.matshow(v,fignum=0)
	plt.xticks([])
	plt.yticks(ticks,tick_labels)
	plt.colorbar(im)
	for i in np.arange(-.5,N-.5,step=1):
		plt.plot([-.5,K-.5],[i,i],color='black',linewidth=1)
	for i in np.arange(-.5,K-.5,step=1):
		plt.plot([i,i],[-.5,N-.5],color='black',linewidth=1)
	
	if drawnow:
		plt.draw()
		plt.pause(0.001)
