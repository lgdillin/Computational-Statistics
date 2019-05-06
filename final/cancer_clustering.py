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
reduced = TSNE(n_components=2, random_state=2, n_iter=5000, perplexity=40, early_exaggeration=30).fit_transform(cancer_subset)
print('Running KMeans')
cluster = KMeans(n_clusters=17, random_state=53).fit(cancer_subset)
# cluster = AgglomerativeClustering(n_clusters=14).fit(cancer_subset)
# labels = AgglomerativeClustering(n_clusters=14).fit_predict(cancer_subset)
labels = cluster.predict(cancer_subset)

e, c, m = cancer_mode.analyze_clusters(cancer_labels['x'], labels, 17, True)

cancer_data['DIM1'] = reduced[:, 0]
cancer_data['DIM2'] = reduced[:, 1]
cancer_data['labels'] = labels

print('Generating Plot')
#sns.palplot(sns.color_palette("RdBu", n_colors=7))
sns.lmplot('DIM1', 'DIM2', data=cancer_data, hue='labels',fit_reg=False,size=12,scatter_kws={"s": 500})
#'''
i = 0
for x,y in zip(cancer_data['DIM1'], cancer_data['DIM2']):
    plt.annotate(cancer_labels['x'][i], (x,y), textcoords="offset points", xytext=(0,10), ha='center', size=10) 
    i = i + 1
#'''
plt.show()
