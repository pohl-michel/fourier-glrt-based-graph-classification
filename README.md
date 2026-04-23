<!-- markdownlint-disable -->

# Overview

This repository contains work on binary classification of graph-structured data based on spectral graph methods and a generalized likelihood ratio test (GLRT). The general framework was based on matched-signal-detection framework from Hu et al. (["Matched signal detection on graphs: Theory and application to brain imaging data classification"](https://doi.org/10.1016/j.neuroimage.2015.10.026), NeuroImage, 2016), which explores classification of signals on graphs by projecting them onto Fourier bases and comparing competing representative graph models for each class via a likelihood-ratio decision rule. 

In this work, I implement the GLRT rule in the bandlimited graph-signal setting and apply it to Alzheimer's disease detection from PET images, where each region represents one node of the input graph to classify. Each region is characterized by a linear combination of five relevant statistical features, proposed by Garali et al. ([Region-based brain selection and classification on pet images for Alzheimer's disease computer aided diagnosis](https://doi.org/10.1109/ICIP.2015.7351045)). This project was carried out during my engineering studies at [Centrale Méditerranée](https://www.centrale-mediterranee.fr/en) in collaboration with [Fresnel Institute](https://www.fresnel.fr/wp/en/). See the full technical report in French [here](graph_classification_report_french_2016.pdf).


# How to reference

If you reuse this report, figures, or code, please reference:

Michel Pohl, *Aide au diagnostic de la maladie d'Alzheimer par une méthode de graph matching*, technical report, Centrale Méditerranée, 2016.

Note: Work conducted in collaboration with Fresnel Institute under the supervision of Mouloud Adel.