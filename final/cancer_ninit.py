import pandas as pd
import numpy as np

import matplotlib as mpl 
import matplotlib.pyplot as plt 
import seaborn as sns

from sklearn.cluster import SpectralClustering, AgglomerativeClustering, DBSCAN, KMeans
from sklearn.manifold import TSNE, MDS

plt.style.use('classic')

# cancer_data = pd.read_csv('./nci60.csv') # data is already standardized
cancer_data = pd.read_csv('./nci60.csv')

# We determined that we need 39 PCs to get >85% of the variance
pcs = []
for i in range(37):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]

sum_of_squared_distances = []
K = range(1,30)
for k in K:
    km = KMeans(n_clusters=14, random_state=1, n_init=k*5)
    km = km.fit(cancer_subset)
    sum_of_squared_distances.append(km.inertia_)

plt.plot(K, sum_of_squared_distances, 'bx-')
plt.xticks(np.arange(0, 30, step=1))
plt.xlabel('k')
plt.ylabel('Sum_of_squared_distances')
plt.title('Graph for best n_init')
plt.show()