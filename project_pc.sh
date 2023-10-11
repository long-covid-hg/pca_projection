#!/bin/bash

set -eu
################################################################################
# Please fill in the below variables
################################################################################
# Metadata
STUDY_NAME=""
ANALYST_LAST_NAME=""
DATE="$(date +'%Y%m%d')"
OUTNAME="${STUDY_NAME}.${ANALYST_LAST_NAME}.${DATE}"
################################################################################
# Location of downloaded input files
PCA_LOADINGS=""
PCA_AF=""
################################################################################
# Location of imputed genotype files
# [Recommended]
# PLINK 2 binary format: a prefix (with directories) of .pgen/.pvar/.psam files
PFILE=""
# [Acceptable]
# PLINK 1 binary format: a prefix of .bed/.bim/.fam files
BFILE=""
################################################################################
# Location of plink2 executable
# [OPTIONAL]
# Provide full path of plink2 binary if you receive an error about the plink2
# command not being found or not being the correct version
PLINK2PATH=""
################################################################################


function error_exit() {
  echo "${1:-"Unknown Error"}" 1>&2
  exit 1
}

# Input checks
if [[ -z "${STUDY_NAME}" ]]; then
  error_exit "Please specify \$STUDY_NAME."
fi

if [[ -z "${ANALYST_LAST_NAME}" ]]; then
  error_exit "Please specify \$ANALYST_LAST_NAME."
fi

if [[ -z "${PCA_LOADINGS}" ]]; then
  error_exit "Please specify \$PCA_LOADINGS."
fi

if [[ -z "${PCA_AF}" ]]; then
  error_exit "Please specify \$PCA_AF."
fi

if [[ -n "${PFILE}" ]]; then
  input_command="--pfile ${PFILE}"
elif [[ -n "${BFILE}" ]]; then
  input_command="--bfile ${BFILE}"
else
  error_exit "Either \$PFILE or \$BFILE should be specified"
fi

# plink 2 check (first check provided path, if any, is correct then check default plink2 alias)
if [ ! -z "$PLINK2PATH" ]
then
   if ! command -v "$PLINK2PATH" &> /dev/null
   then
      echo "Provided plink2 path is not valid - please double check it"
      exit 1
   else
      plink2="$PLINK2PATH"
   fi
else
   if ! command -v plink2 &> /dev/null
   then
      echo "plink2 command cannot be found - please specify correct location of plink2 executable"
      exit 1
   else
      plink2="plink2"
   fi
fi


# Run plink2 --score
$plink2 \
  ${input_command} \
  --score ${PCA_LOADINGS} \
  variance-standardize \
  cols=-scoreavgs,+scoresums \
  list-variants \
  header-read \
  --score-col-nums 3-12 \
  --read-freq ${PCA_AF} \
  --out ${OUTNAME}
