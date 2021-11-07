update: update-writeups


update-writeups:
	find _writeups/* -type d -maxdepth 0 -exec rm -rf {} +
	cp -r ../sec-writeups/CTFs/* _writeups/
	find _writeups/ -type f -exec gsed -i 's/\.md)/)/g' {} +

submodules: update-submodules

update-submodules:
	git submodule update
