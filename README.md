<!-- markdownlint-disable -->

# Overview

This repository contains work on graph-structured data binary classification based on a generalized likelihood ratio test (GLRT) and graph Fourier transforms. The general framework was based on previous work from Hu et al. (["Matched signal detection on graphs: Theory and application to brain imaging data classification"](https://doi.org/10.1016/j.neuroimage.2015.10.026), NeuroImage, 2016). I re-derived the GLRT formulation for specific hypotheses (bandlimited graph-signal model) and applied it to data derived from brain imaging of Alzheimer's patients with PET. I also explored optimization of brain region-independent weights (corresponding to each image property) to maximize classification accuracy. This project was carried out during my engineering studies at [Centrale Méditerannée](https://www.centrale-mediterranee.fr/en) in collaboration with [Fresnel Institute](https://www.fresnel.fr/wp/en/). See the full project report in French [here](graph_classification_report_french_2016.pdf).


# How to reference

If you reuse this report, figures, or code, please reference:

Michel Pohl, *Aide au diagnostic de la maladie d'Alzheimer par une méthode de graph matching*, technical report, Centrale Méditerranée, 2016.

Note: Work conducted in collaboration with Fresnel Institute under the supervision of Mouloud Adel.