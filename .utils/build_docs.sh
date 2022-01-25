#!/bin/bash
set -e

# -----------
# ${parameter:+word}
#     If parameter is null or unset, nothing is substituted, 
#       otherwise the expansion of word is substituted.
#
# This is used to add values to variables if ${BUILD_PREVIEW_GUIDE} is unset. 
# - ex: a production build.
#
#



function build_guide_with_asciidoc_attributes(){
    if test -z ${BUILD_PREVIEW_GUIDE}; then 
        ASCIIDOC_ATTRIBUTES="-a production_build"
    fi
    set -x
    asciidoctor --base-dir docs/ --backend=html5 -o ${OUTPUT_FILE} -w --doctype=book -a toc2 ${ASCIIDOC_ATTRIBUTES} ${LAYOUT_FILE}
    mv docs/${OUTPUT_FILE} $(pwd)/
    set +x
}

# path to files showing which type of guide the repo has been configured to display.
DEPLOYMENTFILE=docs/_deployment_guide.adoc
OPERATIONALFILE=docs/_operational_guide.adoc
MIGRATIONFILE=docs/_migration_guide.adoc

# Check for deployment guide
if test -f "$DEPLOYMENTFILE"; then
    echo "== Generating Deployment Guide =="

    LAYOUT_FILE=docs/boilerplate/index_deployment_guide.adoc
    OUTPUT_FILE=index.html

#     if [[ "${BUILD_PREVIEW_GUIDE}" == "true" ]]; then
#         mkdir -p preview/
#         OUTPUT_FILE=preview/index.html
#     fi

    build_guide_with_asciidoc_attributes
fi

# Check for operations guide
if test -f "$OPERATIONALFILE"; then
    echo "== Generating Operations Guide =="

    mkdir -p operational/
    LAYOUT_FILE=docs/boilerplate/index_operational_guide.adoc
    OUTPUT_FILE=operational/index.html

#     if [[ "${BUILD_PREVIEW_GUIDE}" == "true" ]]; then
#         mkdir -p operational/preview/
#         OUTPUT_FILE=operational/preview/index.html
#     fi

    build_guide_with_asciidoc_attributes
fi

# Check for migration guide
if test -f "$MIGRATIONFILE"; then
    echo "== Generating Migration Guide =="

    mkdir -p migration/
    LAYOUT_FILE=docs/boilerplate/index_migration_guide.adoc
    OUTPUT_FILE=migration/index.html

#     if [[ "${BUILD_PREVIEW_GUIDE}" == "true" ]]; then
#         mkdir -p migration/preview/
#         OUTPUT_FILE=migration/preview/index.html
#     fi

    build_guide_with_asciidoc_attributes

fi
