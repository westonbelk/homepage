update: update-writeups


update-writeups:
	find _writeups/* -maxdepth 0 -type d -exec rm -rf {} +
	cp -r ../sec-writeups/CTFs/* _writeups/
	find _writeups/ -type f -exec sed -i 's/\.md)/)/g' {} +

submodules: update-submodules

update-submodules:
	git submodule update
