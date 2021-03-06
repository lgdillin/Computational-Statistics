import pandas as pd
import numpy as np
import cancer_mode as cancer_mode

import matplotlib as mpl 
import matplotlib.pyplot as plt 
import seaborn as sns

from sklearn.cluster import SpectralClustering, AgglomerativeClustering, DBSCAN, KMeans
from sklearn.manifold import TSNE, MDS

plt.style.use('classic')

# cancer_data = pd.read_csv('./nci60.csv') # data is already standardized
cancer_data = pd.read_csv('./nci60.csv')
cancer_labels = pd.read_csv('./ncilabs.csv')

# We determined that we need 39 PCs to get >85% of the variance
pcs = []
for i in range(45):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]

sum_of_squared_distances = []
misclass = []
K = range(1,16)
for k in K:
    km = KMeans(n_clusters=k, random_state = 1)
    km = km.fit(cancer_subset)
    labels = km.predict(cancer_subset)
    sum_of_squared_distances.append(km.inertia_)
    misclass.append(cancer_mode.analyze_clusters(cancer_labels['x'], labels, k)[0])

plt.plot(K, sum_of_squared_distances, 'bx-')
plt.xlabel('k')
plt.ylabel('Sum_of_squared_distances')
plt.title('Elbow Method For Optimal k')
plt.show()

plt.plot(K, misclass, 'bx-')
plt.xlabel('k')
plt.ylabel('misclassifications')
plt.title('misclassification given mode for a group')
plt.show()

