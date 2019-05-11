FROM node:12.1.0-alpine AS build-node

RUN apk add --no-cache git

RUN git clone https://github.com/Schanihbg/exjobb-website.git

WORKDIR exjobb-website/

RUN npm install
RUN npm run build

RUN cp -r dist/ dist_baseline/
RUN cp -r dist/ dist_gzip/
RUN cp -r dist/ dist_bundling/

RUN git checkout minify 
RUN npm run build
RUN cp -r dist/ dist_minify/

RUN git checkout tree_shaking
RUN npm run build
RUN cp -r dist/ dist_tree_shaking/

RUN git checkout code_splitting
RUN npm run build
RUN cp -r dist/ dist_code_splitting/

RUN git checkout all
RUN npm run build
RUN cp -r dist/ dist_all/

#Building apache2 for baseline test
FROM httpd:2.4.39-alpine AS apache_baseline

COPY --from=build-node /exjobb-website/dist_baseline /usr/local/apache2/htdocs

#Building apache2 for gzip test
FROM httpd:2.4.39-alpine AS apache_gzip

RUN sed -i \
        -e 's/^#\(Include .*httpd-vhosts.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_deflate.so\)/\1/' \
        conf/httpd.conf

COPY ./httpd-vhosts.conf conf/extra/httpd-vhosts.conf
COPY --from=build-node /exjobb-website/dist_gzip /usr/local/apache2/htdocs

#Building apache2 for minification test
FROM httpd:2.4.39-alpine AS apache_minification

COPY --from=build-node /exjobb-website/dist_minify /usr/local/apache2/htdocs

#Building apache2 for bundling test
FROM httpd:2.4.39-alpine AS apache_bundling

COPY --from=build-node /exjobb-website/dist_bundling /usr/local/apache2/htdocs

#Building apache2 for tree shaking test
FROM httpd:2.4.39-alpine AS apache_tree_shaking

COPY --from=build-node /exjobb-website/dist_tree_shaking /usr/local/apache2/htdocs

#Building apache2 for code spliting test
FROM httpd:2.4.39-alpine AS apache_code_splitting

COPY --from=build-node /exjobb-website/dist_code_splitting /usr/local/apache2/htdocs

#Building apache2 for all test
FROM httpd:2.4.39-alpine AS apache_all

RUN sed -i \
        -e 's/^#\(Include .*httpd-vhosts.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_deflate.so\)/\1/' \
        conf/httpd.conf

COPY ./httpd-vhosts.conf conf/extra/httpd-vhosts.conf
COPY --from=build-node /exjobb-website/dist_all /usr/local/apache2/htdocs
