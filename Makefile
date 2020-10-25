.PHONY: workstation
workstation:
	ansible-playbook workstation.yml -K

.PHONY: gpg
gpg:
	ansible-playbook gpg.yml -K

.PHONY: slurm
slurm:
	ansible-playbook slurm.yml -K
