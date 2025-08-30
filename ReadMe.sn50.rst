


.github/workflows/publish-container.yml

it was originally docker-publish 
found on their action list, it does publish to ghcr 
no need for the old one that i use (eg last used in cgmlstfinder)

pull this one via
docker pull ghcr.io/tin6150/snp-pipeline:master

podman didn't work, complain insufficient range in subuid subgid, wants ridiculous range 
tin:1559974988:65536 
didn't work

so switched to apptainer on samoa

singularity pull --name snp-pipeline.sif  docker://ghcr.io/tin6150/snp-pipeline:master
# cfsan , had a sn50 branch, but turn out they had a Dockerfile, trying to get that to work out of master branch


2025.0830
