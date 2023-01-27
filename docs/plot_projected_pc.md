# Plot projected PCs

Once `project_pc.sh` finished, please run `Rscript plot_projected_pc.R` to plot all the projected PCs. This script also generates a text file containing per-sample projected PCs **without including cohort-specific individual IDs**.

## Required packages

To run the script, please install the following packages.

```
install.packages(c("data.table", "hexbin", "optparse", "patchwork", "R.utils", "tidyverse"))
```

## Available options

```
Rscript plot_projected_pc.R \
  --sscore [path to .sscore output] \
  --phenotype-file [path to phenotype file] \
  --phenotype-col [phenotype column name]
  --covariate-file [path to covariate file] \
  --pc-prefix [prefix of PC columns: default "PC"] \
  --pc-num [number of PCs used in GWAS] \
  --ancestry [ancestry code: AFR, AMR, EAS, EUR, MID, or SAS] \
  --study [your study name] \
  --out [output name prefix]
```

The phenotype and covariate files should contain ID columns of the same name, which can either be just one column named `IID` or two columns named `FID` and `IID`. If the phenotype and covariates are contained within the same file, you should pass this filename to both `--phenotype-file` and `--covariate-file` flags. It is fine for these files to be gzip compressed.

Ancestry codes for `--ancestry` are from [the flagship paper](https://doi.org/10.1038/s41586-021-03767-x):

- African (AFR)
- Admixed American (AMR)
- East Asian (EAS)
- European (EUR)
- Middle Eastern (MID)
- South Asian (SAS)

If your cohort contains multiple ancestries, please use `--ancestry-file` and `--ancestry-col` to specify for each individual.

```
  --ancestry-file [path to ancestry file] \
  --ancestry-col [ancestry column name]
```
The named ancestry file (passed to `--ancestry-file`) should have the same ID columns as the phenotype and covariate files (see above).

If your cohort submits multiple analyses, please run the script with different `--phenotype-col`. It will automatically excludes samples without case/control status.

If your system doesn't have access to the Internet, please download a reference score file [here](https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_scores.txt.gz) and specify it via `--reference-score-file`.

## Upload

Please upload all the `.png` files and `.projected.pca.tsv.gz` file. Instructions for uploading can be found [here](https://docs.google.com/document/d/1XRQgDOEp62TbWaqLYi1RAk1OHVP5T3XZqfs_6PoPt_k/edit#heading=h.5qjedejw6g70).
