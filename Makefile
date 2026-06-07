.PHONY: update boot private wsl wsltar
update:
	git add .
	nh os switch .
boot:
	git add .
	nh os boot .
