FROM haskell:8.6.3

WORKDIR /app
ADD . /app

RUN stack setup
RUN stack build -j 1 aeson
RUN stack build --test --copy-bins

EXPOSE 3001

CMD stack exec html-haskell-exe