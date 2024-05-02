use std::net::TcpListener;

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Failed tp bind random port");

    let port = listener.local_addr().unwrap().port();

    println!("127.0.0.1:{}", port);

    zero2prod::run(listener)?.await
}
