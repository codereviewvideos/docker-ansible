.PHONY: create_role install_role run_playbook

create_role:
	@docker run --rm \
		-v $(CURDIR)/roles:/etc/ansible/roles \
		williamyeh/ansible:alpine3 \
		ansible-galaxy init \
			$(role) \
			--init-path=/etc/ansible/roles

install_role:
	@docker run --rm \
		-v $(CURDIR):/crv-ansible \
		-w /crv-ansible \
		williamyeh/ansible:alpine3 \
		ansible-galaxy install $(role)

run_playbook:
	@docker run --rm \
		-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
		-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
		-v $(CURDIR):/crv-ansible \
		-w /crv-ansible \
		williamyeh/ansible:alpine3 \
		ansible-playbook -i production site.yml