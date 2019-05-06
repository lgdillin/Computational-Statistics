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
# 45 PC's for >90% of variance

#pcs_list = []
#inertia = []
#misclass = []
best_selection = []
K = range(37,64)
for k in K:
    # Select 1 to k PC's
    pcs = []
    for i in range(k):
        pcs.append('PC{}'.format(i+1))
    cancer_subset = cancer_data[pcs]

    # Sum together the inertia for the first k PC's with 100 random seeds
    print('Running clustering on the first {} PCs'.format(k))
    total_inertia = 0
    for nc in range(2, 18):
        print('Running 100 seeds on k = {}'.format(nc))
        for rand in range(0, 100):
            km = KMeans(n_clusters=nc, random_state=rand)
            km = km.fit(cancer_subset)
            labels = km.predict(cancer_subset)
            err = cancer_mode.analyze_clusters(cancer_labels['x'], labels, nc, False)[0]
            tup = (k, rand, km.inertia_, err, nc)
            best_selection.append(tup)
            # total_inertia = total_inertia + km.inertia_

    # save those results
    # sum_of_squared_distances.append(total_inertia)

smallest = best_selection[0][3]
for i in best_selection:
    smallest = min(smallest, i[3])

best_index = [z for z,b in enumerate(best_selection) if b[3] == smallest]
print(best_index)
for i in range(len(best_index)):
    print(best_selection[best_index[i]])

''' best selections with variable k:
[7953, 19191, 30246, 31907, 31983, 38264, 41507]
(41, 53, 174532.6256264039, 16, 17)
(48, 91, 193380.13870137671, 16, 17)
(55, 46, 221176.61815005605, 16, 16)
(56, 7, 216603.53468237453, 16, 17)
(56, 83, 213426.42911105845, 16, 17)
(60, 64, 227386.42991735393, 16, 16)
(62, 7, 224289.65690311923, 16, 17)
'''

''' best selections
[1714, 1884]
(54, 14, 235163.20249313768, 17)
(55, 84, 235385.96817241894, 17)
'''

'''
plt.plot(best_selection, sum_of_squared_distances, 'bx-')
plt.xlabel('k')
plt.ylabel('Sum_of_squared_distances')
plt.title('Optimal PCs for k=14')
plt.show()
'''