.PHONY: develop build switch clean

develop:
	nix develop --command 'zsh' || true

build:
	@nh os build $(if $(HOSTNAME),-H $(HOSTNAME)) .

switch:
	@nh os switch $(if $(HOSTNAME),-H $(HOSTNAME)) .

clean:
	@nh clean all --keep 3 --keep-since 120h
