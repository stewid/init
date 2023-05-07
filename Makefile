.PHONY: workstation
workstation:
	ansible-playbook --ask-become-pass workstation.yml

.PHONY: gpg
gpg:
	ansible-playbook --ask-become-pass gpg.yml

.PHONY: r
r:
	ansible-playbook --ask-become-pass r.yml

.PHONY: slurm
slurm:
	ansible-playbook --ask-become-pass slurm.yml
