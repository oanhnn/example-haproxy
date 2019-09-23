# Example HAProxy

An example about config HAProxy with SSL and multi backend

## Requirements

- Docker and docker-compose

## Usage

- Setup your domain point to your server. In this example, my domain is `example.com`
   
- Get SSL from Letsencrypt by script `get-ssl.sh`
  
  ```bash
  $ ./get-ssl.sh example.com,api.example.com,img.example.com name@example.com
  ```
  The script will make `example.com.pem` file in root folder of project. 

- Run stack
  
  ```bash
  $ docker-compose up -d
  ```

- Test
  
  ```bash
  # Test matching domains to backends and fallback to web
  $ curl -H "Host: api.example.com" https://127.0.0.1/
  $ curl -H "Host: cdn.example.com" https://127.0.0.1/
  $ curl -H "Host: example.com"     https://127.0.0.1/
  $ curl -H "Host: abc.com"         https://127.0.0.1/

  # Test force redirect to HTTPS
  $ curl -H "Host: api.example.com" -I http://127.0.0.1/
  $ curl -H "Host: cdn.example.com" -I http://127.0.0.1/
  $ curl -H "Host: example.com"     -I http://127.0.0.1/

  # Test response content-type
  $ curl -H "Host: api.example.com" -I https://127.0.0.1/api
  $ curl -H "Host: cdn.example.com" -I https://127.0.0.1/img/avatar.jpg
  $ curl -H "Host: example.com"     -I https://127.0.0.1/
  ```

## Contributing

All code contributions must go through a pull request and approved by a core developer before being merged. 
This is to ensure proper review of all the code.

Fork the project, create a feature branch, and send a pull request.

If you would like to help take a look at the [list of issues](https://github.com/oanhnn/example-haproxy/issues).

## License

This project is released under the MIT License.   
Copyright © 2019 [Oanh Nguyen](https://github.com/oanhnn)   
Please see [License File](https://github.com/oanhnn/example-haproxy/blob/master/LICENSE) for more information.
