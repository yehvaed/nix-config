.PHONY: build
build:
	nh os build . -- --impure

.PHONY: switch
switch:
	nh os switch . -- --impure
