import pandas as pd
import numpy as np
# import umap

import matplotlib as mpl 
import matplotlib.pyplot as plt 
import seaborn as sns

from sklearn.cluster import SpectralClustering, AgglomerativeClustering, DBSCAN, KMeans
from sklearn.manifold import TSNE, MDS

plt.style.use('classic')

# cancer_data = pd.read_csv('./nci60.csv') # data is already standardized
print('Loading Data')
cancer_data = pd.read_csv('./nci60.csv')
# We determined that we need 39 PCs to get >85% of the variance
pcs = []
for i in range(39):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]
print(cancer_subset.shape)

good_k = [4, 7]

# reduced = umap.UMAP(n_components = 3, n_neighbors=20, min_dist=0.15).fit_transform(landline_subset)
print('Running TSNE')
# reduced = TSNE(n_components=2, random_state=1, perplexity=90, n_iter= 4000, learning_rate=800).fit_transform(cancer_subset)
reduced = TSNE(n_components=2, random_state=0, n_iter=4000).fit_transform(cancer_subset)
print('Running KMeans')
cluster = KMeans(n_clusters=4, random_state=0).fit(cancer_subset)
labels = cluster.predict(cancer_subset)

cancer_data['DIM1'] = reduced[:, 0]
cancer_data['DIM2'] = reduced[:, 1]
cancer_data['labels'] = labels

print('Generating Plot')
sns.lmplot('DIM1', 'DIM2', data=cancer_data, hue='labels',fit_reg=False)
plt.show()