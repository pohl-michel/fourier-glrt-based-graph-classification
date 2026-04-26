<!-- markdownlint-disable -->

# Overview

This repository contains work on binary classification of graph-structured data using spectral graph methods and a generalized likelihood ratio test (GLRT). This approach is based on prior research from Hu et al. (["Matched signal detection on graphs: Theory and application to brain imaging data classification"](https://doi.org/10.1016/j.neuroimage.2015.10.026), *NeuroImage*, 2016), where signals are analyzed in graph Fourier bases derived from class-specific graph Laplacians.
<!-- , which explores classification of graph signals by comparing how well they align with the low-frequency graph Fourier components of class-specific reference graphs.  -->

In this project, I implement the GLRT rule in the bandlimited graph-signal setting and apply it to Alzheimer's disease detection from PET images. Each brain region corresponds to a graph node and is described by a linear combination of five statistical features following the design proposed by Garali et al. (["Region-based brain selection and classification on PET images for Alzheimer's disease computer aided diagnosis"](https://doi.org/10.1109/ICIP.2015.7351045), ICIP, 2015).

 This project was carried out during my engineering studies at [Centrale Méditerranée](https://www.centrale-mediterranee.fr/en) in collaboration with [Fresnel Institute](https://www.fresnel.fr/wp/en/). The full technical report in French is available [here](graph_classification_report_french_2016.pdf), and the corresponding blog article in English can be accessed [here](https://pohl-michel.github.io/blog/articles/fourier-glrt-graph-classification/article.html); a summary is provided in this README.

<br>
<div align="center">
  <img src="brain_as_graph.png" width="350"/>
  <br>
  <sub>Brain representation as a graph, whose nodes and edge weights correspond to different regions and the connectivity between those regions, respectively. </sub>
</div>
<br>

# Data

The file "subjects_data.mat" contains statistical features extracted from segmented brain FDG-PET images. Those 142 images were provided by "La Timone" Hospital (Marseille) and correspond to 61 healthy control subjects and 81 patients with Alzheimer's disease. Each brain image was segmented into 116 regions of interest (ROIs) using WFU-PickAtlas. For each region, the first four moments (mean, variance, skewness, and kurtosis) and the entropy are computed. The resulting data are stored as two tensors of size 116 × 5 × *N*, where *N* denotes the number of healthy controls or Alzheimer's patients.

# Methods

The classification pipeline can be run using the file "classification_main.m". For each class (healthy control or Alzheimer’s disease), we construct a representative undirected complete graph, whose nodes represent brain regions. Each region's 5D-feature vector is projected to a scalar value along a direction $\alpha \in \mathbb{R}^5$, and edge weights are computed with a Gaussian kernel to reflect similarity between regions.

The Fourier transform of the input is expected to lie mostly in the subspace spanned by the first $K$ graph-Laplacian eigenvectors associated with the lowest eigenvalues. Higher-frequency components are treated as additive white centered Gaussian noise. Following an equal-prior GLRT decision rule, the input signal is assigned to the class for which the energy of its low-frequency projection is the greatest. 


# Results

The classifier is evaluated using leave-one-out evaluation, using *K*=3. The positive class corresponds to the Alzheimer's patients.


| Feature projection | Value of $\alpha$ | Sensitivity | Specificity | F1 score |
|---|---|---:|---:|---:|
| Equal weighting of all five features | $(0.2, 0.2, 0.2, 0.2, 0.2)$ | 0.91 | 0.69 | 0.85 |
| Mean/variance-focused weighting | $(0.5, 0.5, 0.0, 0.0, 0.0)$ | 0.67 | 0.95 | 0.78 |

These results suggest that simple linear combinations of the five regional statistics can already produce meaningful classification behavior, with different trade-offs between sensitivity and specificity.


# How to reference

If you reuse this report, these figures, or the code, please reference:

Michel Pohl, *Aide au diagnostic de la maladie d'Alzheimer par une méthode de graph matching*, technical report, Centrale Méditerranée, 2016.

# Acknowledgements

This work was conducted in collaboration with Fresnel Institute under the supervision of Mouloud Adel. Image processing, including tensor construction and statistical feature design, was conducted by Imène Garali. Further tensor-data exploration and preprocessing were initially conducted together with Yassine Zniyed and Kaoutar Abdelalim.