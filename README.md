# From aging to Alzheimer’s disease: brain DNA methylation changes in late life
David Lukacsovich, Juan I. Young, Lissette Gomez, Michael A. Schmidt, Wei Zhang, Brian W. Kunkle, Xi Chen, Eden R. Martin, Lily Wang

## Citing this repository

To be added

### Description

This github repository includes scripts used for the analyses in the above manuscript. 

Aging is a major risk factor for Alzheimer’s disease (AD), but the molecular processes linking aging to AD remain unclear. We studied brain DNA methylation (DNAm) changes in normal aging versus AD in late life. Our comprehensive meta-analysis of two large cohorts of postmortem prefrontal cortex samples from subjects over 65 years old identified numerous DNAm differences consistently associated with aging in both cohorts, highlighting key genes such as ELOVL2, ISM1, and KLF14, which are implicated in various aging processes. These DNAm differences are predominantly hypermethylated, enriched in promoter regions, and associated with genes involved in immune processes and metabolic functions. Our results also revealed significant overlaps between aging-associated DNAm differences and those involved in AD, supporting the hypothesis that aging and AD are interconnected at the molecular level. Intriguingly, nearly all DNAm differences significantly associated with both age (at death) and AD Braak stage showed concordant effect sizes in the same direction. Our study provides valuable insights into the aging-associated epigenetic landscape and its potential implications for AD. As aging and AD are intertwined, targeting age-related epigenetic modifications may offer new therapeutic strategies for AD.

### 1. Study cohorts, Preprocessing of DNA methylation data

| File                 | Dataset | Link |
|----------------------|-------------|-------------|
| code/markdown/01a_prepare_BDR_data.Rmd        |   BDR  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01a_prepare_BDR_data.Rmd) |
| code/markdown/01a_prepare_Rosmap_data.Rmd         |   Rosmap  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01a_prepare_Rosmap_data.Rmd) |
| code/markdown/01b_preprocess_BDR_data.Rmd        |   BDR  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01b_preprocess_BDR_data.Rmd) |
| code/markdown/01b_preprocess_Rosmap_data.Rmd         |   Rosmap  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01b_preprocess_Rosmap_data.Rmd) |

### 2. Single cohort and Meta analysis

| File                 | Link |
|----------------------|-------------|
| code/markdown/02a_associate_data.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02a_associate_data.Rmd) |
| code/markdown/02b_association_meta_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02b_association_meta_analysis.Rmd) |
| code/markdown/02c_association_signif_probes.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02c_association_signif_probes.Rmd) |

### 3. Assess cometh dmr results

| File                 | Link |
|----------------------|-------------|
| code/markdown/03a_cometh_dmr.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03a_cometh_dmr.Rmd) |
| code/markdown/03b_cometh_dmr_meta_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03b_cometh_dmr_meta_analysis.Rmd) |
| code/markdown/03c_Annotate_combp.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03c_Annotate_combp.Rmd) |
| code/markdown/03d_merge_cometh_dmr_combp.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03d_merge_cometh_dmr_combp.Rmd) |
| code/markdown/03e_pathway_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03e_pathway_analysis.Rmd ) |
| code/markdown/03f_pathway_analysis_figures.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03f_pathway_analysis_figures.Rmd) |

### 4. Correlate expression in brain and blood samples

| File                 | Link |
|----------------------|-------------|
| code/markdown/04a_brain_blood_correlation.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/04a_brain_blood_correlation.Rmd) |

### 5. Evaluate consistency against ad results

| File                 | Link |
|----------------------|-------------|
| code/markdown/05a_get_DNAm_Data.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05a_get_DNAm_Data.Rmd) |
| code/markdown/05b_preprocess_DNAm_Data.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05b_preprocess_DNAm_Data.Rmd) |
| code/markdown/05c_get_DNAm_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05c_get_DNAm_residuals.Rmd) |
| code/markdown/05d_get_DMR_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05d_get_DMR_residuals.Rmd) |
| code/markdown/05e_get_RNA_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05e_get_RNA_residuals.Rmd) |
| code/markdown/05f_associate_RNA_to_DNAm.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05f_associate_RNA_to_DNAm.Rmd) |
| code/markdown/05g_evaluate_association_consistency.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05g_evaluate_association_consistency.Rmd) |

### 6. Assessment Plots

| File                 | Link |
|----------------------|-------------|
| code/markdown/06a_aging_vs_ad_miami.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06a_aging_vs_ad_miami.Rmd) |
| code/markdown/06b_venn_diagram.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06b_venn_diagram.Rmd) |
| code/markdown/06c_epigenetic_association.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06c_epigenetic_association.Rmd) |
| code/markdown/06d_check_against_miamiad.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06d_check_against_miamiad.Rmd) |
| code/markdown/06e_get_matched_samples.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06e_get_matched_samples.Rmd) |
