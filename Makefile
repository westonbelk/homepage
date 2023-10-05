update: update-writeups


update-writeups:
	find _writeups/* -maxdepth 0 -type d -exec rm -rf {} +
	cp -r ../sec-writeups/CTFs/* _writeups/
	find _writeups/ -type f -exec sed -i 's/\.md)/)/g' {} +

submodules: update-submodules

update-submodules:
	git submodule update --init --remote --recursive

# Running locally
#
# git clone ssh://git@github.com/github/pages-gem
# cd pages-gem/
# make image
#
# cd homepage/ (this repository)
# docker run --rm -it -v .:/src/site -p4000:4000 --security-opt label=disable gh-pages
#