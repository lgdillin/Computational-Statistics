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
# 45 PC's for >90% of variance
pcs = []
for i in range(55):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]
print(cancer_subset.shape)

sum_of_squared_distances = []
K = range(0,200)
for k in K:
    km = KMeans(n_clusters=14, random_state=k)
    km = km.fit(cancer_subset)
    sum_of_squared_distances.append(km.inertia_)

plt.plot(K, sum_of_squared_distances, 'bx-')
plt.xticks(np.arange(0, 200, step=1))
plt.xlabel('k')
plt.ylabel('Sum_of_squared_distances')
plt.title('Inertia for Optimal random seed')
plt.show()