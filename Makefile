lint: .lintyaml .lintansible .lintshell

.PHONY: clean init-uv lint update-uv

.lintansible: */*.yml
	uv run ansible-lint --config-file=.config/ansible-lint.yml .
	@touch $@

.lintshell: files/push-data-to-vault.sh
	shellcheck files/push-data-to-vault.sh
	@touch $@

.lintyaml: */*.yml
	uv run yamllint --config-file=.config/yamllint .
	@touch $@

clean:
	@/bin/rm -f .lint*

# --------------------------------

init-uv:
	uv python install 3.14
	uv init
	uv python pin python3.14
	uv add -r    requirements.raw
	uv export -o requirements.txt > /dev/null

update-uv:
	uv add -r    requirements.raw
	uv export -o requirements.txt > /dev/null
