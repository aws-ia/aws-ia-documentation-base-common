#!/bin/bash -e
# # Work in progress.
# exit 1

#Adds Options for the following: ((Help/Second Language) (-h | -l))
# Options for guide types: (Deployment | Operational | Migration) (-d | -o | -m)
# Options for program language types: (CFN | CDK | Terraform | EKS) (-c | -k | -t | -e)
while getopts hdomcktel  option
do
    case "${option}" in
      h )
          echo "Usage:"
          echo "Run './create_repo_structure.sh' with one guide type and one programming language to configure for English language only."
          echo "Run './create_repo_structure.sh -l' to add files for second language."
          echo "-- Guide Types --"
          echo "(-d)  Configure Deployment Guide"
          echo "(-o)  Configure Operational Guide"
          echo "(-m)  Configure Migration Guide"
          echo "-- Program Language --"
          echo "(-c)  Configure for CFN"
          echo "(-k)  Configure for CDK"
          echo "(-t)  Configure for Terraform"
          echo "(-e)  Configure for EKS"
          echo "-- Other --"
          echo "(-h)  Show usage and brief help"
          echo "(-l)  Use to add files for second language for translation"
          exit 0
          ;;
    # -- Guide Types --
      d )
          DEP_GUIDE="dep_guide_setup";;
      o)
          OPS_GUIDE="ops_guide_setup";;
      m )
          MIG_GUIDE="mig_guide_setup";;
    # -- Program language --
      c )
          PROG_LANG="cfn";;
      k)
          PROG_LANG="cdk";;
      t )
          PROG_LANG="tf";;
      e )
          PROG_LANG="eks";;
    # -- Other --
      l )
          CREATESECONDLANG="create_second_lang";;
      * )
          echo "this is in an invalid flag. Please see "-h" for help on valid flags"
          exit 0
          ;;
    esac
done

# Common variables
BOILERPLATE_DIR="docs/boilerplate"
BOILERPLATE_COMMON_DIR="docs/boilerplate/.common"


# Creates Standard English directory structure to the repo.
function dep_guide_setup() {
    case $PROG_LANG in
        cfn)
            TYPE="deployment_cfn"
            # Create metadata file for deployment guide
            echo ":type: cfn" > "docs/_deployment_guide.adoc"
            ;;
        cdk)
            TYPE="deployment_cdk"
            # Create metadata file for deployment guide
            echo ":type: cdk" > "docs/_deployment_guide.adoc"
            ;;
        tf)
            TYPE="deployment_terraform"
            # Create metadata file for deployment guide
            echo ":type: terraform" > "docs/_deployment_guide.adoc"
            ;;
        eks)
            TYPE="deployment_eks"
            # Create metadata file for deployment guide
            echo ":type: eks" > "docs/_deployment_guide.adoc"
            ;;
        *)
            echo -n "deployment guide type : unknown"
            ;;
    esac

    # Variables for deployment guides
    DEPLOYMENT_GUIDE_DIR="docs/deployment_guide"
    SPECIFIC_DIR="docs/deployment_guide/partner_editable"
    IMAGES_DIR="docs/deployment_guide/images"

    # Creating directories.
    mkdir -p ${SPECIFIC_DIR}
    mkdir -p ${IMAGES_DIR}

    # Copying content.
    rsync -avP ${BOILERPLATE_DIR}/.images/ ${IMAGES_DIR}
    rsync -avP ${BOILERPLATE_DIR}/${TYPE}/.specific/ ${SPECIFIC_DIR} 

    # TODO: Possibly add a section in here that looks for the repo name and 
    # then replaces the `:quickstart-project-name:` value in the _settings.adoc file to be the repo name

}

function ops_guide_setup() {
    case $PROG_LANG in
        cfn)
            TYPE="operational_cfn"
            # Create metadata file for operational guide
            echo ":type: cfn" > "docs/_operational_guide.adoc"
            ;;
        cdk)
            TYPE="operational_cdk"
            # Create metadata file for operational guide
            echo ":type: cdk" > "docs/_operational_guide.adoc"
            ;;
        tf)
            TYPE="operational_tf"
            # Create metadata file for operational guide
            echo ":type: tf" > "docs/_operational_guide.adoc"
            ;;
        eks)
            TYPE="operational_eks"
            # Create metadata file for operational guide
            echo ":type: cfn" > "docs/_operational_guide.adoc"
            ;;
        *)
            echo -n "operational guide type : unknown"
            ;;
    esac

    # Variables for operational guides
    OPERATIONAL_GUIDE_DIR="docs/operational_guide"
    SPECIFIC_DIR="docs/operational_guide/partner_editable"
    IMAGES_DIR="docs/operational_guide/images"

    # Creating directories.
    mkdir -p ${SPECIFIC_DIR}
    mkdir -p ${IMAGES_DIR}

    # Copying content.
    rsync -avP ${BOILERPLATE_DIR}/.images/ ${IMAGES_DIR}
    rsync -avP ${BOILERPLATE_DIR}/${TYPE}/.specific/ ${SPECIFIC_DIR} 
}

function mig_guide_setup() {
    case $PROG_LANG in
        cfn)
            TYPE="migration_cfn"
            # Create metadata file for migration guide
            echo ":type: cfn" > "docs/_migration_guide.adoc"
            ;;
        cdk)
            TYPE="migration_cdk"
            # Create metadata file for migration guide
            echo ":type: cdk" > "docs/_migration_guide.adoc"
            ;;
        tf)
            TYPE="migration_tf"
            # Create metadata file for migration guide
            echo ":type: tf" > "docs/_migration_guide.adoc"
            ;;
        eks)
            TYPE="migration_eks"
            # Create metadata file for migration guide
            echo ":type: eks" > "docs/_migration_guide.adoc"
            ;;
        *)
            echo -n "migration guide type : unknown"
            ;;
    esac

    # Variables for migration guides
    MIGRATION_GUIDE_DIR="docs/migration_guide"
    SPECIFIC_DIR="docs/migration_guide/partner_editable"
    IMAGES_DIR="docs/migration_guide/images"

    # Creating directories.
    mkdir -p ${SPECIFIC_DIR}
    mkdir -p ${IMAGES_DIR}

    # Copying content.
    rsync -avP ${BOILERPLATE_DIR}/.images/ ${IMAGES_DIR}
    rsync -avP ${BOILERPLATE_DIR}/${TYPE}/.specific/ ${SPECIFIC_DIR} 
}

# BOILERPLATE_DIR="docs/dg/boilerplate"
# SPECIFIC_DIR="docs/dg/partner_editable"
# # Creating directories.
# # mkdir -p ${GENERATED_DIR}/parameters
# # mkdir -p ${GENERATED_DIR}/regions
# # mkdir -p ${GENERATED_DIR}/services
# mkdir -p ${SPECIFIC_DIR}
# mkdir -p docs/images
# # mkdir -p .github/workflows

# # Copying content.
# # rsync -avP ${BOILERPLATE_DIR}/.images/ docs/images/
# # rsync -avP ${BOILERPLATE_DIR}/.specific/ ${SPECIFIC_DIR} --exclude .cdk --exclude .terraform

# # creating placeholders.
# # echo "// placeholder" > ${GENERATED_DIR}/parameters/index.adoc
# # echo "// placeholder" > ${GENERATED_DIR}/regions/index.adoc
# # echo "// placeholder" > ${GENERATED_DIR}/services/index.adoc
# # echo "// placeholder" > ${GENERATED_DIR}/services/metadata.adoc
# }

# Creates standard English and second language directory structures to the repo.
# function create_second_lang() {
# if [ ! -d "docs/partner_editable" ];
#  then
#    create_repo
#    create_second_lang_sub
#  else
#    BOILERPLATE_DIR="docs/boilerplate"
#    GENERATED_DIR="docs/generated"
#    SPECIFIC_DIR="docs/partner_editable"
#    create_second_lang_sub
#  fi
# }

# function create_second_lang_sub() {
# read -p "Please enter enter 2 character language code: " LANG_CODE
# LANG_DIR="docs/languages"
# SPECIFIC_LANG_DIR="docs/languages/docs-${LANG_CODE}"
# TRANSLATE_ONLY="docs/languages/docs-${LANG_CODE}/translate-only"
# LANG_FOLDER="docs-${LANG_CODE}"
# mkdir -p ${LANG_DIR}
# mkdir -p ${SPECIFIC_LANG_DIR}
# mkdir -p ${TRANSLATE_ONLY}
# rsync -avP ${SPECIFIC_DIR}/ ${SPECIFIC_LANG_DIR}/partner_editable --exclude .cdk --exclude .terraform
# rsync -avP ${BOILERPLATE_DIR}/*.adoc ${TRANSLATE_ONLY} --exclude *.lang.adoc --exclude index.adoc --exclude _layout_cfn.adoc --exclude planning_deployment.adoc
# rsync -avP ${BOILERPLATE_DIR}/_layout_cfn.lang.adoc ${SPECIFIC_LANG_DIR}/_layout_cfn.adoc
# rsync -avP ${BOILERPLATE_DIR}/index.lang.adoc ${SPECIFIC_LANG_DIR}/index.adoc
# rsync -avP ${BOILERPLATE_DIR}/planning_deployment.lang.adoc ${TRANSLATE_ONLY}/planning_deployment.adoc
# rsync -avP ${BOILERPLATE_DIR}/index-docinfo-footer.html ${TRANSLATE_ONLY}
# rsync -avP ${BOILERPLATE_DIR}/LICENSE ${TRANSLATE_ONLY}
# sed -i "" "s/docs-lang-code/${LANG_FOLDER}/g" ${SPECIFIC_LANG_DIR}/index.adoc
# }


#Creates CDK specific structures to the repo.
# function setup_cdk() {
# CDK_DIR=".cdk"
# create_repo
# rm -f ${BOILERPLATE_DIR}/cost.adoc
# rm -f ${SPECIFIC_DIR}/partner_editable/deployment_options.adoc
# rsync -avP ${BOILERPLATE_DIR}/.specific/${CDK_DIR}/cost.adoc ${BOILERPLATE_DIR}
# rsync -avP ${BOILERPLATE_DIR}/.specific/${CDK_DIR}/deployment_options.adoc ${SPECIFIC_DIR}
# rsync -avP ${BOILERPLATE_DIR}/.specific/${CDK_DIR}/deploy_steps.adoc ${SPECIFIC_DIR}
# sed -i "" "s/:parameters_as_appendix:/\/\/ :parameters_as_appendix:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :cdk_qs:/:cdk_qs:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :no_parameters:/:no_parameters:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :git_repo_url:/:git_repo_url:/g" ${SPECIFIC_DIR}/_settings.adoc
# }

#Creates Terraform specific structures to the repo.
# function setup_terraform() {
# TERRAFORM_DIR=".terraform"
# create_repo
# rm -f ${BOILERPLATE_DIR}/cost.adoc
# rm -f ${SPECIFIC_DIR}/partner_editable/deployment_options.adoc
# rsync -avP ${BOILERPLATE_DIR}/.specific/${TERRAFORM_DIR}/cost.adoc ${BOILERPLATE_DIR}
# rsync -avP ${BOILERPLATE_DIR}/.specific/${TERRAFORM_DIR}/deployment_options.adoc ${SPECIFIC_DIR}
# rsync -avP ${BOILERPLATE_DIR}/.specific/${TERRAFORM_DIR}/deploy_steps.adoc ${SPECIFIC_DIR}
# sed -i "" "s/:parameters_as_appendix:/\/\/ :parameters_as_appendix:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :terraform_qs:/:terraform_qs:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :no_parameters:/:no_parameters:/g" ${SPECIFIC_DIR}/_settings.adoc
# sed -i "" "s/\/\/ :git_repo_url:/:git_repo_url:/g" ${SPECIFIC_DIR}/_settings.adoc
# }


while true
do
#clear
# TODO: add in check : if not -l or -h then must have ONLY one of {Guide Types} & ONLY one of {Language Types} 
if [ $OPTIND -eq 1 ]; then create_repo; fi
shift $((OPTIND-1))
#printf "$# non-option arguments"
$DEP_GUIDE
$OPS_GUIDE
$MIG_GUIDE
# touch .nojekyll
# git add -A docs/
# git add .github/
# git add .nojekyll
exit
done