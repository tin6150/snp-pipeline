


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





Dev notes and branches
----------------------

master
	maybe working with corretto:23 (latest, but non LTS).


rocky:9
on the sn50 branch, that version of github/workflow yaml need to have the clause to build on this branch, not needed in  master branch (the generic version of the yaml would suffice).

wget for VarScan got 404.   apparently that code was disabled since upstream.


deb: 13
forked to use debian 11 (bulleye, as that worked well before for other project).
using the Dockerfile I wrote after all.
changed to trixie, current stable (ie ver 13).
pip3 install snp-pipeline return an error (can see it in wsl:deb)
so skipping that and install from git repo instead.
