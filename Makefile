update: update-writeups


update-writeups:
	find _writeups/* -maxdepth 0 -type d -exec rm -rf {} +
	cp -r ../sec-writeups/CTFs/* _writeups/
	find _writeups/ -type f -exec sed -i 's/\.md)/)/g' {} +

submodules: update-submodules

update-submodules:
	git submodule update --init --remote --recursive


run: 
	docker run --rm -it -v $(shell pwd):/src/site -p4000:4000 gh-pages sh -c "bundle add webrick && bundle install && jekyll serve -H 0.0.0.0 -P 4000"

#
