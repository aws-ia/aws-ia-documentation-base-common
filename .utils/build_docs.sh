#!/bin/bash
set -e

function build_deployment_guide_with_asciidoc_attributes(){
    set +x
    asciidoctor --base-dir docs/ --backend=html5 -o ../docs/index.html -w --doctype=book -a toc2 -a production_build docs/boilerplate/index_deployment_guide.adoc
    set -x
}

function build_operational_guide_with_asciidoc_attributes(){
    set +x
    asciidoctor --base-dir docs/ --backend=html5 -o ../docs/index_operational.html -w --doctype=book -a toc2 -a production_build docs/boilerplate/index_operational_guide.adoc
    set -x
}

function build_migration_guide_with_asciidoc_attributes(){
    set +x
    asciidoctor --base-dir docs/ --backend=html5 -o ../docs/index_migration.html -w --doctype=book -a toc2 -a production_build docs/boilerplate/index_migration_guide.adoc
    set -x
}

DEPLOYMENTFILE=docs/_deployment_guide.adoc
OPERATIONALFILE=docs/_operational_guide.adoc
MIGRATIONFILE=docs/_migration_guide.adoc

if test -f "$DEPLOYMENTFILE"; then
    build_deployment_guide_with_asciidoc_attributes
fi


if test -f "$OPERATIONALFILE"; then
    build_operational_guide_with_asciidoc_attributes
fi


if test -f "$MIGRATIONFILE"; then
    build_migration_guide_with_asciidoc_attributes
fi
