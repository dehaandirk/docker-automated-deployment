repo/wordpress:  
  dockerng.image_present:
    - force: true
    - name: repo/wordpress:latest

wordpress:  
  dockerng.running:
    - name: wordpress
    - image: repo/wordpress:latest
    - port_bindings: 80:80