Zero2Prod
=========
This project is based on the book [ZERO TO PRODUCTION IN RUST](https://www.zero2prod.com/index.html).
# Description
The goal of this project is to learn rust, by making a news letter from zero to production. During the reading of the book I'll learn how to build an API with telemetry, subscriber handling, Error Handling, API security and fault-tolerance.
# Install & Run
Whe will need [Rust](https://www.rust-lang.org/) and [docker](https://www.docker.com/) to run this project. We'll also need PSQL and SQLX.
## Linux Install 
### PSQL
```
sudo apt update

sudo apt install postgresql-client
```
### SQLX
```
cargo install --version='~0.6' sqlx-cli --no-default-features --features rustls,prostgres
```
## Run Project
### Local
```
cd {DIR_OF_INSTALL}/zero2prod
./init_db

\\ Build Project
cargo build

\\ Run Project
cargo run

\\ Test Project
cargo test
```
### Docker 
```
docker build --tag zero2prod --file Dockerfile .

docker run -p 8000:8000 zero2prod
```
# Credit
[Offical Github](https://github.com/LukeMathWalker/zero-to-production)
### Book
![image](https://github.com/tenuckii/zero2prod/assets/152208465/45a8cb0a-a79e-4dc9-b5c6-e0d52ef82dfd)
