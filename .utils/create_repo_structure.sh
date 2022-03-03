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
    # create file for referencing operation guide
    touch ./docs/_operational_guide.adoc

    # Variables for operational guides
    OPERATIONAL_GUIDE_DIR="docs/operational_guide"
    SPECIFIC_DIR="docs/operational_guide/partner_editable"
    IMAGES_DIR="docs/operational_guide/images"
    TYPE='operational'

    # Creating directories.
    mkdir -p ${SPECIFIC_DIR}
    mkdir -p ${IMAGES_DIR}

    # Copying content.
    rsync -avP ${BOILERPLATE_DIR}/.images/ ${IMAGES_DIR}
    rsync -avP ${BOILERPLATE_DIR}/${TYPE}/.specific/ ${SPECIFIC_DIR} 
}

function mig_guide_setup() {
    # create file for referencing migration Guide
    touch ./docs/_migration_guide.adoc

    # Variables for migration Guides
    MIGRATION_GUIDE_DIR="docs/migration_guide"
    SPECIFIC_DIR="docs/migration_guide/partner_editable"
    IMAGES_DIR="docs/migration_guide/images"
    TYPE='migration'

    # Creating directories.
    mkdir -p ${SPECIFIC_DIR}
    mkdir -p ${IMAGES_DIR}

    # Copying content.
    rsync -avP ${BOILERPLATE_DIR}/.images/ ${IMAGES_DIR}
    rsync -avP ${BOILERPLATE_DIR}/${TYPE}/.specific/ ${SPECIFIC_DIR} 
}



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
touch .nojekyll
git add -A docs/
git add .github/
git add .nojekyll
exit
done