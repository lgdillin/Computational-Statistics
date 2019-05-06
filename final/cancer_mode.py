'''
import pandas as pd
import numpy as np
import umap

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
for i in range(45):
    pcs.append('PC{}'.format(i+1))
cancer_subset = cancer_data[pcs]
print(cancer_subset.shape)

good_k = [4, 7, 12, 14]


print('Running KMeans')
cluster = KMeans(n_clusters=14, random_state=9).fit(cancer_subset)
labels = cluster.predict(cancer_subset)
'''

def analyze_clusters(true_labels, predicted_labels, n_classes, print_data):
    # cancer_data['labels'] = labels
    mapping = zip(true_labels, predicted_labels)

    modes = {}
    classifications = {}
    misclass = {}
    for i in range(n_classes):
        modes['{}'.format(i)] = []
        classifications['{}'.format(i)] = []
        misclass['{}'.format(i)] = 0

    for i,j in mapping:
        classifications[str(j)].append(i)

    
    if print_data == True:
        for i in classifications:
            print(classifications[i])
    #'''

    for i in modes:
        modes[i] = max(set(classifications[i]), key=classifications[i].count)

    if print_data == True:
        for i in modes:
            print(modes[i])
        print('-------------------------------')

    misclass = {}
    total_error = 0
    for i, i2 in zip(modes, classifications):
        error = 0
        for j in range(len(classifications[i2])):
            if classifications[i2][j] != modes[i]:
                error = error + 1
        total_error = total_error + error
        misclass[i] = error

    if print_data == True:
        for key in misclass:
            print('Error for {} is {}'.format(key, misclass[key]))

    return (total_error, misclass, modes)
    # return total_error

# analyze_clusters(cancer_labels['x'], labels)