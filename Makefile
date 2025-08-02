.PHONY: build switch clean

build:
	@nh os build .

switch:
	@nh os switch .

clean:
	@nh clean all --keep 3 --keep-since 120h