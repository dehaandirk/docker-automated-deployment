wordpress_app:  
  dockerng.running:
    - name: wordpress_app
    - image: repo/wordpress:latest
    - port_bindings: 80:80
    - environment:
      - WORDPRESS_DB_HOST: db:3306
      - WORDPRESS_DB_PASSWORD: wordpress
    - links: wordpress_db:mysql

wordpress_db:  
  dockerng.running:
    - name: wordpress_db
    - image: repo/mariadb:latest
    - ports: 3306/tcp    
    - binds: ./mysql:/var/lib/mysql:rw
    - environment:
      - MYSQL_ROOT_PASSWORD: wordpress
      - MYSQL_DATABASE: wordpress
      - MYSQL_USER: wordpress
      - MYSQL_PASSWORD: wordpress