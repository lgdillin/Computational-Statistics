import pandas as pd
import numpy as np
import umap
import cancer_mode as cancer_mode
import math

import matplotlib as mpl 
import matplotlib.pyplot as plt 
import seaborn as sns

from sklearn.cluster import SpectralClustering, AgglomerativeClustering, DBSCAN, KMeans
from sklearn.manifold import TSNE, MDS

plt.style.use('classic')

# cancer_data = pd.read_csv('./nci60.csv') # data is already standardized
print('Loading Data')
cancer_data = pd.read_csv('./nci60.csv')
cancer_labels = pd.read_csv('./ncilabs.csv')
# We determined that we need 39 PCs to get >85% of the variance
pcs = []
for i in range(41):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]
print(cancer_subset.shape)

good_k = [4, 7, 12, 14]

# print(cancer_labels[0,0])

print('Running Reducer')
# reduced = umap.UMAP(n_components = 2, n_neighbors=20, min_dist=0.15).fit_transform(cancer_subset)
# reduced = TSNE(n_components=2, random_state=0, n_iter=4000, early_exaggeration=30.0, perplexity=29.5).fit_transform(cancer_subset)
# reduced = TSNE(n_components=2, random_state=1, n_iter=5000, perplexity=9, early_exaggeration=30).fit_transform(cancer_subset)
print('Running KMeans')
cluster = KMeans(n_clusters=17, random_state=53).fit(cancer_subset)
labels = cluster.predict(cancer_subset)

# e, c, m = cancer_mode.analyze_clusters(cancer_labels['x'], labels, 14)
K = range(1, 40, 2)
E = range(1, 40, 2)
sum_of_squared_distances = []
for k in K:
    print('testing perp: {}'.format(k))
    local_ssd = []
    for e in E:
        print('testing EE: {}'.format(e))
        reduced = TSNE(n_components=2, random_state=2, n_iter=1000, perplexity=k, early_exaggeration=e).fit_transform(cancer_subset)
        cancer_data['DIM1'] = reduced[:, 0]
        cancer_data['DIM2'] = reduced[:, 1]
        cancer_data['labels'] = labels

        x = reduced[:, 0]
        y = reduced[:, 1]
        distance = []
        for i in range(17):
            distance.append(0)

        for i in range(len(x)):
            lab = labels[i]
            for j in range(len(y)):
                if lab == labels[j]:
                    distance[lab] = distance[lab] + math.sqrt( (x[j] - x[i])*(x[j] - x[i]) + (y[j] - y[i])*(y[j] - y[i]) )

        total_dist = 0
        for i in range(len(distance)):
            total_dist = total_dist + distance[i]
        local_ssd.append(total_dist)
    total_dist1 = 0
    for i in range(len(local_ssd)):
        total_dist1 = total_dist1 + local_ssd[i]
    sum_of_squared_distances.append(total_dist1)
plt.plot(K, sum_of_squared_distances, 'bx-')
plt.xlabel('perplexity')
plt.ylabel('Sum_of_squared_distances')
plt.title('SSD for many EE at a given p')
plt.show()