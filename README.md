# macbook-bootstrap

A project that I use personally to automate my MacBook
provisioning using Ansible. There are two parts to this
project:

- `bootsrap.sh`: A SHELL script that gets the system ready with both Ansible and Homebrew. I prefer installing a local python environment to operate from using pyenv.

- `playbook.yml`: The base playbook we use to call our Ansible roles which performs the majority of the provisioning of the system.

## Usage

Run bootstrap script:
```bash
curl -s https://raw.githubusercontent.com/dude051/macbook-bootstrap/master/bootstrap.sh | /bin/bash
```

Run Ansible:
```bash
ansible-playbook -i ./hosts playbook.yml --verbose
```
