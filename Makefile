.PHONY: update boot
update:
	git add .
	nh os switch .
boot:
	git add .
	nh os boot .
