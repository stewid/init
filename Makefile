.PHONY: workstation
workstation:
	ansible-playbook workstation.yml -K

.PHONY: gpg
gpg:
	ansible-playbook gpg.yml -K
